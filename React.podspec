# Copyright (c) Meta Platforms, Inc. and affiliates.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

version = '0.74.5'
folly_compiler_flags = '-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1 -DFOLLY_CFG_NO_COROUTINES=1 -DFOLLY_HAVE_CLOCK_GETTIME=1 -Wno-comma -Wno-shorten-64-to-32'
folly_version = '2024.01.01.00'
boost_compiler_flags = '-Wno-documentation'

Pod::Spec.new do |s|
  s.name                   = "React"
  s.version                = version
  s.summary                = "-"
  s.description            = <<-DESC
                               React Native apps are built using the React JS
                               framework, and render directly to native UIKit
                               elements using a fully asynchronous architecture.
                               There is no browser and no HTML. We have picked what
                               we think is the best set of features from these and
                               other technologies to build what we hope to become
                               the best product development framework available,
                               with an emphasis on iteration speed, developer
                               delight, continuity of technology, and absolutely
                               beautiful and fast products with no compromises in
                               quality or capability.
                             DESC
  s.homepage               = "https://reactnative.dev/"
  s.license                = "MIT"
  s.author                 = "Meta Platforms, Inc. and its affiliates"
  s.platforms              = { :ios => '13.4' }
  s.source                 = { :git => 'https://github.com/freezy7/react-native-sdk.git', :tag => "v#{s.version}" }
  
  s.cocoapods_version      = ">= 1.10.1"

  s.dependency "React-Core", version
  s.dependency "React-Core/DevSupport", version
  s.dependency "React-Core/RCTWebSocket", version
  s.dependency "React-RCTActionSheet", version
  s.dependency "React-RCTAnimation", version
  s.dependency "React-RCTBlob", version
  s.dependency "React-RCTImage", version
  s.dependency "React-RCTLinking", version
  s.dependency "React-RCTNetwork", version
  s.dependency "React-RCTSettings", version
  s.dependency "React-RCTText", version
  s.dependency "React-RCTVibration", version
end
