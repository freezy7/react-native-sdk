# Copyright (c) Meta Platforms, Inc. and affiliates.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

version = '0.74.5'

source_path = 'node_modules/react-native/ReactCommon/yoga'

Pod::Spec.new do |spec|
  spec.name = 'Yoga'
  spec.version = version
  spec.license =  { :type => 'MIT' }
  spec.homepage = 'https://yogalayout.dev'
  spec.documentation_url = 'https://yogalayout.dev/docs/'

  spec.summary = 'Yoga is a cross-platform layout engine which implements Flexbox.'
  spec.description = 'Yoga is a cross-platform layout engine enabling maximum collaboration within your team by implementing an API many designers are familiar with, and opening it up to developers across different platforms.'

  spec.authors = 'Facebook'
  s.platforms  = { :ios => '13.4' }
  s.source     = { :git => 'https://github.com/freezy7/react-native-sdk.git', :tag => "v#{s.version}" }

  spec.module_name = 'yoga'
  spec.header_dir = 'yoga'
  spec.requires_arc = false
  spec.pod_target_xcconfig = {
      'DEFINES_MODULE' => 'YES'
  }

  spec.compiler_flags = [
      '-fno-omit-frame-pointer',
      '-fexceptions',
      '-Wall',
      '-Werror',
      '-std=c++20',
      '-fPIC'
  ]

  # Set this environment variable when *not* using the `:path` option to install the pod.
  # E.g. when publishing this spec to a spec repo.
  source_files = "#{source_path}/yoga/**/*.{cpp,h}"
  spec.source_files = source_files
  spec.header_mappings_dir = 'yoga'

  public_header_files = "#{source_path}/yoga/*.h"
  spec.public_header_files = public_header_files

  # Fabric must be able to access private headers (which should not be included in the umbrella header)
  all_header_files = "#{source_path}/yoga/**/*.h"
  spec.private_header_files = Dir.glob(all_header_files) - Dir.glob(public_header_files)
  spec.preserve_paths = [all_header_files]
end
