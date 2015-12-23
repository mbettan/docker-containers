FROM cloudslang/cloudslang

RUN apt-get -y update
RUN apt-get -y install vim emacs openssh-server git tree

WORKDIR /
RUN git clone https://github.com/FlorianJDF/cslang-heroku.git
RUN cp -r /cslang-heroku/content/io/cloudslang/paas/* /usr/cslang/cslang/content/io/cloudslang/paas/
WORKDIR /usr/cslang/cslang/bin

ENTRYPOINT ["/bin/bash"]
