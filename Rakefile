#
# Cookbook Name:: test-helper
# Build:: Rakefile
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

# Maybe usefull:
# https://github.com/burtlo/cookbook-raketasks

# require 'cookbook/raketasks'

# See details for Foodcritic Rules on:
# https://docs.getchef.com/foodcritic.html
# https://github.com/acrmp/foodcritic

require 'foodcritic'

# See details for Rubocop and Checkstyle Formatter on:
# https://github.com/bbatsov/rubocop
# https://github.com/eitoball/rubocop-checkstyle_formatter

require 'rubocop/rake_task'

# See details for RSpec on:
# https://www.relishapp.com/rspec/rspec-core/docs/command-line/rake-task
# https://www.relishapp.com/rspec
# https://github.com/rspec/rspec
# https://github.com/ci-reporter/ci_reporter
# https://github.com/ci-reporter/ci_reporter_rspec

# See details for Chefspec on:
# https://docs.getchef.com/chefspec.html
# https://github.com/sethvargo/chefspec

require 'rspec/core/rake_task'
require 'ci/reporter/rake/rspec'

# See details for Test Kitchen on:
# https://docs.getchef.com/kitchen.html
# https://github.com/test-kitchen/test-kitchen

require 'kitchen'

# See details for Versionomy on:
# https://github.com/dazuma/versionomy

require 'versionomy'

################################################################################

desc 'Bump version number (type is one of: :major, :minor, :tiny)'
task :bump, :type do |args|
  args.with_defaults(type: 'tiny')
  content = File.read('metadata.rb')

  version_pattern = /(version.*?')(.*?)(')/
  current_version = content.match(version_pattern)[2]
  next_version    = Versionomy.parse(Regexp.last_match[2]).bump(args.type).to_s

  File.write(
    'metadata.rb',
    content.gsub(version_pattern, "\\1#{next_version}\\3")
  )

  puts "Version bumped from #{current_version} to #{next_version}!"
end

################################################################################

desc 'Get cookbook name and version'
task :cookbook do
  content = File.read('metadata.rb')

  name_pattern = /(name.*?')(.*?)(')/
  version_pattern = /(version.*?')(.*?)(')/
  version = content.match(version_pattern)[2]
  name = content.match(name_pattern)[2]

  puts "#{name}-#{version}"
end

################################################################################

desc 'Get cookbook version'
task :version do
  content = File.read('metadata.rb')

  version_pattern = /(version.*?')(.*?)(')/
  version = content.match(version_pattern)[2]

  puts "#{version}"
end

################################################################################

desc 'Get cookbook name'
task :name do
  content = File.read('metadata.rb')

  name_pattern = /(name.*?')(.*?)(')/
  name = content.match(name_pattern)[2]

  puts "#{name}"
end

################################################################################

desc 'Run linting and unit tests (default)'
task test: %w(lint unit)
task default: 'test'

################################################################################

# We cannot run Test Kitchen on Travis CI yet...
desc 'Run all tests on Travis'
task travis: %w(lint unit)

################################################################################

desc 'Run Foodcritic and Rubocop'
task lint: %w(foodcritic rubocop)

################################################################################

desc 'Run Foodcritic lint checks'
FoodCritic::Rake::LintTask.new(:foodcritic) do |t|
  t.options = {
    tags: %w(~FC003),
    include_rules: %w(foodcritic/customink foodcritic/etsy),
    fail_tags: %w(any),
    context: true
  }
end

################################################################################

desc 'Run Rubocop lint checks'
RuboCop::RakeTask.new(:rubocop) do |t|
  t.requires = %w(
    rubocop/formatter/checkstyle_formatter
  )
  t.formatters = %w(
    progress
    RuboCop::Formatter::CheckstyleFormatter
  )
  t.options = %w(
    --out lint/reports/checkstyle.xml
    --fail-level error
    --display-cop-names
  )
  t.fail_on_error = true
  t.verbose = false
end

################################################################################

desc 'Run all Chefspec test suites'
task unit: %w(ci:setup:rspecdoc)
RSpec::Core::RakeTask.new(:unit) do |t|
  t.rspec_opts = %w(
    --color
  )
  t.fail_on_error = true
  t.verbose = false
end

SPEC_SUITES = [
  { id: :all, title: 'all',
    pattern: 'spec/**{,/*/**}/*_spec.rb' },
  { id: :dump, title: 'dump',
    pattern: 'spec/recipe/{,_*}dump{,_*}_spec.rb' },
  { id: :commons, title: 'commons',
    pattern: 'spec/recipe/{,_*}commons{,_*}_spec.rb' },
  { id: :default, title: 'default',
    pattern: 'spec/recipe/default_spec.rb' }
]

namespace :unit do
  namespace :suite do
    SPEC_SUITES.each do |suite|
      desc "Run #{suite[:title]} Chefspec test suite"
      RSpec::Core::RakeTask.new(suite[:id]) do |t|
        t.pattern = suite[:pattern]
        t.rspec_opts = %w(vagrant -v --color --format documentation)
        t.fail_on_error = true
        t.verbose = false
      end
    end
  end
end

################################################################################

desc 'Run Test Kitchen with Vagrant'
task :integration do
  Kitchen.logger = Kitchen.default_file_logger
  Kitchen::Config.new.instances.each do |instance|
    instance.test(:always)
  end
end

# vim: ts=2 sts=2 sw=2 ai si et ft=ruby
