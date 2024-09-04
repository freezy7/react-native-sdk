# Copyright (c) Meta Platforms, Inc. and affiliates.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

js_engine = :hermes
version = '0.74.5'
folly_version = '2024.01.01.00'
folly_compiler_flags = '-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1 -DFOLLY_CFG_NO_COROUTINES=1 -DFOLLY_HAVE_CLOCK_GETTIME=1 -Wno-comma -Wno-shorten-64-to-32'
boost_compiler_flags = '-Wno-documentation'

source_path = 'node_modules/react-native/ReactCommon/jsi'

Pod::Spec.new do |s|
  s.name                   = "React-jsi"
  s.version                = version
  s.summary                = "JavaScript Interface layer for React Native"
  s.homepage               = "https://reactnative.dev/"
  s.license                = 'MIT'
  s.author                 = "Meta Platforms, Inc. and its affiliates"
  s.platforms              = { :ios => '13.4' }
  s.source                 = { :git => 'https://github.com/freezy7/react-native-sdk.git', :tag => "v#{s.version}" }

  s.header_dir    = "jsi"
  s.compiler_flags         = folly_compiler_flags + ' ' + boost_compiler_flags
  s.pod_target_xcconfig    = { "HEADER_SEARCH_PATHS" => "\"$(PODS_ROOT)/boost\" \"$(PODS_ROOT)/RCT-Folly\" \"$(PODS_ROOT)/DoubleConversion\" \"$(PODS_ROOT)/fmt/include\"",
                               "DEFINES_MODULE" => "YES" }

  s.dependency "boost", "1.83.0"
  s.dependency "DoubleConversion"
  s.dependency "fmt", "9.1.0"
  s.dependency "RCT-Folly", folly_version
  s.dependency "glog"

  s.source_files  = "#{source_path}/**/*.{cpp,h}"
  files_to_exclude = [
                      "#{source_path}/jsi/jsilib-posix.cpp",
                      "#{source_path}/jsi/jsilib-windows.cpp",
                      "#{source_path}/**/test/*"
                     ]
  if js_engine == :hermes
    # JSI is a part of hermes-engine. Including them also in react-native will violate the One Definition Rulle.
    files_to_exclude += [ "#{source_path}/jsi/jsi.cpp" ]
    s.dependency "hermes-engine"
  end
  s.exclude_files = files_to_exclude
end
