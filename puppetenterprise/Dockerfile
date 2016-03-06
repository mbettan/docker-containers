FROM centos:6.6
MAINTAINER POC Factory

RUN yum install -y wget tar pciutils system-logos which libxml2 dmidecode net-tools virt-what apr apr-util curl mailcap libjpeg openssh-server libtool-ltdl unixODBC libxslt zlib
RUN echo "admin@123" | passwd root --stdin

RUN echo "192.168.1.2 example.com" >> /etc/hosts
RUN cp /etc/hosts /etc/hosts.txt
RUN container_ip=$(cat /etc/hosts | awk '{print $1}' | head  -1) \
	&& echo $container_ip "pecontainer" >> /etc/hosts
	
RUN wget "https://pm.puppetlabs.com/cgi-bin/download.cgi?dist=el&rel=6&arch=x86_64&ver=latest" -O puppet-enterprise-2015.3.2-el-6-x86_64.tar.gz
RUN tar -xvf puppet-enterprise-2015.3.2-el-6-x86_64.tar.gz

ADD ./pe_start.sh /usr/local/sbin/pe_start.sh
ADD ./pe.poc.answers.txt puppet-enterprise-2015.3.2-el-6-x86_64/answers/pe.poc.answers.txt

RUN sed -i "s/172.16.1.178/172.16.1.147/g" puppet-enterprise-2015.3.2-el-6-x86_64/answers/pe.poc.answers.txt

EXPOSE 8140 61613 443 80 22

RUN chmod +x /usr/local/sbin/pe_start.sh
CMD [ "/usr/local/sbin/pe_start.sh", "-s default"]