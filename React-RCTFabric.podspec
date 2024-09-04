# Copyright (c) Meta Platforms, Inc. and affiliates.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

version = '0.74.5'
folly_version = '2024.01.01.00'
folly_compiler_flags = '-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1 -DFOLLY_CFG_NO_COROUTINES=1 -DFOLLY_HAVE_CLOCK_GETTIME=1 -Wno-comma -Wno-shorten-64-to-32'
boost_compiler_flags = '-Wno-documentation'

source_path = 'node_modules/react-native/React'

new_arch_flags = ' -DRCT_NEW_ARCH_ENABLED=1'

header_search_paths = [
  "\"$(PODS_ROOT)/ReactCommon\"",
  "\"$(PODS_ROOT)/boost\"",
  "\"$(PODS_ROOT)/DoubleConversion\"",
  "\"$(PODS_ROOT)/fmt/include\"",
  "\"$(PODS_ROOT)/RCT-Folly\"",
  "\"$(PODS_ROOT)/Headers/Private/React-Core\"",
  "\"$(PODS_ROOT)/Headers/Private/Yoga\"",
  "\"$(PODS_ROOT)/Headers/Public/React-Codegen\"",
  "\"${PODS_CONFIGURATION_BUILD_DIR}/React-FabricImage/React_FabricImage.framework/Headers\"", 
  "\"${PODS_CONFIGURATION_BUILD_DIR}/React-Fabric/React_Fabric.framework/Headers\"", 
  "\"${PODS_CONFIGURATION_BUILD_DIR}/React-Fabric/React_Fabric.framework/Headers/react/renderer/textlayoutmanager/platform/ios\"", 
  "\"${PODS_CONFIGURATION_BUILD_DIR}/React-Fabric/React_Fabric.framework/Headers/react/renderer/components/textinput/platform/ios\"", 
  "\"${PODS_CONFIGURATION_BUILD_DIR}/React-Fabric/React_Fabric.framework/Headers/react/renderer/components/view/platform/cxx\"", 
  "\"${PODS_CONFIGURATION_BUILD_DIR}/React-Fabric/React_Fabric.framework/Headers/react/renderer/imagemanager/platform/ios\"", 
  "\"${PODS_CONFIGURATION_BUILD_DIR}/React-nativeconfig/React_nativeconfig.framework/Headers\"", 
  "\"${PODS_CONFIGURATION_BUILD_DIR}/React-graphics/React_graphics.framework/Headers\"", 
  "\"${PODS_CONFIGURATION_BUILD_DIR}/React-graphics/React_graphics.framework/Headers/react/renderer/graphics/platform/ios\"", 
  "\"${PODS_CONFIGURATION_BUILD_DIR}/React-ImageManager/React_ImageManager.framework/Headers\"", 
  "\"${PODS_CONFIGURATION_BUILD_DIR}/React-featureflags/React_featureflags.framework/Headers\"", 
  "\"${PODS_CONFIGURATION_BUILD_DIR}/React-debug/React_debug.framework/Headers\"", 
  "\"${PODS_CONFIGURATION_BUILD_DIR}/React-utils/React_utils.framework/Headers\"", 
  "\"${PODS_CONFIGURATION_BUILD_DIR}/React-rendererdebug/React_rendererdebug.framework/Headers\"", 
  "\"${PODS_CONFIGURATION_BUILD_DIR}/React-runtimescheduler/React_runtimescheduler.framework/Headers\"", 
  "\"${PODS_CONFIGURATION_BUILD_DIR}/React-jsinspector/jsinspector_modern.framework/Headers\""
]

module_name = "RCTFabric"
header_dir = "React"

Pod::Spec.new do |s|
  s.name                   = "React-RCTFabric"
  s.version                = version
  s.summary                = "RCTFabric for React Native."
  s.homepage               = "https://reactnative.dev/"
  s.license                = 'MIT'
  s.author                 = "Meta Platforms, Inc. and its affiliates"
  s.platforms              = { :ios => '13.4' }
  s.source                 = { :http => "https://github.com/freezy7/react-native-sdk/releases/download/v#{s.version}/React-RCTFabric.zip" }
  s.source_files           = "#{source_path}/Fabric/**/*.{c,h,m,mm,S,cpp}"
  s.exclude_files          = "#{source_path}/**/tests/*",
                             "#{source_path}/**/android/*",
  s.compiler_flags         = folly_compiler_flags + ' ' + boost_compiler_flags + new_arch_flags
  s.header_dir             = header_dir
  s.module_name            = module_name
  s.framework              = ["JavaScriptCore", "MobileCoreServices"]
  s.pod_target_xcconfig    = {
    "HEADER_SEARCH_PATHS" => header_search_paths,
    "OTHER_CFLAGS" => "$(inherited) " + folly_compiler_flags + new_arch_flags,
    "CLANG_CXX_LANGUAGE_STANDARD" => "c++20",
  }

  s.dependency "React-Core"
  s.dependency "React-RCTImage"
  s.dependency "RCT-Folly/Fabric", folly_version
  s.dependency "glog"
  s.dependency "Yoga"
  s.dependency "React-RCTText"
  s.dependency "React-jsi"

  s.dependency "React-FabricImage"
  s.dependency "React-Fabric"
  s.dependency "React-nativeconfig"
  s.dependency "React-graphics"
  s.dependency "React-ImageManager"
  s.dependency "React-featureflags"
  s.dependency "React-debug"
  s.dependency "React-utils"
  s.dependency "React-rendererdebug"
  s.dependency "React-runtimescheduler"
  s.dependency "React-jsinspector"

  s.dependency "hermes-engine"

  s.test_spec 'Tests' do |test_spec|
    test_spec.source_files = "#{source_path}/Tests/**/*.{mm}"
    test_spec.framework = "XCTest"
  end
end
