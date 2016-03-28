FROM centos:6.6
MAINTAINER POC Factory

RUN yum install -y wget tar pciutils system-logos which libxml2 dmidecode net-tools virt-what apr apr-util curl mailcap libjpeg openssh-server libtool-ltdl unixODBC libxslt zlib
RUN echo "admin@123" | passwd root --stdin
	
RUN wget "https://pm.puppetlabs.com/puppet-enterprise/2015.3.2/puppet-enterprise-2015.3.2-el-6-x86_64.tar.gz?_ga=1.7725813.656896624.1454433992" -O puppet-enterprise-2015.3.2-el-6-x86_64.tar.gz
RUN tar -xvf puppet-enterprise-2015.3.2-el-6-x86_64.tar.gz

ADD ./pe_start.sh /usr/local/sbin/pe_start.sh
ADD ./pe.poc.answers.txt puppet-enterprise-2015.3.2-el-6-x86_64/answers/pe.poc.answers.txt

ADD ./myapacheluigi puppet-enterprise-2015.3.2-el-6-x86_64/answers/myapacheluigi  
ADD ./myapachemario puppet-enterprise-2015.3.2-el-6-x86_64/answers/myapachemario
ADD ./mysqlserver puppet-enterprise-2015.3.2-el-6-x86_64/answers/mysqlserver

RUN sed -i "s/172.16.1.178/$vmdocker-ip-address$/g" puppet-enterprise-2015.3.2-el-6-x86_64/answers/pe.poc.answers.txt

EXPOSE 8140 61613 443 4433 80 22

RUN chmod +x /usr/local/sbin/pe_start.sh
CMD [ "/usr/local/sbin/pe_start.sh", "-s default"]