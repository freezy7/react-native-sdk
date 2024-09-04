# Copyright (c) Meta Platforms, Inc. and affiliates.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

version = '0.74.5'
folly_version = '2024.01.01.00'
folly_compiler_flags = '-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1 -DFOLLY_CFG_NO_COROUTINES=1 -DFOLLY_HAVE_CLOCK_GETTIME=1 -Wno-comma -Wno-shorten-64-to-32'
boost_compiler_flags = '-Wno-documentation'

source_path = 'node_modules/react-native/ReactCommon'

# We are using two different paths for react native because of the way how js_srcs_dir and output_dir options are used
# output_dir option usage was introduced in https://github.com/facebook/react-native/pull/36210
# React-rncore.podspec is the only podspec in the project that uses this option
# We should rethink this approach in T148704916

# Relative path to react native from iOS project root (e.g. <ios-project-root>/../node_modules/react-native)
#react_native_dependency_path = ENV['REACT_NATIVE_PATH']
# Relative path to react native from current podspec
#react_native_sources_path = '..'

header_search_paths = [
  "\"$(PODS_ROOT)\"",
  "\"$(PODS_ROOT)/ReactCommon\"",
]

Pod::Spec.new do |s|
  s.name                   = "React-rncore"
  s.version                = version
  s.summary                = "Fabric for React Native."
  s.homepage               = "https://reactnative.dev/"
  s.license                = 'MIT'
  s.author                 = "Meta Platforms, Inc. and its affiliates"
  s.platforms              = { :ios => '13.4' }
  s.source                 = { :git => 'https://github.com/freezy7/react-native-sdk.git', :tag => "v#{s.version}" }
  s.source_files           = "#{source_path}/dummyFile.cpp"
  s.pod_target_xcconfig = { "USE_HEADERMAP" => "YES",
                            "HEADER_SEARCH_PATHS" => header_search_paths.join(' '),
                            "CLANG_CXX_LANGUAGE_STANDARD" => "c++20" }
end
