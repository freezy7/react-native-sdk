# Copyright (c) Meta Platforms, Inc. and affiliates.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

Pod::Spec.new do |spec|
  spec.name        = "hermes-engine"
  spec.version     = "0.74.5"
  spec.summary     = "Hermes is a small and lightweight JavaScript engine optimized for running React Native."
  spec.description = "Hermes is a JavaScript engine optimized for fast start-up of React Native apps. It features ahead-of-time static optimization and compact bytecode."
  spec.homepage    = "https://hermesengine.dev"
  spec.license     = 'MIT'
  spec.author      = "Facebook"
  spec.source      = { :http => 'https://repo1.maven.org/maven2/com/facebook/react/react-native-artifacts/0.74.5/react-native-artifacts-0.74.5-hermes-ios-release.tar.gz'}
  spec.platforms   = { :ios => "13.4"}

  spec.preserve_paths      = '**/*.*'

  spec.pod_target_xcconfig = {
                    "CLANG_CXX_LANGUAGE_STANDARD" => "c++20",
                    "CLANG_CXX_LIBRARY" => "compiler-default"
                  }

  spec.ios.vendored_frameworks = "destroot/Library/Frameworks/universal/hermes.xcframework"

  spec.subspec 'Pre-built' do |ss|
      ss.preserve_paths = ["destroot/bin/*"].concat(["**/*.{h,c,cpp}"])
      ss.source_files = "destroot/include/hermes/**/*.h"
      ss.header_mappings_dir = "destroot/include"
      ss.ios.vendored_frameworks = "destroot/Library/Frameworks/universal/hermes.xcframework"
    end
end
