#
# Cookbook Name:: test-helper
# Spec:: shared_examples
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

#
# Usage:
#
#   include_examples 'supported platform' do
#     let(:pn) { '__YOUR_PLATFORM_NAME__' }
#     let(:pv) { '__YOUR_PLATFORM_VERSION__' }
#   end
#
shared_examples_for 'supported platform' do
  let(:os) { 'linux' }

  it 'writes a log with info level: os' do
    expect(chef_run)
      .to write_log("`#{os}` is supported!")
      .with_level(:info)
  end

  it 'writes a log with info level: platform' do
    expect(chef_run)
      .to write_log("`#{pn}-#{pv}` is supported!")
      .with_level(:info)
  end
end

#
# Usage:
#
#   include_examples 'unsupported platform' do
#     let(:pn) { '__YOUR_PLATFORM_NAME__' }
#     let(:pv) { '__YOUR_PLATFORM_VERSION__' }
#   end
#
shared_examples_for 'unsupported platform' do
  it 'raises an exception' do
    expect { chef_run }
      .to raise_error(RuntimeError, "`#{pn}` is not supported!")
  end
end

#
# Usage:
#
#   include_examples 'included recipes', %w(
#     __COOKBOOK_NAME__::__RECIPE_NAME__
#     __COOKBOOK_NAME__::__RECIPE_NAME__
#     __COOKBOOK_NAME__::__RECIPE_NAME__
#   )
#
shared_examples_for 'included recipes' do |recipes|
  recipes.each do |recipe|
    it "includes the recipe `#{recipe}`" do
      expect(chef_run).to include_recipe(recipe)
    end
  end
end

#
# Usage:
#
#   include_examples 'raises no error on equal' do
#     let(:v1) { '__YOUR_VALUE1_TO_CHECK__' }
#     let(:v2) { '__YOUR_VALUE2_TO_CHECK__' }
#   end
#
shared_examples_for 'raises no error on equal' do
  it 'has valid install method' do
    expect(v2).to eq v1
  end

  it 'raises no error' do
    expect { chef_run }.not_to raise_error
  end
end

#
# Usage:
#
#   include_examples 'raises an recipe not found error' do
#     let(:eem) { '__YOUR_EXPECTED_ERROR_MESSAGE__' }
#   end
#
shared_examples_for 'raises an recipe not found error' do
  it 'raises an error' do
    expect { chef_run }
      .to raise_error(Chef::Exceptions::RecipeNotFound, eem)
  end
end

# vim: ts=2 sts=2 sw=2 ai si et ft=ruby
