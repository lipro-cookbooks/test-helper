#
# Cookbook Name:: test-helper
# Test:: assert_dump_node_default_spec
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

require "#{ENV['BUSSER_ROOT']}/../kitchen/data/spec_helper"

# See details for Standard Resource Types on:
# http://serverspec.org/resource_types.html

# See details for Custom Resource Types on:
# http://www.tuicool.com/articles/beiaEbv

describe 'dump_node::default' do
  node = load_nodedump('/tmp/test-helper/node.json')

  th = node[:"test-helper"]

  it "has valid dump path `#{th[:dir]}`" do
    expect(th[:dir]).to eq '/tmp/test-helper'
  end

  it "has valid node dump file `#{th[:node]}`" do
    expect(th[:node]).to eq 'node.json'
  end

  context file(th[:dir].to_s) do
    include_examples 'a directory' do
      let(:drn) { th[:dir].to_s }
      let(:dmd) { '750' }
      let(:usr) { 'root' }
      let(:grp) { 'root' }
    end
  end

  context file("#{th[:dir]}/#{th[:node]}") do
    include_examples 'a file' do
      let(:fln) { "#{th[:dir]}/#{th[:node]}" }
      let(:fmd) { '400' }
      let(:usr) { 'root' }
      let(:grp) { 'root' }
    end
  end
end

# vim: ts=2 sts=2 sw=2 ai si et ft=ruby
