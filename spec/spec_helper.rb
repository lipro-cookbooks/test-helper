#
# Cookbook Name:: wawision
# Recipe:: spec_helper
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

require 'chefspec'
require 'chefspec/berkshelf'
require 'chefspec/cacher'

# Require support files
Dir[File.expand_path('../support/**/*.rb', __FILE__)].each do |file|
  require_relative(file)
end

RSpec.configure do |config|
  # Specify the colors used in the text formatters.
  # http://relishapp.com/rspec/rspec-core/v/3-1/docs/formatters/configurable-colors
  config.failure_color = :magenta
  config.tty = true
  config.color = true

  # Allow old and new mocks syntax (default is the [:expect] only)
  # http://relishapp.com/rspec/rspec-mocks/v/3-1/docs/old-syntax
  # config.mock_with :rspec do |mocks|
  #   mocks.syntax = [:should, :expect]
  # end

  # Specify the path for Chef Solo to find roles (default: [ascending search])
  # config.role_path = '/var/roles'

  # Specify the Chef log_level (default: :warn)
  # config.log_level = :info

  # FIXME: There is a known but unresolved issue in nginx cookbook that will
  #        produce clone warnings for service[nginx] when using nginx::default
  #        recipe (https://tickets.opscode.com/browse/COOK-3732)
  #
  # QnD hack: https://github.com/miketheman/nginx/commit/75d17cea
  #           prevent resource cloning wanrings during testing
  #
  config.log_level = :error

  # Specify the path to a local JSON file with Ohai data (default: nil)
  # config.path = 'ohai.json'
end

at_exit { ChefSpec::Coverage.report! }

# vim: ts=2 sts=2 sw=2 ai si et ft=ruby
