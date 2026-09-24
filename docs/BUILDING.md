# ReactNativeFramework 打包与发布

## 1. 两个仓库的职责

- `SPMProject4`：React Native 0.84.1 源工程，包含 `ReactNativeFramework` Xcode target、JS bundle、CocoaPods 和 Brownfield 构建环境。
- `react-native-sdk`：Swift Package 分发仓库，保存打包脚本、发布文档和 `Package.swift`。生成的二进制默认写入本仓库的 `dist/`，但不提交 Git；正式分发通过 GitHub Release assets。

`ReactNativeFramework` 不能只修改 `Info.plist` 来降低最低系统。最低版本同时写入 Mach-O 的 `LC_BUILD_VERSION`，必须以正确的 `IPHONEOS_DEPLOYMENT_TARGET` 重新编译。

## 2. 当前版本约束

- React Native：由 `SPMProject4/package.json` 自动读取；当前为 0.84.1
- Brownfield：5.0.0
- 最低 iOS：15.1
- Xcode framework target：`ReactNativeFramework`
- 产物配置：Debug、Release
- 每套产物包含：
  - `ReactNativeFramework.xcframework`
  - `hermesvm.xcframework`
  - `ReactBrownfield.xcframework`
  - `React.xcframework`
  - `ReactNativeDependencies.xcframework`

SwiftPM 的一个 binary target 不能根据使用方的 Debug/Release 配置自动切换 URL。正式 `Package.swift` 应始终引用 Release 包；Debug 包用于本地排查或单独的调试清单。

## 3. 首次准备

```bash
cd /path/to/SPMProject4
npm ci
cd ios
bundle install
bundle exec pod install
```

确认源码工程没有未预期的变更：

```bash
git -C /path/to/SPMProject4 status --short
git -C /path/to/react-native-sdk status --short
```

`SPMProject4` 当前可能包含尚未提交的 framework target 初始化改动。打包脚本不会重置、覆盖或提交这些改动。

## 4. 一条命令生成 Debug 和 Release

```bash
cd /path/to/react-native-sdk
scripts/build-react-native-framework.sh
```

默认源码路径是与本仓库同级的 `SPMProject4`；也可以通过 `--source` 或 `RN_FRAMEWORK_SOURCE_REPO` 显式指定。默认输出为：

```text
dist/<React Native 版本>/
├── Debug/
│   ├── *.xcframework
│   ├── *.xcframework.zip
│   └── checksums.txt
└── Release/
    ├── *.xcframework
    ├── *.xcframework.zip
    └── checksums.txt
```

只构建一种配置：

```bash
scripts/build-react-native-framework.sh --configuration Debug
scripts/build-react-native-framework.sh --configuration Release
```

若 Xcode 构建已经成功、只需重新执行校验与压缩，可使用 `--package-only`。该选项只处理 `.brownfield/package/build/spm-artifacts` 当前内容，因此必须明确指定与现有产物一致的配置。

自定义源码或输出路径：

```bash
scripts/build-react-native-framework.sh \
  --source /path/to/SPMProject4 \
  --output /path/to/output
```

React Native 版本相同但 SDK 需要发布修订版时，单独指定 release 目录名：

```bash
RN_FRAMEWORK_RELEASE_VERSION=0.84.1-1 \
  scripts/build-react-native-framework.sh
```

依赖未变化时可以跳过 `pod install`：

```bash
scripts/build-react-native-framework.sh --skip-pods
```

## 5. 脚本执行内容

1. 检查 Brownfield CLI、Xcode 工程和错误的 iOS 26.1 配置。
2. 必要时执行 CocoaPods 安装。
3. 分别以 Debug、Release 构建设备与模拟器 slice。
4. 由 Brownfield 合并 XCFramework，并生成本地 SwiftPM 依赖集合。
5. 读取 `package.json` 的 React Native 版本，并将完整五件套复制到 `react-native-sdk/dist/<版本>/<Configuration>`。
6. 使用 `ditto` 生成保持符号链接和资源结构的 zip。
7. 使用 `swift package compute-checksum` 生成 checksum。
8. 读取每个 Mach-O 的 `LC_BUILD_VERSION`，拒绝任何最低系统高于 iOS 15.1 的产物。

不要使用 Finder 压缩 XCFramework，也不要只检查 framework 的 `Info.plist`。

## 6. 手工验收

检查主 framework 的设备与模拟器 slice：

```bash
xcrun vtool -show-build \
  dist/<版本>/Release/ReactNativeFramework.xcframework/ios-arm64/ReactNativeFramework.framework/ReactNativeFramework

xcrun vtool -show-build \
  dist/<版本>/Release/ReactNativeFramework.xcframework/ios-arm64_x86_64-simulator/ReactNativeFramework.framework/ReactNativeFramework
```

