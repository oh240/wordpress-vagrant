#
# Cookbook Name:: php-install
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute "apt-get" do
  command "apt-get update"
end

packages = %w{git subversion vim apache2 php5 php5-mysql php5-dev php5-gd php5-pgsql php5-curl php5-mcrypt php5-cli php5-fpm php-pear mysql-server postgresql curl imagemagick php5-imagick}

packages.each do |pkg|
	package pkg do
		action [:install, :upgrade]
	end
end

template "000-default.conf"  do
	path "/etc/apache2/sites-available/000-default.conf"
	owner "root"
	group "root"
	mode 0644
	notifies :restart, 'service[apache2]'
end


execute "mysql-create-database" do
	command "mysqladmin -u root create wordpress"
end
service 'apache2' do
	action [:start , :restart]
end
