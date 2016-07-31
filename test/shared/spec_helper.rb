#
# Cookbook Name:: test-helper
# Test:: spec_helper
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

require 'serverspec'
require 'pathname'
require 'json'

# Required by serverspec
set :backend, :exec

# centos-59 doesn't have /sbin in the default path,
# so we must ensure it's on serverspec's path
set :path, '/sbin:/usr/sbin:/usr/local/sbin:$PATH'

# Require support files
Dir[File.expand_path('../support/**/*.rb', __FILE__)].each do |file|
  require_relative(file)
end

# http://serverspec.org/advanced_tips.html --> How to get OS information
# os[:family]  # RedHat, Ubuntu, Debian and so on
# os[:release] # OS release version (cleaned up in v2)
# os[:arch]
osmapping = {
  'redhat' => {
    platform_family: 'rhel',
    platform: 'centos',
    platform_version: '7.2'
  },
  'ubuntu' => {
    platform_family: 'debian',
    platform: 'ubuntu',
    platform_version: '16.04'
  }
}

# rubocop:disable Metrics/MethodLength, Metrics/AbcSize
def ohai_platform(os, osmapping)
  puts 'serverspec os detected as: ' \
    "#{os[:family]} #{os[:release]} [#{os[:arch]}]"

  osmfam = osmapping[os[:family]]

  ohaistub = {}
  ohaistub[:platform_family] = osmfam[:platform_family]
  ohaistub[:platform] = osmfam[:platform]

  if os[:release]
    ohaistub[:platform_version] = os[:release]
  else
    ohaistub[:platform_version] = osmfam[:platform_version]
  end

  ohaistub
end
# rubocop:enable Metrics/MethodLength, Metrics/AbcSize

# rubocop:disable Metrics/MethodLength
def load_nodestub(ohai)
  puts "Loading #{ohai[:platform]}/#{ohai[:platform_version]}.json"

  JSON.parse(
    IO.read(
      File.join(
        ENV['BUSSER_ROOT'].to_s,
        '/../kitchen/data/platforms',
        "/#{ohai[:platform]}/#{ohai[:platform_version]}.json"
      )
    ),
    symbolize_names: true
  )
end
# rubocop:enable Metrics/MethodLength

def load_nodedump(dump_node)
  puts "Loading #{dump_node}"

  JSON.parse(IO.read(dump_node.to_s), symbolize_names: true)
end

RSpec.configure do |_config|
  set_property load_nodestub(ohai_platform(os, osmapping))
end

# vim: ts=2 sts=2 sw=2 ai si et ft=ruby
