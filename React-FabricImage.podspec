# Copyright (c) Meta Platforms, Inc. and affiliates.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

version = '0.74.5'
folly_version = '2024.01.01.00'
folly_compiler_flags = '-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1 -DFOLLY_CFG_NO_COROUTINES=1 -DFOLLY_HAVE_CLOCK_GETTIME=1 -Wno-comma -Wno-shorten-64-to-32'
boost_compiler_flags = '-Wno-documentation'

source_path = 'node_modules/react-native/ReactCommon'

folly_dep_name = 'RCT-Folly/Fabric'

header_search_path = [
  "\"$(PODS_ROOT)/boost\"",
  "\"$(PODS_ROOT)/ReactCommon\"",
  "\"$(PODS_ROOT)/RCT-Folly\"",
  "\"$(PODS_ROOT)/Headers/Private/Yoga\"",
  "\"$(PODS_ROOT)/DoubleConversion\"",
  "\"$(PODS_ROOT)/fmt/include\"",
  "\"${PODS_CONFIGURATION_BUILD_DIR}/ReactCommon/ReactCommon.framework/Headers\"",
  "\"${PODS_CONFIGURATION_BUILD_DIR}/React-graphics/React_graphics.framework/Headers\"",
  "\"${PODS_CONFIGURATION_BUILD_DIR}/React-graphics/React_graphics.framework/Headers/react/renderer/graphics/platform/ios\"",
  "\"${PODS_CONFIGURATION_BUILD_DIR}/React-Fabric/React_Fabric.framework/Headers\"", 
  "\"${PODS_CONFIGURATION_BUILD_DIR}/React-Fabric/React_Fabric.framework/Headers/react/renderer/components/view/platform/cxx\"", 
  "\"${PODS_CONFIGURATION_BUILD_DIR}/React-Fabric/React_Fabric.framework/Headers/react/renderer/imagemanager/platform/ios\"", 
  "\"${PODS_CONFIGURATION_BUILD_DIR}/React-rendererdebug/React_rendererdebug.framework/Headers\""
]

Pod::Spec.new do |s|
  s.name                   = "React-FabricImage"
  s.version                = version
  s.summary                = "Image Component for Fabric for React Native."
  s.homepage               = "https://reactnative.dev/"
  s.license                = 'MIT'
  s.author                 = "Meta Platforms, Inc. and its affiliates"
  s.platforms              = { :ios => '13.4' }
  s.source                 = { :http => "https://github.com/freezy7/react-native-sdk/releases/download/v#{s.version}/React-FabricImage.zip" }
  s.source_files         = "#{source_path}/react/renderer/components/image/**/*.{m,mm,cpp,h}"
  s.exclude_files        = "#{source_path}/react/renderer/components/image/tests"
  s.header_dir           = "react/renderer/components/image"
  s.compiler_flags       = folly_compiler_flags
  s.pod_target_xcconfig = { "USE_HEADERMAP" => "YES",
                            "CLANG_CXX_LANGUAGE_STANDARD" => "c++20",
                            "HEADER_SEARCH_PATHS" => header_search_path.join(" ")
                          }

  s.dependency folly_dep_name, folly_version

  s.dependency "React-jsiexecutor", version
  s.dependency "RCTRequired", version
  s.dependency "RCTTypeSafety", version
  s.dependency "React-jsi"
  s.dependency "React-logger"
  s.dependency "glog"
  s.dependency "DoubleConversion"
  s.dependency "fmt", "9.1.0"
  s.dependency "React-ImageManager"
  s.dependency "React-utils"
  s.dependency "Yoga"
  s.dependency "ReactCommon/turbomodule/core"
  s.dependency "React-graphics"
  s.dependency "React-Fabric"
  s.dependency "React-rendererdebug"

  s.dependency "hermes-engine"
end
