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
# http://bundler.io/v1.7/gemfile.html

source 'https://rubygems.org'

gem 'activesupport', '~>4.2.0'

gem 'berkshelf', '~>3.2.2'
gem 'rake', '~>10.4.2'
gem 'versionomy', '~>0.4.4'
gem 'foodcritic', '~>4.0.0'
gem 'thor-foodcritic', '~>0.2.0'
gem 'rubocop', '~>0.28.0'
gem 'rubocop-checkstyle_formatter', '~>0.1.1'
gem 'chefspec', '~>4.2.0'
gem 'ci_reporter_rspec', '~>1.0.0'
gem 'fauxhai', github: 'customink/fauxhai', branch: 'master'

group :integration do
  gem 'test-kitchen', '~>1.2.1'
  gem 'kitchen-vagrant', '~>0.15.0'
  gem 'vagrant-wrapper', '~>2.0.1'
  gem 'serverspec', '~>2.7.1'
end

# vim: ts=2 sts=2 sw=2 ai si et ft=ruby
