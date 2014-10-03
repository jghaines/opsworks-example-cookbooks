#
# Cookbook Name:: fastrweb
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

log "Hello world from fastrweb/recipes/default.rb"

template "#{ENV['HOME']}/fastrweb.txt" do
  source "fastrweb.txt.erb"
  variables({:version => '0'})
  mode "0644"
end
