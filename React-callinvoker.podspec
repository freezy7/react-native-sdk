# Copyright (c) Meta Platforms, Inc. and affiliates.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

Pod::Spec.new do |s|
  s.name                   = "React-callinvoker"
  s.version                = '0.74.5'
  s.summary                = "-"  # TODO
  s.homepage               = "https://reactnative.dev/"
  s.license                = 'MIT'
  s.author                 = "Meta Platforms, Inc. and its affiliates"
  s.platforms              = { :ios => '13.4' }
  s.source                 = { :http => "https://github.com/freezy7/react-native-sdk/releases/download/v#{s.version}/React-callinvoker.zip" }
  s.source_files           = "node_modules/react-native/ReactCommon/callinvoker/**/*.{cpp,h}"
  s.header_dir             = "ReactCommon"
  s.libraries = "c++"
end
