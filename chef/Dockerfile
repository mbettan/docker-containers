FROM base/chef-server

MAINTAINER POC Factory

RUN apt-get update -y && apt-get install -y vim emacs openssh-server git curl

RUN git clone https://github.com/mbettan/docker-containers.git /var/chef/cookbooks
RUN cd /var/chef/cookbooks && git stash && git filter-branch --prune-empty --subdirectory-filter chef/cookbooks HEAD

RUN curl -L https://www.opscode.com/chef/install.sh | sudo bash
ADD ./knife.rb /.chef/knife.rb
ADD ./start-chef.sh /usr/local/sbin/start-chef.sh
ADD ./run_chef_server /usr/local/bin/

RUN chmod +x /usr/local/bin/run_chef_server
RUN chmod +x /usr/local/sbin/start-chef.sh

RUN echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config \
  && sed -i 's/without-password/yes/g' /etc/ssh/sshd_config \
  && echo "root:HP1nvent" | chpasswd \
  && service ssh restart
  
EXPOSE 22 443

CMD [ "/usr/local/sbin/start-chef.sh", "-s default"]
