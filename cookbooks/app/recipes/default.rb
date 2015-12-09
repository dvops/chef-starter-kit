#
# Cookbook Name:: app
# Recipe:: default
#
# Copyright 2015, vishvish
#
# All rights reserved - Do Not Redistribute

package 'golang'
package 'git'

git '/var/www/app' do
  repository 'https://gist.github.com/f67f50ee73bffa14d869.git'
  action :export
end

execute 'Build and run server' do
  command 'cd /var/www/app && go build server.go && ./server &'
end
