#
# Cookbook Name:: test-helper
# Spec:: dump_node_spec
#
# Author:: Stephan Linz <linz@li-pro.net>
#
# Copyright:: 2015, Li-Pro.Net
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'spec_helper'

# See details for Standard Resource Types on:
# https://docs.getchef.com/chefspec.html

# See details for Ruby Block Resource Type on:
# https://github.com/sethvargo/chefspec/blob/master/lib/chefspec/api/ruby_block.rb

###############################################################################
#
# examples, shared over local tests
#

#
# Usage:
#
#   include_examples 'prepare test helper runtime environment' do
#     let(:dir)   { '__YOUR_DUMP_DIR_NAME__' }
#     let(:node)  { '__YOUR_NODE_DUMP_FILE_NAME__' }
#   end
#
shared_examples_for 'prepare test helper runtime environment' do
  it 'installs chef_gem active support' do
    expect(chef_run).to install_chef_gem('activesupport')
    expect(chef_run).to_not install_chef_gem('not_activesupport')
  end

  it 'creates the test helper directory' do
    expect(chef_run).to create_directory(dir)
      .with_owner('root')
      .with_group('root')
      .with_mode('0750')
      .with_recursive(true)
  end

  it 'creates the node dump file' do
    expect(chef_run).to create_file("#{dir}/#{node}")
      .with_owner('root')
      .with_group('root')
      .with_mode('0400')
  end
end

#
# Usage:
#
#   include_examples 'dump node' do
#     let(:dir)   { '__YOUR_DUMP_DIR_NAME__' }
#     let(:node)  { '__YOUR_NODE_DUMP_FILE_NAME__' }
#   end
#
shared_examples_for 'dump node' do
  it 'writes a log with info level' do
    expect(chef_run).to write_log("Dumping attributes to `#{dir}/#{node}`.")
      .with_level(:info)
  end

  it 'run ruby block' do
    expect(chef_run).to run_ruby_block('Dump node attributes')
      .with_action([:run])
  end
end

###############################################################################
#
# tests recipe inclusion, shared over all supported platforms
#
shared_examples 'dump_node_recipes' do |platform, version|
  context "on #{platform} #{version} with recipes" do
    _property = load_platform_properties(
      platform: platform,
      platform_version: version
    )

    cached(:chef_run) do
      ChefSpec::SoloRunner.new(platform: platform, version: version)
        .converge(described_recipe)
    end
    subject { chef_run }

    include_examples 'supported platform' do
      let(:pn) { platform }
      let(:pv) { version }
    end

    include_examples 'included recipes', %w(
      test-helper::commons
      test-helper::commons_os
    )
  end
end

###############################################################################
#
# tests with node defaults, shared over all supported platforms
#
shared_examples 'dump_node_defaults' do |platform, version|
  context "on #{platform} #{version} with defaults" do
    property = load_platform_properties(
      platform: platform,
      platform_version: version
    )

    th = property[:"test-helper"]

    cached(:chef_run) do
      ChefSpec::SoloRunner.new(platform: platform, version: version)
        .converge(described_recipe)
    end
    subject { chef_run }

    include_examples 'prepare test helper runtime environment' do
      let(:dir)  { th[:dir].to_s }
      let(:node) { th[:node].to_s }
    end

    include_examples 'dump node' do
      let(:dir)  { th[:dir].to_s }
      let(:node) { th[:node].to_s }
    end
  end
end

###############################################################################
#
# tests with node overrides, shared over all supported platforms
#
shared_examples 'dump_node_overrides' do |platform, version|
  context "on #{platform} #{version} with overrides" do
    _property = load_platform_properties(
      platform: platform,
      platform_version: version
    )

    cached(:chef_run) do
      ChefSpec::SoloRunner.new(platform: platform, version: version) do |node|
        node.set['test-helper']['dir'] = '/foo'
        node.set['test-helper']['node'] = 'bar'
      end.converge(described_recipe)
    end
    subject { chef_run }

    include_examples 'prepare test helper runtime environment' do
      let(:dir)  { '/foo' }
      let(:node) { 'bar' }
    end

    include_examples 'dump node' do
      let(:dir)  { '/foo' }
      let(:node) { 'bar' }
    end
  end
end

###############################################################################
#
# raises an exception test, shared over all unsupported platforms
#
shared_examples 'dump_node_unsupported' do |platform, version|
  context "on #{platform} #{version} (unsupported)" do
    cached(:chef_run) do
      ChefSpec::SoloRunner.new(platform: platform, version: version)
        .converge(described_recipe)
    end
    subject { chef_run }

    include_examples 'unsupported platform' do
      let(:pn) { platform }
      let(:pv) { version }
    end
  end
end

###############################################################################
#
# platform overrun
#
describe 'test-helper::dump_node' do
  # Test on all supported platforms
  supported_platforms.each do |platform, versions|
    versions.each do |version|
      include_examples 'dump_node_recipes', platform, version
      include_examples 'dump_node_defaults', platform, version
      include_examples 'dump_node_overrides', platform, version
    end
  end

  # Test on all unsupported platforms
  unsupported_platforms.each do |platform, versions|
    versions.each do |version|
      include_examples 'dump_node_unsupported', platform, version
    end
  end
end

# vim: ts=2 sts=2 sw=2 ai si et ft=ruby
