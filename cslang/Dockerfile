FROM ubuntu:14.04

MAINTAINER POC Factory

RUN apt-get update -y && apt-get install -y python python-pip vim emacs openssh-server git tree openjdk-7-jre 


RUN touch /etc/apt/sources.list.d/atomrepo.list \
	&& echo "deb http://ppa.launchpad.net/webupd8team/atom/ubuntu trusty main" >> /etc/apt/sources.list.d/atomrepo.list \
	&& echo "deb-src http://ppa.launchpad.net/webupd8team/atom/ubuntu trusty main" >> /etc/apt/sources.list.d/atomrepo.list

RUN apt-get update -y && apt-get install -y --force-yes x11-apps atom

RUN apm install language-cloudslang

RUN groupadd -r cslang && useradd -r -g cslang cslang

RUN mkdir -p /usr/cslang \
  && cd /usr/cslang \
  && wget "https://github.com/CloudSlang/cloud-slang/releases/download/cloudslang-0.9.50.0/cslang-cli-with-content.tar.gzip" \
  && tar xvf cslang-cli-with-content.tar.gzip \
  && rm cslang-cli-with-content.tar.gzip



RUN mkdir /tmpgit  
WORKDIR /tmpgit
RUN git clone https://github.com/CloudSlang/cloud-slang-content.git
RUN rsync -a -v /tmpgit/cloud-slang-content/* /usr/cslang/cslang/


WORKDIR /
RUN rm -rf /tmpgit  
RUN git clone https://github.com/FlorianJDF/cslang-heroku.git
RUN cp -r /cslang-heroku/content/io/cloudslang/paas/* /usr/cslang/cslang/content/io/cloudslang/paas/
RUN mkdir /usescases
RUN cp -r /cslang-heroku/test/io/cloudslang/paas/* /usescases/
RUN cp -r /cslang-heroku/test/io/cloudslang/paas/* /usr/cslang/cslang/content/io/cloudslang/paas/

RUN cd /usr/cslang/cslang/python-lib && pip install -r requirements.txt -t . 

ADD ./start-cslang.sh /usr/local/sbin/start-cslang.sh

RUN chmod +x /usr/local/sbin/start-cslang.sh

RUN echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config \
  && sed -i 's/without-password/yes/g' /etc/ssh/sshd_config \
  && echo "root:cslang" | chpasswd \
  && service ssh restart

RUN ln -s /usr/cslang/cslang/bin/cslang /usr/sbin/cslang
  
EXPOSE 22

CMD [ "/usr/local/sbin/start-cslang.sh", "-s default"]