两者都必须显示：

```text
minos 15.1
```

同时检查：

- XCFramework 同时存在 `ios-arm64` 和 `ios-arm64_x86_64-simulator`。
- Debug 的 `ReactNativeFramework.framework` 内存在 `main.jsbundle`。
- Release 的 JS bundle 能由宿主 App 正常加载。
- 用 iOS 15.1 或可获得的最接近低版本真机/模拟器启动宿主 App。
- 用当前最高 iOS 模拟器再做一次启动验证。

## 7. GitHub Release 发布

建议每次发布新 tag，不覆盖已经被 SwiftPM 缓存的同名 asset。例如从 `0.84.1` 修订为 `0.84.1-1`：

1. 创建 GitHub Release/tag。
2. 上传 `dist/<版本>/Release/*.xcframework.zip`。Release 包是正式 SwiftPM 依赖。
3. 如需保留调试包，上传 Debug 目录中由脚本自动添加 `-debug` 后缀的 zip；XCFramework 内部名称不会改变。
4. 将 `Package.swift` 中 URL 更新到新 tag。
5. 从 `dist/<版本>/Release/checksums.txt` 复制对应 checksum。
6. 提交 `Package.swift` 和本文档，推送 release 分支。
7. 在一个干净的消费工程中删除 SwiftPM 缓存后重新解析并启动。

不要在未上传 asset 前更新 `Package.swift` checksum，否则所有使用方都会解析失败。

## 8. 常见问题

### App 提示 `Library not loaded`

先确认宿主 App 正常签名。模拟器构建也不要设置 `CODE_SIGNING_ALLOWED=NO` 后直接拿去安装运行；嵌入的动态 framework 需要 ad-hoc 签名。

### 产物仍显示 iOS 26.1

检查 `SPMProject4.xcodeproj` 中 `ReactNativeFramework` 的 Debug/Release 配置，并确认脚本没有被其他 xcconfig 覆盖。脚本本身也会把 `IPHONEOS_DEPLOYMENT_TARGET=15.1` 传给 xcodebuild，并在输出阶段读取 Mach-O 拒绝错误产物。

### Debug 能运行但 Release 不能

分别检查两套 framework 内的 `main.jsbundle`、Swift module interface 和动态依赖。不要把 Debug 与 Release slice 混合进同一个 XCFramework。

## 9. React Native 升级流程

RN 升级不能只修改 `react-native` 一个版本或只重新打主 framework。建议每次独立完成以下步骤：

1. 在 `SPMProject4` 新建升级分支，记录升级前 RN、React、Brownfield、CLI、Node、Ruby、CocoaPods 和 Xcode 版本。
2. 使用 React Native Upgrade Helper 或新建同版本空工程比较原生模板，更新 `package.json`、Podfile、AppDelegate、Info.plist、Metro/Babel 配置及 Xcode build settings。
3. 同步兼容版本的 `react`、`@react-native/*`、community CLI 和 `@callstack/react-native-brownfield`，然后重新生成 lockfile，禁止混用旧 `node_modules`。
4. 执行全新安装：`npm ci`、`bundle install`、`bundle exec pod install --repo-update`。
5. 检查 Brownfield 的 CLI 参数和产物名称。RN 或 Brownfield 可能新增、删除或重命名 XCFramework；如果五件套发生变化，要同步修改打包脚本的 `framework_names` 和 `Package.swift` products/targets。
6. 保持最低 iOS 15.1，除非新 RN、Hermes 或 Brownfield 明确提高最低系统。若必须提高，先修改产品最低系统决策，再同时更新源码工程、打包脚本、SwiftPM 清单和宿主 App。
7. 分别构建 Debug、Release。脚本会自动读取新的 RN 版本作为输出目录名，并校验所有 Mach-O 的最低系统。
8. 对比上一版产物：slice、动态依赖、Swift interface、JS bundle、压缩包尺寸及 checksum。
9. 在干净消费工程验证 SwiftPM 解析，并至少执行：最低支持系统启动、当前最高系统启动、Debug JS 调试、Release 离线启动、原生到 RN 页面跳转。
10. 使用新 GitHub tag 发布，绝不覆盖旧 tag 的同名 assets。更新 `Package.swift` URL/checksum 后再由 ZipReader 升级依赖。

升级记录建议在 `docs/upgrades/<旧版本>-to-<新版本>.md` 中保存，至少包括版本矩阵、模板差异、已知问题、产物 checksum 和消费工程验证结果。这样下一次升级不需要重新逆向当时的操作。
