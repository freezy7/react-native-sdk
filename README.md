# react-native-sdk

ZPlayer 使用的 React Native Swift Package 二进制分发仓库。打包脚本会从源码工程的 `package.json` 自动读取 React Native 版本，避免升级后继续写入旧版本目录。

- 最低支持系统：iOS 15.1
- 正式 SwiftPM 清单：`Package.swift`
- 源码与 Brownfield 构建工程：[SPMProject4](https://github.com/freezy7/SPMProject4)
- 可重复打包入口：`scripts/build-react-native-framework.sh`
- 完整说明：[docs/BUILDING.md](docs/BUILDING.md)

生成 Debug 和 Release：

```bash
scripts/build-react-native-framework.sh
```

生成结果默认位于 `dist/<React Native 版本>/`。二进制不直接提交 Git，发布时上传到新的 GitHub Release，再更新 `Package.swift` 的 URL 和 checksum。
