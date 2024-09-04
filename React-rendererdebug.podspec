# Copyright (c) Meta Platforms, Inc. and affiliates.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

version = '0.74.5'
folly_version = '2024.01.01.00'
folly_compiler_flags = '-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1 -DFOLLY_CFG_NO_COROUTINES=1 -DFOLLY_HAVE_CLOCK_GETTIME=1 -Wno-comma -Wno-shorten-64-to-32'
boost_compiler_flags = '-Wno-documentation'

source_path = 'node_modules/react-native/ReactCommon/react/renderer/debug'

header_search_paths = [
    "\"$(PODS_ROOT)/RCT-Folly\"",
    "\"$(PODS_ROOT)/boost\" \"$(PODS_ROOT)/RCT-Folly\"",
    "\"$(PODS_ROOT)/DoubleConversion\"",
    "\"$(PODS_ROOT)/fmt/include\"",
    "\"${PODS_CONFIGURATION_BUILD_DIR}/React-debug/React_debug.framework/Headers\""
]

Pod::Spec.new do |s|
  s.name                   = "React-rendererdebug"
  s.version                = version
  s.summary                = "-"  # TODO
  s.homepage               = "https://reactnative.dev/"
  s.license                = 'MIT'
  s.author                 = "Meta Platforms, Inc. and its affiliates"
  s.platforms              = { :ios => '13.4' }
  s.source                 = { :http => "https://github.com/freezy7/react-native-sdk/releases/download/v#{s.version}/React-rendererdebug.zip" }
  s.source_files           = "#{source_path}/**/*.{cpp,h,mm}"
  s.compiler_flags         = folly_compiler_flags
  s.header_dir             = "react/renderer/debug"
  s.exclude_files          = "#{source_path}/tests"
  s.pod_target_xcconfig    = {
    "CLANG_CXX_LANGUAGE_STANDARD" => "c++20",
    "HEADER_SEARCH_PATHS" => header_search_paths.join(' '),
    "DEFINES_MODULE" => "YES"
  }

  s.dependency "RCT-Folly", folly_version
  s.dependency "DoubleConversion"
  s.dependency "fmt", "9.1.0"
  s.dependency "React-debug"
end
