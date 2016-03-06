#! /bin/bash 

container_ip=$(cat /etc/hosts | awk '{print $1}' | head  -1) \
        && echo $container_ip "pecontainer" >> /etc/hosts
/etc/init.d/sshd start
/puppet-enterprise-2015.3.2-el-6-x86_64/puppet-enterprise-installer -a /puppet-enterprise-2015.3.2-el-6-x86_64/answers/pe.poc.answers.txt

tail -f > /dev/null