# Copyright (c) Meta Platforms, Inc. and affiliates.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

header_subspecs = {
  'CoreModulesHeaders'          => 'node_modules/react-native/React/CoreModules/**/*.h',
  # 'RCTActionSheetHeaders'       => 'node_modules/react-native/Libraries/ActionSheetIOS/*.h', // 没有数据
  'RCTAnimationHeaders'         => 'node_modules/react-native/Libraries/NativeAnimation/{Drivers/*,Nodes/*,*}.{h}',
  'RCTBlobHeaders'              => 'node_modules/react-native/Libraries/Blob/{RCTBlobManager,RCTFileReaderModule}.h',
  'RCTImageHeaders'             => 'node_modules/react-native/Libraries/Image/*.h',
  'RCTLinkingHeaders'           => 'node_modules/react-native/Libraries/LinkingIOS/*.h',
  'RCTNetworkHeaders'           => 'node_modules/react-native/Libraries/Network/*.h',
  'RCTPushNotificationHeaders'  => 'node_modules/react-native/Libraries/PushNotificationIOS/*.h',
  'RCTSettingsHeaders'          => 'node_modules/react-native/Libraries/Settings/*.h',
  'RCTTextHeaders'              => 'node_modules/react-native/Libraries/Text/**/*.h',
  'RCTVibrationHeaders'         => 'node_modules/react-native/Libraries/Vibration/*.h',
}

header_search_paths = [
  "$(PODS_ROOT)/React-Core/node_modules/react-native/React/CoreModules",
  "$(PODS_ROOT)/ReactCommon",
  "$(PODS_ROOT)/boost",
  "$(PODS_ROOT)/DoubleConversion",
  "$(PODS_ROOT)/fmt/include",
  "$(PODS_ROOT)/RCT-Folly",
  "${PODS_ROOT}/Headers/Public/FlipperKit",
  "$(PODS_ROOT)/Headers/Public/ReactCommon",
  "$(PODS_ROOT)/Headers/Public/React-hermes",
  "$(PODS_ROOT)/Headers/Public/hermes-engine",
  "${PODS_CONFIGURATION_BUILD_DIR}/React-jsinspector/jsinspector_modern.framework/Headers",
  "${PODS_CONFIGURATION_BUILD_DIR}/RCTDeprecation/RCTDeprecation.framework/Headers"
]

version = '0.74.5'
folly_version = '2024.01.01.00'
socket_rocket_version = '0.7.0'
source_path = 'node_modules/react-native'

Pod::Spec.new do |s|
  s.name                   = "React-Core"
  s.version                = '0.74.5'
  s.summary                = "The core of React Native."
  s.homepage               = "https://reactnative.dev/"
  s.license                = 'MIT'
  s.author                 = "Meta Platforms, Inc. and its affiliates"
  s.platforms              = { :ios => '13.4' }
  s.source                 = { :http => "https://github.com/freezy7/react-native-sdk/releases/download/v#{s.version}/React-Core.zip" }
  s.resource_bundle        = { "RCTI18nStrings" => ["node_modules/react-native/React/I18n/strings/*.lproj"]}
  s.compiler_flags         = "-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1 -DFOLLY_CFG_NO_COROUTINES=1 -DFOLLY_HAVE_CLOCK_GETTIME=1 -Wno-comma -Wno-shorten-64-to-32 -Wno-documentation -DUSE_HERMES=1"
  s.header_dir             = "React"
  s.framework              = "JavaScriptCore"
  s.pod_target_xcconfig    = {
                               "HEADER_SEARCH_PATHS" => header_search_paths,
                               "GCC_PREPROCESSOR_DEFINITIONS" => "RCT_METRO_PORT=${RCT_METRO_PORT}",
                               "CLANG_CXX_LANGUAGE_STANDARD" => "c++20",
                               "FRAMEWORK_SEARCH_PATHS" => "\"$(PODS_CONFIGURATION_BUILD_DIR)/React-hermes\""
                             }
  s.user_target_xcconfig   = { "HEADER_SEARCH_PATHS" => "\"$(PODS_ROOT)/Headers/Private/React-Core\""}
  s.default_subspec        = "Default"

  s.subspec "Default" do |ss|
    ss.source_files           = "#{source_path}/React/**/*.{c,h,m,mm,S,cpp}"
    exclude_files = [
      "#{source_path}/React/CoreModules/**/*.{mm,m}",
      "#{source_path}/React/DevSupport/**/*.{mm,m}",
      "#{source_path}/React/Fabric/**/*",
      "#{source_path}/React/FBReactNativeSpec/**/*",
      "#{source_path}/React/Tests/**/*",
      "#{source_path}/React/Inspector/**/*",
      "#{source_path}/React/CxxBridge/JSCExecutorFactory.{h,mm}"
    ]
    ss.exclude_files = exclude_files
    ss.private_header_files   = "#{source_path}/React/Cxx*/*.h"
  end

  s.subspec "DevSupport" do |ss|
    ss.source_files = "#{source_path}/React/DevSupport/*.{h,mm,m}",
                      "#{source_path}/React/Inspector/*.{h,mm,m}"

    ss.dependency "React-Core/Default", version
    ss.dependency "React-Core/RCTWebSocket", version
    ss.private_header_files = "#{source_path}/React/Inspector/RCTCxx*.h"
  end

  s.subspec "RCTWebSocket" do |ss|
    ss.source_files = "#{source_path}/Libraries/WebSocket/*.{h,m}"
    ss.dependency "React-Core/Default", version
  end

  # Add a subspec containing just the headers for each
  # pod that should live under <React/*.h>
  header_subspecs.each do |name, headers|
    s.subspec name do |ss|
      ss.source_files = headers
      ss.dependency "React-Core/Default"
    end
  end

  s.dependency "RCT-Folly", folly_version
  s.dependency "React-cxxreact"
  s.dependency "React-perflogger"
  s.dependency "React-jsi"
  s.dependency "React-jsiexecutor"
  s.dependency "React-utils"
  s.dependency "React-featureflags"
  s.dependency "SocketRocket", socket_rocket_version
  s.dependency "React-runtimescheduler"
  s.dependency "Yoga"
  s.dependency "glog"

  s.dependency 'React-jsinspector'
  s.dependency 'RCTDeprecation'

  s.dependency 'React-hermes'
  s.dependency 'hermes-engine'
  
end
