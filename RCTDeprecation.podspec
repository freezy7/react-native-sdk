# Copyright (c) Meta Platforms, Inc. and affiliates.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

Pod::Spec.new do |s|
    s.name                   = "RCTDeprecation"
    s.version                = '0.74.5'
    s.author                 = "Meta Platforms, Inc. and its affiliates"
    s.license                = 'MIT'
    s.homepage               = "https://reactnative.dev/"
    s.platforms              = { :ios => '13.4' }
    s.source                 = { :git => 'https://github.com/freezy7/react-native-sdk.git', :tag => "v#{s.version}" }
    s.summary                = "Macros for marking APIs as deprecated"
    s.source_files           = [
      "node_modules/react-native/ReactApple/Libraries/RCTFoundation/RCTDeprecation/Exported/*.h", 
      "node_modules/react-native/ReactApple/Libraries/RCTFoundation/RCTDeprecation/RCTDeprecation.m"
    ]
    s.pod_target_xcconfig    = {
      "DEFINES_MODULE" => "YES",
      "CLANG_CXX_LANGUAGE_STANDARD" => "c++20"
    }
    s.compiler_flags         = "-Wnullable-to-nonnull-conversion -Wnullability-completeness"
  end
