// swift-tools-version: 5.9

import PackageDescription

let package = Package(
  name: "ReactNativeFrameworkPackage",
  platforms: [
    .iOS(.v14),
  ],
  products: [
    .library(name: "ReactNativeFramework", targets: ["ReactNativeFramework", "hermesvm", "ReactBrownfield", "React", "ReactNativeDependencies"]),
  ],
  targets: [
    .binaryTarget(
        name: "ReactNativeFramework",
        url: "https://github.com/freezy7/react-native-sdk/releases/download/0.84.1/ReactNativeFramework_debug.xcframework.zip",
        checksum: "cf18972fdd0ecd57e14aeb7115a5597973d3b5a5de1d14a2e40c2defd8ec4473"
    ),
    .binaryTarget(
        name: "hermesvm",
        url: "https://github.com/freezy7/react-native-sdk/releases/download/0.84.1/hermesvm_debug.xcframework.zip",
        checksum: "ef13f1d35dd24a48e4ed07f0ed9e9f8b2736fcbf98ca4aa5bb64857360cd392e"
    ),
    .binaryTarget(
        name: "ReactBrownfield",
        url: "https://github.com/freezy7/react-native-sdk/releases/download/0.84.1/ReactBrownfield_debug.xcframework.zip",
        checksum: "568ce5802e77851458e6cfc3d14cce74c3c36801852d15d569536295f9d9c51e"
    ),
    .binaryTarget(
        name: "React",
        url: "https://github.com/freezy7/react-native-sdk/releases/download/0.84.1/React_debug.xcframework.zip",
        checksum: "b483174b25f4a88c0d7a1d4f4e48555be36b814ae08fc3a74d1d72c15aa26d4f"
    ),
    .binaryTarget(
        name: "ReactNativeDependencies",
        url: "https://github.com/freezy7/react-native-sdk/releases/download/0.84.1/ReactNativeDependencies_debug.xcframework.zip",
        checksum: "7fa51c5bb7bd1c2fd134f39b50ad3c93aff3f709181b3dbc8621141070864d05"
    )
  ]
)
