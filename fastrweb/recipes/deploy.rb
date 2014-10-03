#
# Cookbook Name:: fastrweb
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

log "Hello world from fastrweb/recipes/deploy.rb"

node[:deploy].each do |node_deploy] 
	log "In a node"
	log "#{node_deploy[:deploy_to]}"
end


template "#{ENV['HOME']}/fastrweb.deploy.txt" do
  source "fastrweb.txt.erb"
  variables({:version => '0'})
  mode "0644"
end
