#
# Cookbook Name:: test-helper
# Spec:: platform_properties
#
# Author:: Stephan Linz <linz@li-pro.net>
# Author:: Sander van Zoest <sander.vanzoest@viverae.com>
#
# Copyright:: 2015, Li-Pro.Net
# Copyright:: 2014, Viverae, Inc.
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

require 'json'

def load_platform_properties(args)
  p = args[:platform]
  pv = args[:platform_version]
  JSON.parse(IO.read(File.join(
    File.dirname(__FILE__),
    "/../../test/shared/platforms/#{p}/#{pv}.json"
  )), symbolize_names: true)
end

# vim: ts=2 sts=2 sw=2 ai si et ft=ruby
