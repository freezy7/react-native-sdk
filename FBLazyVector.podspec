# Copyright (c) Meta Platforms, Inc. and affiliates.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

Pod::Spec.new do |s|
  s.name                   = "FBLazyVector"
  s.version                = '0.74.5'
  s.summary                = "-"  # TODO
  s.homepage               = "https://reactnative.dev/"
  s.license                = 'MIT'
  s.author                 = "Meta Platforms, Inc. and its affiliates"
  s.platforms              = { :ios => '13.4' }
  s.source                 = { :git => 'https://github.com/freezy7/react-native-sdk.git', :tag => "v#{spec.version}" }
  s.source_files           = "node_modules/react-native/Libraries/FBLazyVector/**/*.{c,h,m,mm,cpp}"
  s.header_dir             = "FBLazyVector"
  s.libraries = "c++"

end
