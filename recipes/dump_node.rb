#
# Cookbook Name:: test-helper
# Recipe:: dump_node
#
# Author:: Stephan Linz <linz@li-pro.net>
# Author:: Konstantin Lysenko <gshaud@gmail.com>
#
# Copyright:: 2015, Li-Pro.Net
# Copyright:: 2014, Konstantin Lysenko
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

include_recipe 'test-helper::commons'

chef_gem 'activesupport' do
  version '< 5'
end

require 'pathname'
require 'active_support/core_ext/hash/deep_merge'

# See details for Standard Resource Types on:
# https://docs.getchef.com/resources.html

th = node['test-helper']

directory th['dir'] do
  owner 'root'
  group 'root'
  mode '0750'
  recursive true
end

file "#{th['dir']}/#{th['node']}" do
  owner 'root'
  group 'root'
  mode '0400'
end

log "Dumping attributes to `#{th['dir']}/#{th['node']}`."

ruby_block 'Dump node attributes' do # ~FC014
  block do
    require 'json'

    # collect the run list
    recipe_json = '{ "run_list": [ '
    recipe_json << node.run_list.expand(
      node.chef_environment
    ).recipes.map! do |k|
      "\"#{k}\""
    end.join(',')
    recipe_json << ' ] }'

    attrs = {}

    # collect and add automatic ohai attrs
    attrs = attrs.deep_merge(
      node.automatic_attrs
    ) unless node.automatic_attrs.empty?

    # collect and add all defaults
    attrs = attrs.deep_merge(
      node.default_attrs
    ) unless node.default_attrs.empty?

    # collect and add all normals (???)
    attrs = attrs.deep_merge(
      node.normal_attrs
    ) unless node.normal_attrs.empty?

    # collect and add all overrides
    attrs = attrs.deep_merge(
      node.override_attrs
    ) unless node.override_attrs.empty?

    # add the run list
    attrs = attrs.deep_merge(JSON.parse(recipe_json))

    # write node attributes to dump file
    File.open("#{th['dir']}/#{th['node']}", 'w') do |file|
      file.write(JSON.pretty_generate(attrs))
    end
  end
end

# vim: ts=2 sts=2 sw=2 ai si et ft=ruby
