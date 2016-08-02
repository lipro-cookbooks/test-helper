#
# Cookbook Name:: test-helper
# Test:: shared_examples
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

require 'net/http'
require 'uri'

#
# Usage:
#
#   include_examples 'a user belongs group', false do # or true
#     let(:usr) { '__YOUR_USER_NAME__' }
#     let(:grp) { '__YOUR_GROUP_NAME__' }
#     let(:lsh) { '__YOUR_LOGIN_SHELL_NAME__' }
#     let(:hme) { '__YOUR_HOME_DIR_NAME__' }
#   end
#
# TODO: Test system user/group id when system = true.
#
shared_examples_for 'a user belongs group and home' do |system|
  it "group exists (system account is #{system})" do
    expect(group(grp)).to exist
  end

  it "user exists and belongs to group (system account is #{system})" do
    expect(user(usr)).to exist
    expect(user(usr)).to belong_to_group grp
  end

  it 'user belongs to valid login shell' do
    expect(user(usr)).to have_login_shell lsh
  end

  it 'user belongs to home directory' do
    expect(user(usr)).to have_home_directory hme
  end
end

#
# Usage:
#
#   include_examples 'a directory' do
#     let(:drn) { '__YOUR_DIR_NAME__' }
#     let(:dmd) { '__YOUR_DIR_MODE__' }
#     let(:usr) { '__YOUR_USER_NAME__' }
#     let(:grp) { '__YOUR_GROUP_NAME__' }
#   end
#
shared_examples_for 'a directory' do
  it 'directory exists and has valid mode' do
    expect(file(drn)).to be_directory
    expect(file(drn)).to be_mode dmd
  end

  it 'directory exists and is owned by user' do
    expect(file(drn)).to be_directory
    expect(file(drn)).to be_owned_by usr
  end

  it 'directory exists and is grouped into' do
    expect(file(drn)).to be_directory
    expect(file(drn)).to be_grouped_into grp
  end
end

#
# Usage:
#
#   include_examples 'a file' do
#     let(:fln) { '__YOUR_FILE_NAME__' }
#     let(:fmd) { '__YOUR_FILE_MODE__' }
#     let(:usr) { '__YOUR_USER_NAME__' }
#     let(:grp) { '__YOUR_GROUP_NAME__' }
#   end
#
shared_examples_for 'a file' do
  it 'file exists and has valid mode' do
    expect(file(fln)).to be_file
    expect(file(fln)).to be_mode fmd
  end

  it 'file exists and is owned by user' do
    expect(file(fln)).to be_file
    expect(file(fln)).to be_owned_by usr
  end

  it 'file exists and is grouped into' do
    expect(file(fln)).to be_file
    expect(file(fln)).to be_grouped_into grp
  end
end

#
# Usage:
#
#   include_examples 'a package' do
#     let(:package_name) { '__YOUR_PACKAGE_NAME__' }
#   end
#
shared_examples_for 'a package' do
  it 'is installed' do
    expect((package package_name)).to be_installed
  end
end

#
# Usage:
#
#   include_examples 'a service' do
#     let(:service_name) { '__YOUR_SERVICE_NAME__' }
#   end
#
shared_examples_for 'a service' do
  it 'is enabled' do
    expect((service service_name)).to be_enabled
  end

  it 'is running' do
    expect((service service_name)).to be_running
  end
end

#
# Usage:
#
#   include_examples 'a port' do
#     let(:port_number) { __YOUR_PORT_NUMBER__ }
#     let(:port_proto)  { '__YOUR_PORT_PROTOCOL__' }
#   end
#
shared_examples_for 'a port' do
  it 'is listening' do
    expect((port port_number)).to be_listening.with port_proto
  end
end

#
# Usage:
#
#   include_examples 'a webpage' do
#     let(:uri) { URI.parse('__YOUR_URL__') }
#     let(:content) { %r".*__YOUR_REGEX_OF_CONTENT__.*" }
#     let(:missing) { %r".*__YOUR_REGEX_OF_MISSING__.*" }
#   end
#
shared_examples_for 'a webpage' do
  let(:get_response) { Net::HTTP.get_response(uri) }

  it 'exists' do
    expect(get_response).to be_kind_of(Net::HTTPSuccess)
  end

  it 'have content' do
    expect(get_response.body).to match content
  end

  it 'missing content' do
    expect(get_response.body).to_not match missing
  end
end

# vim: ts=2 sts=2 sw=2 ai si et ft=ruby
