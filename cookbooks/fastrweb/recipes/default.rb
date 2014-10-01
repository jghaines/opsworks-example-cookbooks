#
# Cookbook Name:: fastrweb
# Recipe:: default
#
# Copyright 2014, geldberg
#
# All rights reserved - Do Not Redistribute
#

##
## pre-requisite packages - thanks to http://frisby2.blogspot.ch/2012/07/installing-r-package-fastrweb.html
##
yum_package "cairo-devel" do
  action :install
end

yum_package "libXt" do
        action :install
end

yum_package "libXt-devel" do
        action :install
end

##
## install R
##
yum_package "R" do
        action :install
end

##
## install R packages
##
r_packages = %w( Rserve FastRWeb jsonlite )
r_repo = 'http://cran.rstudio.com/'

r_packages.each do |package|
  execute "R_package_install_#{package}" do
    command %Q[Rscript -e 'install.packages("#{package}", repos="#{r_repo}")']
    not_if { File.exist? "/usr/lib64/R/library/#{package}" }
  end
end

##
## FastRWeb setup/install
##
execute "FastRWeb_install" do
  cwd '/usr/lib64/R/library/FastRWeb'
  command './install.sh'
end

##
## Install Rcgi in cgi-bin
##
file "/var/www/cgi-bin/Rcgi" do
  owner 'root'
  group 'root'
  mode 0755
  content ::File.open('/usr/lib64/R/library/FastRWeb/cgi-bin/Rcgi').read
  action :create
end

