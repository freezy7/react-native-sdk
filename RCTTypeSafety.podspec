# Copyright (c) Meta Platforms, Inc. and affiliates.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

version = '0.74.5'
source_path = 'node_modules/react-native/Libraries/TypeSafety'

Pod::Spec.new do |s|
  s.name                   = "RCTTypeSafety"
  s.version                = version
  s.summary                = "-"  # TODO
  s.homepage               = "https://reactnative.dev/"
  s.license                = 'MIT'
  s.author                 = "Meta Platforms, Inc. and its affiliates"
  s.platforms              = { :ios => '13.4' }
  s.source                 = { :git => 'https://github.com/freezy7/react-native-sdk.git', :tag => "v#{spec.version}" }
  s.source_files           = "#{source_path}/**/*.{c,h,m,mm,cpp}"
  s.header_dir             = "RCTTypeSafety"
  s.pod_target_xcconfig    = {
                               "USE_HEADERMAP" => "YES",
                               "CLANG_CXX_LANGUAGE_STANDARD" => "c++20",
                               "HEADER_SEARCH_PATHS" => "\"$(PODS_TARGET_SRCROOT)/Libraries/TypeSafety\""
                             }

  s.dependency "FBLazyVector", version
  s.dependency "RCTRequired", version
  s.dependency "React-Core", version
end
