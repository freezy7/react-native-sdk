// swift-tools-version: 5.9

import PackageDescription

let package = Package(
  name: "ReactNativeFrameworkPackage",
  platforms: [
    .iOS("15.1"),
  ],
  products: [
    .library(name: "ReactNativeFramework", targets: ["ReactNativeFramework", "hermesvm", "ReactBrownfield", "React", "ReactNativeDependencies"]),
  ],
  targets: [
    .binaryTarget(
        name: "ReactNativeFramework",
        url: "https://github.com/freezy7/react-native-sdk/releases/download/0.84.1/ReactNativeFramework.xcframework.zip",
        checksum: "f41df852a31c9fada77511bb32847a09dd3723aff40728ca2dbcb99c6abad139"
    ),
    .binaryTarget(
        name: "hermesvm",
        url: "https://github.com/freezy7/react-native-sdk/releases/download/0.84.1/hermesvm.xcframework.zip?revision=symlinks-fixed-1",
        checksum: "ec3b389ad42da81ac7073ac3608183b882f38c96cc6b2337a39ffd629c2ab261"
    ),
    .binaryTarget(
        name: "ReactBrownfield",
        url: "https://github.com/freezy7/react-native-sdk/releases/download/0.84.1/ReactBrownfield.xcframework.zip",
        checksum: "671dbf74289ed1f0e14f545732777be9097b847038014cfcc8a0d8bdc60ec376"
    ),
    .binaryTarget(
        name: "React",
        url: "https://github.com/freezy7/react-native-sdk/releases/download/0.84.1/React.xcframework.zip",
        checksum: "883aeddf48816ec20d39321ce840776e5c835943a10a6c589cc6e870f5af856d"
    ),
    .binaryTarget(
        name: "ReactNativeDependencies",
        url: "https://github.com/freezy7/react-native-sdk/releases/download/0.84.1/ReactNativeDependencies.xcframework.zip",
        checksum: "748c92e90f8215a71e0fe9cd00770de87c6baeb05bcd791c31a8d669e8a7fb24"
    )
  ]
)
