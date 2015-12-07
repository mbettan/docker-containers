FROM centos:6.6
MAINTAINER Syphax GUEMGHAR sguemghar@itsoverlap.com
RUN yum install -y ntp openssh-server openssh-clients httpd httpd-devel mod_ssl ruby-devel rubygems gcc gcc-c++ curl-devel openssl-devel zlib-devel createrepo rsync
RUN echo "HP1nvent" | passwd root --stdin
RUN rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
RUN sed -i 's/enabled=0/enabled=1/' /etc/yum.repos.d/puppetlabs.repo
RUN yum install -y puppet-server
#RUN sed -i '14i dns_alt_names = puppet' /etc/puppet/puppet.conf

RUN mkdir -p /etc/puppet/environments/production/manifests
RUN mkdir -p /etc/puppet/environments/development/manifests
RUN mkdir -p /etc/puppet/environments/production/modules
RUN mkdir -p /etc/puppet/environments/development/modules

#RUN sed -i '15i environmentpath = $confdir/environments' /etc/puppet/puppet.conf

ADD ./puppet.conf /etc/puppet/
ADD ./autosign.conf /etc/puppet/

RUN service puppetmaster start && service puppetmaster stop

RUN sed -i '275i ServerName puppet:80' /etc/httpd/conf/httpd.conf

RUN gem install rack passenger

RUN passenger-install-apache2-module --auto

RUN mkdir -p /usr/share/puppet/rack/puppetmasterd/public
RUN mkdir /usr/share/puppet/rack/puppetmasterd/tmp
RUN cp /usr/share/puppet/ext/rack/config.ru /usr/share/puppet/rack/puppetmasterd/
RUN chown puppet:puppet /usr/share/puppet/rack/puppetmasterd/config.ru

RUN service httpd start

RUN mkdir -p /home/puppet-dashboard/puppetagent

ADD ./start-app.sh /usr/local/sbin/start-app.sh
ADD ./puppetmaster.conf /etc/httpd/conf.d/puppetmaster.conf
ADD ./deployagent.sh /home/puppet-dashboard/puppetagent/deployagent.sh
ADD ./nodes.pp  /etc/puppet/environments/production/manifests/nodes.pp
ADD ./site.pp    /etc/puppet/environments/production/manifests/site.pp
ADD ./mysqlrpms/init.pp  /etc/puppet/environments/production/modules/mysqlrpms/init.pp

EXPOSE 8140 80 22

RUN chmod +x /usr/local/sbin/start-app.sh
CMD [ "/usr/local/sbin/start-app.sh", "-s default"]