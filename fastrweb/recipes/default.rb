#
# Cookbook Name:: fastrweb
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

log "Hello world from fastrweb/recipes/default.rb"

file "#{ENV['HOME']}/fastrweb.txt" do
  content "Content: Hello world from fastrweb/recipes/default.rb
"
  mode "0644"
end
