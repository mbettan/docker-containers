#!/bin/sh

/etc/init.d/ssh start
/usr/local/bin/run_chef_server & > /var/log/chef-server/run_chef_server.log 2>&1
sleep 200
cd /var/chef/cookbooks && knife ssl fetch && knife cookbook upload apache

exec tail -f /var/log/chef-server/run_chef_server.log
