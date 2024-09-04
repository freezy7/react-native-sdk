# Copyright (c) Meta Platforms, Inc. and affiliates.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

version = '0.74.5'
folly_version = '2024.01.01.00'
folly_compiler_flags = '-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1 -DFOLLY_CFG_NO_COROUTINES=1 -DFOLLY_HAVE_CLOCK_GETTIME=1 -Wno-comma -Wno-shorten-64-to-32'
boost_compiler_flags = '-Wno-documentation'

source_path = 'node_modules/react-native/ReactCommon/jserrorhandler'

folly_dep_name = 'RCT-Folly/Fabric'
react_native_path = ".."

Pod::Spec.new do |s|
  s.name                   = "React-jserrorhandler"
  s.version                = version
  s.summary                = "-"
  s.homepage               = "https://reactnative.dev/"
  s.license                = 'MIT'
  s.author                 = "Meta Platforms, Inc. and its affiliates"
  s.platforms              = { :ios => '13.4' }
  s.source                 = { :git => 'https://github.com/freezy7/react-native-sdk.git', :tag => "v#{s.version}" }
  s.header_dir             = "jserrorhandler"
  s.source_files           = "#{source_path}/JsErrorHandler.{cpp,h}"
  s.pod_target_xcconfig = {
    "USE_HEADERMAP" => "YES",
    "HEADER_SEARCH_PATHS" => "\"${PODS_CONFIGURATION_BUILD_DIR}/React-debug/React_debug.framework/Headers\" \"${PODS_CONFIGURATION_BUILD_DIR}/React-Mapbuffer/React_Mapbuffer.framework/Headers\"",
    "CLANG_CXX_LANGUAGE_STANDARD" => "c++20"
  }
  s.compiler_flags         = folly_compiler_flags + ' ' + boost_compiler_flags

  s.dependency folly_dep_name, folly_version
  s.dependency "React-jsi"
  s.dependency "React-debug"
  s.dependency "React-Mapbuffer"

end
