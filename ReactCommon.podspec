# Copyright (c) Meta Platforms, Inc. and affiliates.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

version = '0.74.5'
folly_compiler_flags = '-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1 -DFOLLY_CFG_NO_COROUTINES=1 -DFOLLY_HAVE_CLOCK_GETTIME=1 -Wno-comma -Wno-shorten-64-to-32'
folly_version = '2024.01.01.00'
boost_compiler_flags = '-Wno-documentation'

source_path = 'node_modules/react-native/ReactCommon'

Pod::Spec.new do |s|
  s.name                   = "ReactCommon"
  s.module_name            = "ReactCommon"
  s.version                = version
  s.summary                = "-"  # TODO
  s.homepage               = "https://reactnative.dev/"
  s.license                = 'MIT'
  s.author                 = "Meta Platforms, Inc. and its affiliates"
  s.platforms              = { :ios => '13.4' }
  s.source                 = { :http => "https://github.com/freezy7/react-native-sdk/releases/download/v#{s.version}/ReactCommon.zip" }
  s.header_dir             = "ReactCommon" # Use global header_dir for all subspecs for use_frameworks! compatibility
  s.compiler_flags         = folly_compiler_flags + ' ' + boost_compiler_flags
  s.pod_target_xcconfig    = { "HEADER_SEARCH_PATHS" => "\"$(PODS_ROOT)/boost\" \"$(PODS_ROOT)/RCT-Folly\" \"$(PODS_ROOT)/DoubleConversion\" \"$(PODS_ROOT)/fmt/include\" \"$(PODS_ROOT)/Headers/Private/React-Core\"",
                               "USE_HEADERMAP" => "YES",
                               "DEFINES_MODULE" => "YES",
                               "CLANG_CXX_LANGUAGE_STANDARD" => "c++20",
                               "GCC_WARN_PEDANTIC" => "YES" }

  # TODO (T48588859): Restructure this target to align with dir structure: "react/nativemodule/..."
  # Note: Update this only when ready to minimize breaking changes.
  s.subspec "turbomodule" do |ss|
    ss.dependency "React-callinvoker", version
    ss.dependency "React-perflogger", version
    ss.dependency "React-cxxreact", version
    ss.dependency "React-jsi", version
    ss.dependency "RCT-Folly", folly_version
    ss.dependency "React-logger", version
    ss.dependency "DoubleConversion"
    ss.dependency "fmt", "9.1.0"
    ss.dependency "glog"
    ss.dependency "hermes-engine"

    ss.subspec "bridging" do |sss|
      sss.dependency           "React-jsi", version
      sss.source_files         = "#{source_path}/react/bridging/**/*.{cpp,h}"
      sss.exclude_files        = "#{source_path}/react/bridging/tests"
      sss.header_dir           = "react/bridging"
      sss.pod_target_xcconfig  = { "HEADER_SEARCH_PATHS" => "\"$(PODS_ROOT)/ReactCommon\" \"$(PODS_ROOT)/RCT-Folly\"" }
      sss.dependency "hermes-engine"
    end

    ss.subspec "core" do |sss|
      sss.source_files = "#{source_path}/react/nativemodule/core/ReactCommon/**/*.{cpp,h}"
      sss.pod_target_xcconfig  = { "HEADER_SEARCH_PATHS" => "\"$(PODS_ROOT)/ReactCommon\" \"$(PODS_CONFIGURATION_BUILD_DIR)/React-debug/React_debug.framework/Headers\" \"$(PODS_CONFIGURATION_BUILD_DIR)/React-utils/React_utils.framework/Headers\"" }
      sss.dependency "React-debug", version
      sss.dependency "React-utils", version
    end
  end
end
