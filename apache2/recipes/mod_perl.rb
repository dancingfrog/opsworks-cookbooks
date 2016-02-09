#
# Cookbook Name:: apache2
# Recipe:: perl5 
#
# Copyright 2008, OpsCode, Inc.
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

case node[:platform_family]
when 'debian'
  package 'libapache2-mod-perl2' do
    action :install
  end
  package 'libapache2-mod-perl2-dev' do
    action :install
  end
end

apache_module 'perl' do
  if platform_family?('rhel')
    filename 'libperl.so'
  end
end
