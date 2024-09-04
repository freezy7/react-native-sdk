# Copyright (c) Meta Platforms, Inc. and affiliates.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

version = '0.74.5'
folly_version = '2024.01.01.00'
folly_compiler_flags = '-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1 -DFOLLY_CFG_NO_COROUTINES=1 -DFOLLY_HAVE_CLOCK_GETTIME=1 -Wno-comma -Wno-shorten-64-to-32'
boost_compiler_flags = '-Wno-documentation'

source_path = 'node_modules/react-native/ReactCommon/react/nativemodule/core/platform/ios'

Pod::Spec.new do |s|
    s.name                   = "React-NativeModulesApple"
    s.module_name            = "React_NativeModulesApple"
    s.header_dir             = "ReactCommon" # Use global header_dir for all subspecs for use_frameworks! compatibility
    s.version                = version
    s.summary                = "-"
    s.homepage               = "https://reactnative.dev/"
    s.license                = 'MIT'
    s.author                 = "Meta Platforms, Inc. and its affiliates"
    s.platforms              = { :ios => '13.4' }
    s.source                 = { :git => 'https://github.com/freezy7/react-native-sdk.git', :tag => "v#{s.version}" }
    s.compiler_flags         = folly_compiler_flags + ' ' + boost_compiler_flags
    s.pod_target_xcconfig    = { "HEADER_SEARCH_PATHS" => "\"$(PODS_ROOT)/boost\" \"$(PODS_ROOT)/RCT-Folly\" \"$(PODS_ROOT)/DoubleConversion\" \"$(PODS_ROOT)/fmt/include\" \"$(PODS_ROOT)/Headers/Private/React-Core\" \"${PODS_CONFIGURATION_BUILD_DIR}/React-jsinspector/jsinspector_modern.framework/Headers\"",
                                "USE_HEADERMAP" => "YES",
                                "CLANG_CXX_LANGUAGE_STANDARD" => rct_cxx_language_standard(),
                                "GCC_WARN_PEDANTIC" => "YES" }

    s.source_files = "#{source_path}/ReactCommon/**/*.{mm,cpp,h}"

    s.dependency "glog"
    s.dependency "ReactCommon/turbomodule/core"
    s.dependency "ReactCommon/turbomodule/bridging"
    s.dependency "React-callinvoker"
    s.dependency "React-Core"
    s.dependency "React-cxxreact"
    s.dependency "React-jsi"
    s.dependency "React-runtimeexecutor"
    s.dependency "React-jsinspector"

    s.dependency "hermes-engine"
end
