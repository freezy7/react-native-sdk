# Copyright (c) Meta Platforms, Inc. and affiliates.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

version = '0.74.5'
folly_version = '2024.01.01.00'
folly_compiler_flags = '-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1 -DFOLLY_CFG_NO_COROUTINES=1 -DFOLLY_HAVE_CLOCK_GETTIME=1 -Wno-comma -Wno-shorten-64-to-32'
boost_compiler_flags = '-Wno-documentation'

source_path = 'node_modules/react-native/ReactCommon/hermes'

Pod::Spec.new do |s|
  s.name                   = "React-hermes"
  s.version                = version
  s.summary                = "Hermes engine for React Native"
  s.homepage               = "https://reactnative.dev/"
  s.license                = 'MIT'
  s.author                 = "Meta Platforms, Inc. and its affiliates"
  s.platforms              = { :ios => '13.4' }
  s.source                 = { :http => "https://github.com/freezy7/react-native-sdk/releases/download/v#{s.version}/React-hermes.zip" }
  s.source_files           = "#{source_path}/executor/*.{cpp,h}",
                             "#{source_path}/inspector-modern/chrome/*.{cpp,h}",
  s.public_header_files    = "#{source_path}/executor/HermesExecutorFactory.h"
  s.compiler_flags         = folly_compiler_flags + ' ' + boost_compiler_flags
  s.pod_target_xcconfig    = {
                               "HEADER_SEARCH_PATHS" => "\"${PODS_ROOT}/hermes-engine/destroot/include\" \"$(PODS_ROOT)/React-hermes/node_modules/react-native/ReactCommon\" \"$(PODS_ROOT)/boost\" \"$(PODS_ROOT)/RCT-Folly\" \"$(PODS_ROOT)/DoubleConversion\" \"$(PODS_ROOT)/fmt/include\" \"${PODS_CONFIGURATION_BUILD_DIR}/React-jsinspector/jsinspector_modern.framework/Headers\"",
                               "CLANG_CXX_LANGUAGE_STANDARD" => "c++20",
                             }
  s.header_dir             = "reacthermes"
  s.dependency "React-cxxreact", version
  s.dependency "React-jsiexecutor", version
  s.dependency "React-jsinspector"
  s.dependency "React-perflogger", version
  s.dependency "RCT-Folly", folly_version
  s.dependency "DoubleConversion"
  s.dependency "fmt", "9.1.0"
  s.dependency "glog"
  s.dependency "hermes-engine"
  s.dependency "React-jsi"
  s.dependency "React-runtimeexecutor"
end
