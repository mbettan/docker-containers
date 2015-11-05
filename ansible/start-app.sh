#! /bin/bash
/etc/init.d/sshd start
sleep 5
exec tail -f /var/log/yum.log