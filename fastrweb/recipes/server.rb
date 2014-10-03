#
# Cookbook Name:: fastrweb
# Recipe:: default
#
# Copyright 2014, geldberg
#
# All rights reserved - Do Not Redistribute
#


#template '/etc/pki/rpm-gpg/RPM-GPG-KEY-amazon-ga' do
#  source 'RPM-GPG-KEY-amazon-ga'
#  action :create_if_missing
#end
#
#template '/etc/yum.repos.d/amzn-main.repo' do
#  source 'amzn-main.repo'
#  action :create_if_missing
#end


##
## pre-requisite packages - thanks to http://frisby2.blogspot.ch/2012/07/installing-r-package-fastrweb.html
##
package "cairo-devel" do
  action :install
end

package "libXt" do
        action :install
end

package "libXt-devel" do
        action :install
end

##
## install R
##
package "r-core" do
        action :install
end

##
## install R packages
##
r_packages = %w( Rserve FastRWeb XML jsonlite )
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
  not_if { File.exist? "/var/FastRWeb" }
end

##
## Install Rcgi in cgi-bin
##
#bash "install_cgi-bin_Rcgi" do
#  code <<-EOL
#  cp /usr/lib64/R/library/FastRWeb/cgi-bin/Rcgi /var/www/cgi-bin/Rcgi
#  EOL
#end


template "/var/FastRWeb/code/rserve.conf" do
  source "rserve.conf.erb"
  variables({:port => '80', :fastrweb_base_dir => '/var/FastRWeb'})
  mode "0644"
end

template "/var/FastRWeb/code/rserve.R" do
  source "rserve.R.erb"
  variables({:port => '80', :fastrweb_base_dir => '/var/FastRWeb'})
  mode "0644"
end
