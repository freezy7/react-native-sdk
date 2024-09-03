# Copyright (c) Meta Platforms, Inc. and affiliates.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

version = '0.74.5'
source_path = 'node_modules/react-native/ReactCommon/react/featureflags'

Pod::Spec.new do |s|
  s.name                   = "React-featureflags"
  s.version                = version
  s.summary                = "React Native internal feature flags"
  s.homepage               = "https://reactnative.dev/"
  s.license                = 'MIT'
  s.author                 = "Meta Platforms, Inc. and its affiliates"
  s.platforms              = { :ios => '13.4' }
  s.source                 = { :git => 'https://github.com/freezy7/react-native-sdk.git', :tag => "v#{spec.version}" }
  s.source_files           = "#{source_path}/*.{cpp,h}"
  s.header_dir             = "react/featureflags"
  s.libraries = "c++"
  s.pod_target_xcconfig    = { "CLANG_CXX_LANGUAGE_STANDARD" => "c++20",
                               "DEFINES_MODULE" => "YES" }
end
