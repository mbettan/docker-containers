#! /bin/bash

/etc/init.d/sshd start > /dev/null 2>&1
foreman-installer --foreman-admin-password="changeme" && tail -f /var/log/foreman/production.log
