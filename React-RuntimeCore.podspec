# Copyright (c) Meta Platforms, Inc. and affiliates.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

version = '0.74.5'
folly_version = '2024.01.01.00'
folly_compiler_flags = '-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1 -DFOLLY_CFG_NO_COROUTINES=1 -DFOLLY_HAVE_CLOCK_GETTIME=1 -Wno-comma -Wno-shorten-64-to-32'
boost_compiler_flags = '-Wno-documentation'

source_path = 'node_modules/react-native/ReactCommon/react/runtime'

folly_dep_name = 'RCT-Folly/Fabric'

Pod::Spec.new do |s|
  s.name                   = "React-RuntimeCore"
  s.version                = version
  s.summary                = "The React Native Runtime."
  s.homepage               = "https://reactnative.dev/"
  s.license                = 'MIT'
  s.author                 = "Meta Platforms, Inc. and its affiliates"
  s.platforms              = { :ios => '13.4' }
  s.source                 = { :git => 'https://github.com/freezy7/react-native-sdk.git', :tag => "v#{spec.version}" }
  s.source_files           = "#{source_path}/*.{cpp,h}", "#{source_path}/nativeviewconfig/*.{cpp,h}"
  s.exclude_files          = "#{source_path}/iostests/*", "#{source_path}/tests/**/*.{cpp,h}"
  s.header_dir             = "react/runtime"
  s.pod_target_xcconfig    = { "HEADER_SEARCH_PATHS" => "\"$(PODS_ROOT)/boost\" \"$(PODS_ROOT)/Headers/Private/React-Core\" \"${PODS_ROOT}/\"",
                                "USE_HEADERMAP" => "YES",
                                "CLANG_CXX_LANGUAGE_STANDARD" => "c++20",
                                "GCC_WARN_PEDANTIC" => "YES" }
  s.compiler_flags       = folly_compiler_flags + ' ' + boost_compiler_flags

  s.dependency folly_dep_name, folly_version
  s.dependency "React-jsiexecutor"
  s.dependency "React-cxxreact"
  s.dependency "React-runtimeexecutor"
  s.dependency "glog"
  s.dependency "React-jsi"
  s.dependency "React-jserrorhandler"
  s.dependency "React-runtimescheduler"
  s.dependency "React-utils"
  s.dependency "React-featureflags"

  s.dependency "hermes-engine"

  s.dependency "React-jsinspector"
end
