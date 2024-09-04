# Copyright (c) Meta Platforms, Inc. and affiliates.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

version = '0.74.5'
folly_version = '2024.01.01.00'
folly_compiler_flags = '-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1 -DFOLLY_CFG_NO_COROUTINES=1 -DFOLLY_HAVE_CLOCK_GETTIME=1 -Wno-comma -Wno-shorten-64-to-32'
boost_compiler_flags = '-Wno-documentation'

source_path = 'node_modules/react-native/ReactCommon'

Pod::Spec.new do |s|
  s.name                   = "React-Mapbuffer"
  s.version                = version
  s.summary                = "-"
  s.homepage               = "https://reactnative.dev/"
  s.license                = 'MIT'
  s.author                 = "Meta Platforms, Inc. and its affiliates"
  s.platforms              = { :ios => '13.4' }
  s.source                 = { :git => 'https://github.com/freezy7/react-native-sdk.git', :tag => "v#{s.version}" }
  s.source_files           = "#{source_path}/react/renderer/mapbuffer/*.{cpp,h}"
  s.exclude_files          = "#{source_path}/react/renderer/mapbuffer/tests"
  s.public_header_files    = "#{source_path}/react/renderer/mapbuffer/*.h"
  s.header_dir             = "react/renderer/mapbuffer"
  s.pod_target_xcconfig = {  "HEADER_SEARCH_PATHS" => "\"$(PODS_ROOT)\" \"${PODS_CONFIGURATION_BUILD_DIR}/React-debug/React_debug.framework/Headers\"", "USE_HEADERMAP" => "YES",
                            "CLANG_CXX_LANGUAGE_STANDARD" => "c++20" }

  s.dependency "glog"
  s.dependency "React-debug"

end
