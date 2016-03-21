#! /bin/bash 

container_ip=$(cat /etc/hosts | awk '{print $1}' | head  -1) \
        && echo $container_ip "pecontainer" >> /etc/hosts
/etc/init.d/sshd start
/puppet-enterprise-2015.3.2-el-6-x86_64/puppet-enterprise-installer -a /puppet-enterprise-2015.3.2-el-6-x86_64/answers/pe.poc.answers.txt

puppet module install puppetlabs-apache
puppet module install puppetlabs-mysql

cp -r /puppet-enterprise-2015.3.2-el-6-x86_64/answers/myapachemario /etc/puppetlabs/code/environments/production/modules/myapachemario
cp -r /puppet-enterprise-2015.3.2-el-6-x86_64/answers/myapacheluigi /etc/puppetlabs/code/environments/production/modules/myapacheluigi
cp -r /puppet-enterprise-2015.3.2-el-6-x86_64/answers/mysqlserver /etc/puppetlabs/code/environments/production/modules/mysqlserver

tail -f > /dev/null