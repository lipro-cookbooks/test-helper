#
# Cookbook Name:: test-helper
# Build:: metadata
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

# See details for Chef Metadata Syntax on:
# https://docs.getchef.com/config_rb_metadata.html

name 'test-helper'
version '1.2.0'

license 'Apache 2.0'

maintainer 'Stephan Linz'
maintainer_email 'linz@li-pro.net'

description 'Dumps chef node data to json file'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))

if respond_to?(:source_url)
  source_url 'https://github.com/lipro-cookbooks/test-helper'
end

if respond_to?(:issues_url)
  issues_url 'https://github.com/lipro-cookbooks/test-helper/issues'
end

%w(
  debian
  ubuntu
  centos
  redhat
  oracle
  amazon
).each do |os|
  supports os
end

recipe 'default', 'Roes run dump_node recipe as default.'
recipe 'dump_node', 'Dumps chef node data to json file.'

provides 'test-helper'

attribute 'test-helper/dir',
  display_name: 'Test helper working directory',
  description: 'The location where to store all generated data.',
  type: 'string',
  default: '/tmp/test-helper'

attribute 'test-helper/node',
  display_name: 'Test helper node dump file',
  description: 'The name of the node dump file.',
  type: 'string',
  default: 'node.json'

# vim: ts=2 sts=2 sw=2 ai si et ft=ruby
