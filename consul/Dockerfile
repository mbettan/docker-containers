FROM ubuntu:14.04

MAINTAINER POC Factory

RUN apt-get update

#SSHD
RUN apt-get install -y openssh-server && \
    mkdir -p /var/run/sshd && \
    echo 'root:admin@123' |chpasswd
RUN sed -i "s/session.*required.*pam_loginuid.so/#session    required     pam_loginuid.so/" /etc/pam.d/sshd
RUN sed -i "s/PermitRootLogin without-password/#PermitRootLogin without-password/" /etc/ssh/sshd_config


#Utilities
RUN apt-get install -y nano net-tools curl git tree unzip expect 


#Consul Installation
WORKDIR /usr/local/bin 
RUN wget https://releases.hashicorp.com/consul/0.6.3/consul_0.6.3_linux_amd64.zip 
RUN unzip *.zip
RUN rm -rf *.zip

WORKDIR / 
RUN mkdir /consul.d 
RUN mkdir /ui 
RUN mkdir -p /consul.d/conf.d

WORKDIR /ui
RUN wget https://releases.hashicorp.com/consul/0.6.3/consul_0.6.3_web_ui.zip
RUN unzip *.zip
RUN rm -rf *.zip

ADD ./start-consul.sh /usr/local/sbin/start-consul.sh

#Add configuration files 
ADD ./conf/* /consul.d/conf.d/

RUN chmod a+x /consul.d/conf.d/*

RUN chmod +x /usr/local/sbin/start-consul.sh

EXPOSE 22 8500 53 8400

CMD [ "/usr/local/sbin/start-consul.sh"]
