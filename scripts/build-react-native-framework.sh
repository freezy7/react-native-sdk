#!/bin/bash
set -euo pipefail

script_dir="$(cd "$(dirname "$0")" && pwd)"
sdk_repo="$(cd "$script_dir/.." && pwd)"
source_repo="${RN_FRAMEWORK_SOURCE_REPO:-$sdk_repo/../SPMProject4}"
minimum_ios="${RN_FRAMEWORK_MIN_IOS:-15.1}"
requested_configuration="all"
install_pods=1
build_frameworks=1
output_root=""

usage() {
    echo "Usage: $0 [--configuration Debug|Release|all] [--source PATH] [--output PATH] [--skip-pods] [--package-only]"
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        --configuration)
            requested_configuration="$2"
            shift 2
            ;;
        --source)
            source_repo="$2"
            shift 2
            ;;
        --output)
            output_root="$2"
            shift 2
            ;;
        --skip-pods)
            install_pods=0
            shift
            ;;
        --package-only)
            build_frameworks=0
            shift
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            echo "Unknown argument: $1" >&2
            usage >&2
            exit 2
            ;;
    esac
done

case "$requested_configuration" in
    Debug|Release)
        configurations=("$requested_configuration")
        ;;
    all)
        configurations=(Debug Release)
        ;;
    *)
        echo "--configuration must be Debug, Release, or all" >&2
        exit 2
        ;;
esac

brownfield="$source_repo/node_modules/.bin/brownfield"
project_file="$source_repo/ios/SPMProject4.xcodeproj/project.pbxproj"
package_dir="$source_repo/ios/.brownfield/package/build"

test -x "$brownfield" || {
    echo "Brownfield CLI not found. Run npm ci in $source_repo first." >&2
    exit 1
}
test -f "$project_file" || {
    echo "Xcode project not found: $project_file" >&2
    exit 1
}

react_native_version="$(node -p "require('$source_repo/package.json').dependencies['react-native']")"
release_version="${RN_FRAMEWORK_RELEASE_VERSION:-$react_native_version}"
output_root="${output_root:-${RN_FRAMEWORK_OUTPUT_DIR:-$sdk_repo/dist/$release_version}}"

echo "React Native version: $react_native_version"
echo "SDK release version: $release_version"
echo "Output directory: $output_root"

if rg -q 'IPHONEOS_DEPLOYMENT_TARGET = 26\.1;' "$project_file"; then
    echo "The source project still contains an iOS 26.1 deployment target." >&2
    exit 1
fi

if [[ "$install_pods" == "1" ]]; then
    (
        cd "$source_repo/ios"
        if [[ -f ../Gemfile.lock ]]; then
            bundle exec pod install
        else
            pod install
        fi
    )
fi

framework_names=(
    ReactNativeFramework
    hermesvm
    ReactBrownfield
    React
    ReactNativeDependencies
)

version_is_greater() {
    awk -v actual="$1" -v expected="$2" 'BEGIN {
        split(actual, a, ".")
        split(expected, e, ".")
        for (i = 1; i <= 3; i++) {
            if ((a[i] + 0) > (e[i] + 0)) exit 0
            if ((a[i] + 0) < (e[i] + 0)) exit 1
        }
        exit 1
    }'
}

verify_xcframework() {
    local xcframework="$1"
    local plist="$xcframework/Info.plist"
    local framework_name
    framework_name="$(basename "$xcframework" .xcframework)"

    test -f "$plist" || {
        echo "Missing XCFramework Info.plist: $plist" >&2
        return 1
    }

    local ios_slice_count
    ios_slice_count="$(find "$xcframework" -mindepth 1 -maxdepth 1 -type d -name 'ios-*' | wc -l | tr -d ' ')"
    [[ "$ios_slice_count" -ge 2 ]] && find "$xcframework" -mindepth 1 -maxdepth 1 -type d -name 'ios-*-simulator' | rg -q . || {
        echo "$framework_name does not contain both device and simulator slices" >&2
        return 1
    }

    while IFS= read -r binary; do
        local minimum_version
        minimum_version="$(xcrun vtool -show-build "$binary" 2>/dev/null | awk '/minos / { print $2; exit }' || true)"
        if [[ -n "$minimum_version" ]] && version_is_greater "$minimum_version" "$minimum_ios"; then
            echo "$binary declares minimum iOS $minimum_version, expected <= $minimum_ios" >&2
            return 1
        fi
    done < <(
        find "$xcframework" -path '*/ios-*/*' -type f -print0 \
            | xargs -0 file \
            | awk -F: '/Mach-O/ && $1 !~ / \(for architecture / { print $1 }' \
            | sort -u
    )
}

for configuration in "${configurations[@]}"; do
    build_folder="$source_repo/ios/.brownfield/build/$configuration"
    destination="$output_root/$configuration"

    if [[ "$build_frameworks" == "1" ]]; then
        echo "Building ReactNativeFramework ($configuration, minimum iOS $minimum_ios)"
        (
            cd "$source_repo"
            "$brownfield" package:ios \
                --scheme ReactNativeFramework \
                --configuration "$configuration" \
                --destination device simulator \
                --build-folder "$build_folder" \
                --extra-params "IPHONEOS_DEPLOYMENT_TARGET=$minimum_ios BUILD_LIBRARY_FOR_DISTRIBUTION=YES SKIP_INSTALL=NO CODE_SIGNING_ALLOWED=NO" \
                --no-install-pods \
                --local \
                --add-spm-package
        )
    else
        echo "Packaging existing Brownfield output as $configuration"
    fi

    artifacts_dir="$package_dir/spm-artifacts"
    test -d "$artifacts_dir" || {
        echo "Brownfield output not found: $artifacts_dir" >&2
        exit 1
    }

    mkdir -p "$destination"
    checksum_file="$destination/checksums.txt"
    : > "$checksum_file"

    for framework_name in "${framework_names[@]}"; do
        source_xcframework="$artifacts_dir/$framework_name.xcframework"
        target_xcframework="$destination/$framework_name.xcframework"
        archive_suffix=""
        if [[ "$configuration" == "Debug" ]]; then
            archive_suffix="-debug"
        fi
        archive="$destination/$framework_name$archive_suffix.xcframework.zip"

        test -d "$source_xcframework" || {
            echo "Missing Brownfield artifact: $source_xcframework" >&2
            exit 1
        }

        rm -rf "$target_xcframework" "$archive"
        ditto "$source_xcframework" "$target_xcframework"
        verify_xcframework "$target_xcframework"
        ditto -c -k --sequesterRsrc --keepParent "$target_xcframework" "$archive"
        checksum="$(swift package compute-checksum "$archive")"
        printf '%s  %s\n' "$checksum" "$(basename "$archive")" >> "$checksum_file"
    done

    {
        printf 'React Native: %s\n' "$react_native_version"
        printf 'Configuration: %s\n' "$configuration"
        printf 'Minimum iOS: %s\n' "$minimum_ios"
        printf 'Xcode: %s\n' "$(xcodebuild -version | tr '\n' ' ')"
        printf 'Source commit: %s\n' "$(git -C "$source_repo" rev-parse HEAD)"
        if [[ -n "$(git -C "$source_repo" status --porcelain)" ]]; then
            printf 'Source worktree: dirty\n'
        else
            printf 'Source worktree: clean\n'
        fi
    } > "$destination/build-info.txt"

    echo "Finished $configuration artifacts: $destination"
done

echo "All requested ReactNativeFramework packages passed deployment-target validation."
