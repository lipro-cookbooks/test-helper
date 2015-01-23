#
# Cookbook Name:: wawision
# Spec:: unsupported_platforms
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
# Be in sync with the fauxhai platform support:
#   URL=https://github.com/customink/fauxhai/tree/master/lib/fauxhai/platforms
#   curl -s $URL | grep js-directory-link | sed "s/.* title=\"\(.*\)\".*/\1/"
#
# rubocop:disable Metrics/MethodLength
def unsupported_platforms
  _platforms = {
    #
    # os: 'linux'
    # platform_family: 'fedora'
    'fedora'    => %w(21 20 19 18),
    # platform_family: 'suse'
    'opensuse'  => %w(13.1 12.3),
    'suse'      => %w(12.0 11.3 11.2 11.1),
    # platform_family: 'arch'
    'arch'      => %w(3.10.5-1-ARCH),
    # platform_family: 'gentoo'
    'gentoo'    => %w(2.1),
    # platform_family: 'slackware'
    'slackware' => %w(14.1),
    #
    # os: 'freebsd'
    # platform_family: 'freebsd'
    'freebsd'   => %w(10.0 9.2 9.1 8.4),
    #
    # os: 'openbsd'
    # platform_family: 'openbsd'
    'openbsd'   => %w(5.4),
    #
    # os: 'solaris2'
    # platform_family: 'omnios'
    'omnios'    => %w(151008 151006 151002),
    # platform_family: 'smartos'
    'smartos'   => %w(5.11),
    # platform_family: 'solaris2'
    'solaris2'  => %w(5.11),
    #
    # os: 'aix'
    # platform_family: 'aix'
    'aix'       => %w(7.1 6.1),
    #
    # os: 'darwin'
    # platform_family: 'mac_os_x'
    'mac_os_x'  => %w(10.10 10.9.2 10.8.2 10.7.4 10.6.8),
    #
    # os: 'windows'
    # platform_family: 'windows'
    'windows'   => %w(2012R2 2012 2008R2 2003R2)
  }
end
# rubocop:enable Metrics/MethodLength

# vim: ts=2 sts=2 sw=2 ai si et ft=ruby
