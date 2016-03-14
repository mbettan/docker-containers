#!/bin/sh

/etc/init.d/ssh restart

/usr/local/bin/run_chef_server & > /var/log/chef-server/run_chef_server.log 2>&1
sleep 120
cd /var/chef/cookbooks && knife ssl fetch && knife cookbook upload apache && knife cookbook upload apt && knife cookbook upload java && knife cookbook upload tomcat_latest

exec tail -f /var/log/chef-server/run_chef_server.log
