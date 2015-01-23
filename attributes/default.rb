#
# Cookbook Name:: test-helper
# Attributes:: default
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

# See details for Attributes on:
# https://docs.getchef.com/attributes.html

default['test-helper'].tap do |th|
  #
  # The path to the location where test-helper will store all generated data.
  #
  th['dir'] = '/tmp/test-helper'

  #
  # The name of the node dump file.
  #
  th['node'] = 'node.json'
end

# vim: ts=2 sts=2 sw=2 ai si et ft=ruby
