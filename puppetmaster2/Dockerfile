FROM foreman/foreman:nightly
MAINTAINER Michael Bettan mbe@hpe.com

RUN yum install -y openssh-server openssh-clients 
RUN echo "admin@123" | passwd root --stdin

ADD ./deployagent.sh /home/puppet-dashboard/puppetagent/deployagent.sh
ADD ./manifests/nodes.pp  /etc/puppet/manifests/nodes.pp
ADD ./manifests/site.pp    /etc/puppet/manifests/site.pp
ADD ./modules  /etc/puppet//modules
RUN rm -Rf /etc/puppet/environments/common /etc/puppet/environments/development /etc/puppet/environments/example_env
ADD ./start-app.sh /usr/local/sbin/start-app.sh

EXPOSE 22 443 8140

RUN chmod +x /usr/local/sbin/start-app.sh
CMD [ "/usr/local/sbin/start-app.sh", "-s default"]
