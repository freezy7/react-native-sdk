# Copyright (c) Meta Platforms, Inc. and affiliates.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

version = '0.74.5'
folly_version = '2024.01.01.00'
folly_compiler_flags = '-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1 -DFOLLY_CFG_NO_COROUTINES=1 -DFOLLY_HAVE_CLOCK_GETTIME=1 -Wno-comma -Wno-shorten-64-to-32'
boost_compiler_flags = '-Wno-documentation'

source_path = 'node_modules/react-native/ReactCommon/react/renderer/graphics'

Pod::Spec.new do |s|
  source_files = "#{source_path}/**/*.{m,mm,cpp,h}"
  header_search_paths = [
    "\"$(PODS_ROOT)/boost\"",
    "\"$(PODS_ROOT)/ReactCommon\"",
    "\"$(PODS_ROOT)/RCT-Folly\"",
    "\"$(PODS_ROOT)/DoubleConversion\"",
    "\"$(PODS_ROOT)/fmt/include\""
  ]

  s.name                   = "React-graphics"
  s.version                = version
  s.summary                = "Fabric for React Native."
  s.homepage               = "https://reactnative.dev/"
  s.license                = 'MIT'
  s.author                 = "Meta Platforms, Inc. and its affiliates"
  s.platforms              = { :ios => '13.4' }
  s.source                 = { :git => 'https://github.com/freezy7/react-native-sdk.git', :tag => "v#{s.version}" }
  s.compiler_flags         = folly_compiler_flags + ' ' + boost_compiler_flags
  s.source_files           = source_files
  s.exclude_files          = "#{source_path}/tests",
                             "#{source_path}/platform/android",
                             "#{source_path}/platform/cxx",
                             "#{source_path}/platform/windows",
  s.header_dir             = "react/renderer/graphics"

  s.pod_target_xcconfig  = { "USE_HEADERMAP" => "NO",
                             "HEADER_SEARCH_PATHS" => header_search_paths.join(" "),
                             "DEFINES_MODULE" => "YES",
                             "CLANG_CXX_LANGUAGE_STANDARD" => "c++20" }

  s.dependency "glog"
  s.dependency "RCT-Folly/Fabric", folly_version
  s.dependency "React-Core/Default", version
  s.dependency "React-utils"
  s.dependency "DoubleConversion"
  s.dependency "fmt", "9.1.0"
end
