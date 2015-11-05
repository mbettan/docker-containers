FROM centos:6.6
MAINTAINER Michael Bettan mbe@hpe.com

RUN yum update -y
RUN yum install -y ntp openssh-server openssh-clients openssl-devel rsync nano git
RUN echo "admin@123" | passwd root --stdin
RUN echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
RUN service sshd restart

RUN rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
RUN yum update -y && yum install -y ansible
RUN ssh-keygen -t rsa -C "POC Factory" -N "" -f /root/.ssh/id_rsa

RUN git clone https://github.com/mbettan/docker-containers.git /etc/ansible/playbooks
RUN cd /etc/ansible/playbooks && git stash && git filter-branch --prune-empty --subdirectory-filter ansible/playbooks HEAD
RUN rm -Rf /etc/ansible/hosts

RUN yum install -y python-pip gcc gcc-c++ python-devel krb5-workstation.x86_64
RUN pip install --upgrade pip
RUN pip install https://github.com/diyan/pywinrm/archive/master.zip#egg=pywinrm
RUN pip install --upgrade kerberos

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]