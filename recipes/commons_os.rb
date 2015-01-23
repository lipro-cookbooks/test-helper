#
# Cookbook Name:: test-helper
# Recipe:: commons_os
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

case node['os']
when 'linux'
  log "`#{node['os']}` is supported!" do
    level :info
  end
  case node['platform_family']
  when 'debian', 'rhel'
    log "`#{node['platform']}-#{node['platform_version']}` is supported!" do
      level :info
    end
  else
    fail "`#{node['platform']}` is not supported!"
  end
else
  fail "`#{node['platform']}` is not supported!"
end

# vim: ts=2 sts=2 sw=2 ai si et ft=ruby
