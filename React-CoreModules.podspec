# Copyright (c) Meta Platforms, Inc. and affiliates.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

version = '0.74.5'
socket_rocket_version = '0.7.0'
folly_version = '2024.01.01.00'
folly_compiler_flags = '-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1 -DFOLLY_CFG_NO_COROUTINES=1 -DFOLLY_HAVE_CLOCK_GETTIME=1 -Wno-comma -Wno-shorten-64-to-32'
boost_compiler_flags = '-Wno-documentation'

source_path = 'node_modules/react-native/React/CoreModules'

header_search_paths = [
  "\"$(PODS_ROOT)/boost\"",
  "\"$(PODS_ROOT)/React-CoreModules\"",
  "\"$(PODS_ROOT)/RCT-Folly\"",
  "\"$(PODS_ROOT)/DoubleConversion\"",
  "\"$(PODS_ROOT)/fmt/include\"",
  "\"${PODS_ROOT}/Headers/Public/React-Codegen/react/renderer/components\"",
  "\"${PODS_CONFIGURATION_BUILD_DIR}/React-Codegen/React_Codegen.framework/Headers\"", 
  "\"${PODS_CONFIGURATION_BUILD_DIR}/React-Codegen/React_Codegen.framework/Headers/build/generated/ios\"", 
  "\"${PODS_CONFIGURATION_BUILD_DIR}/ReactCommon/ReactCommon.framework/Headers\"", 
  "\"${PODS_CONFIGURATION_BUILD_DIR}/ReactCommon/ReactCommon.framework/Headers/react/nativemodule/core\"", 
  "\"${PODS_CONFIGURATION_BUILD_DIR}/React-NativeModulesApple/React_NativeModulesApple.framework/Headers\"", 
  "\"${PODS_CONFIGURATION_BUILD_DIR}/React-NativeModulesApple/React_NativeModulesApple.framework/Headers/build/generated/ios\"",
  "\"${PODS_CONFIGURATION_BUILD_DIR}/React-jsinspector/jsinspector_modern.framework/Headers\""
]

Pod::Spec.new do |s|
  s.name                   = "React-CoreModules"
  s.version                = version
  s.summary                = "-"  # TODO
  s.homepage               = "https://reactnative.dev/"
  s.license                = 'MIT'
  s.author                 = "Meta Platforms, Inc. and its affiliates"
  s.platforms              = { :ios => '13.4' }
  s.source                 = { :http => "https://github.com/freezy7/react-native-sdk/releases/download/v#{s.version}/React-CoreModules.zip" }
  s.compiler_flags         = folly_compiler_flags + ' -Wno-nullability-completeness'
  s.source_files           = "#{source_path}/**/*.{c,m,mm,cpp}"
  s.header_dir             = "CoreModules"
  s.pod_target_xcconfig    = {
                               "USE_HEADERMAP" => "YES",
                               "CLANG_CXX_LANGUAGE_STANDARD" => "c++20",
                               "HEADER_SEARCH_PATHS" => header_search_paths.join(" ")
                             }
  s.framework = "UIKit"
  s.dependency "DoubleConversion"
  s.dependency "fmt", "9.1.0"
  s.dependency "RCT-Folly", folly_version
  s.dependency "RCTTypeSafety", version
  s.dependency "React-Core/CoreModulesHeaders", version
  s.dependency "React-RCTImage", version
  s.dependency "React-jsi", version
  s.dependency 'React-RCTBlob'
  s.dependency "SocketRocket", socket_rocket_version

  s.dependency "React-Codegen"
  s.dependency "ReactCommon/turbomodule/core"
  s.dependency "React-NativeModulesApple"
  s.dependency "React-jsinspector"
end
