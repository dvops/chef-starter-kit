#
# Cookbook Name:: web
# Recipe:: default
#
# Copyright 2015, vishvish
#
# All rights reserved - Do Not Redistribute

package 'Nginx' do
  package_name 'nginx'
end

template '/etc/nginx/nginx.conf' do
  source 'nginx.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

service 'nginx' do
  action :restart
end
