# -*- mode: ruby -*-
# vi: set ft=ruby :

class Infrastructure
  def self.nodes
    [
      { hostname: 'app1', box: 'ubuntu/trusty64', role: 'app', memory: 768, ip: '172.25.1.10' },
      { hostname: 'app2', box: 'ubuntu/trusty64', role: 'app', memory: 768, ip: '172.25.1.11' },
      { hostname: 'web1', box: 'ubuntu/trusty64', role: 'load_balancer', memory: 768, ip: '172.25.1.100', message: 'Open http://localhost:2112 in your browser now.' }
    ]
  end
end

Vagrant.configure(2) do |config|
  Infrastructure.nodes.each do |node|
    config.vm.define node[:hostname] do |host_config|
      host_config.vm.box = node[:box]
      host_config.vm.hostname = node[:hostname]

      host_config.vm.network :private_network, ip: node[:ip]

      host_config.vm.provision :chef_zero do |chef|
        chef.cookbooks_path = 'cookbooks'
        chef.roles_path = 'roles'
        chef.add_role node[:role]
      end

      host_config.vm.provider 'virtualbox' do |v|
        v.name = "#{node[:hostname]}-#{node[:ip]}"
        v.memory = node[:memory]
        v.cpus = 1
      end

      # expose the front-end
      if node[:hostname] == "web1"
        config.vm.network "forwarded_port", guest: 80, host: 2112
      end

      if node[:message]
        config.vm.post_up_message = node[:message]
      end
    end
  end
end
