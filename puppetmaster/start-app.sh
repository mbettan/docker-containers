#! /bin/bash

/etc/init.d/sshd start
exec puppet master --verbose --no-daemonize & k=$! && sleep 7 && kill $k
sleep 10
exec /usr/sbin/httpd -D FOREGROUND
