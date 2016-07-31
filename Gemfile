#
# Cookbook Name:: test-helper
# Build:: Gemfile
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

# See details for Bundler's Gemfile Syntax on:
# http://bundler.io/v1.10/gemfile.html

source 'https://rubygems.org'

gem 'activesupport', '~>4.2.7'

group :rake do
  gem 'rake', '~>11.2.2'
  gem 'versionomy', '~>0.5.0'
end

group :lint do
  gem 'foodcritic', '~>7.0.1'
  gem 'rubocop', '~>0.42.0'
  gem 'rubocop-checkstyle_formatter', '~>0.2.0'
  gem 'travis-lint', '~>2.0.0'
end

group :unit do
  gem 'berkshelf', '~>4.3.5'
  gem 'chefspec', '~>4.7.0'
  gem 'chef-sugar', '~>3.4.0'
  gem 'ci_reporter_rspec', '~>1.0.0'
  gem 'fauxhai', '~>3.6.0'
end

group :kitchen_common do
  gem 'test-kitchen', '~>1.10.2'
  gem 'serverspec', '~>2.36.0'
end

group :kitchen_vagrant do
  gem 'kitchen-vagrant', '~>0.20.0'
end

group :kitchen_docker do
  gem 'kitchen-docker', '~>2.5.0'
end

# vim: ts=2 sts=2 sw=2 ai si et ft=ruby
