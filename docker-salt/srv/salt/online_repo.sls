Solve broken yum update:
 cmd.run:
  - name: yum erase -y gpid-cpp-client
  - cwd: /
  - stateful: False

Clear repos:
 file.absent:
  - name: /etc/yum.repos.d

Disable RHEL repos:
 cmd.run:
  - name: yum-config-manager --disable redhat.repo rhel-source.repo centos.repo
  - cwd: /
  - stateful: False

/etc/yum.repos.d:
 file.recurse:
  - source: salt://repo-online
  - target: /etc/yum.repos.d
  - makedirs: True

Clean yum database:
 cmd.run:
  - name: yum clean all
  - cwd: /
  - stateful: False

Enable new repos:
 cmd.run:
  - name: yum-config-manager --enable local.repo
  - cwd: /
  - stateful: False

Enable epel repos:
 cmd.run:
  - name: yum-config-manager --enable epel.repo
  - cwd: /
  - stateful: False

