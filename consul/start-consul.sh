#!/bin/bash

/etc/init.d/ssh start > /dev/null 2>&1


{
/usr/bin/expect <<EOF
spawn ssh-keygen
expect -exact "Enter file in which to save the key (/root/.ssh/id_rsa): "
send -- "\r"
expect -exact "Enter passphrase (empty for no passphrase): "
send -- "\r"
expect -exact "Enter same passphrase again: "
send -- "\r"
expect "*#*"
EOF
}

{
/usr/bin/expect <<EOF
spawn ssh-copy-id -p <ssh_Port> root@<CloudSlangServer_IP>
expect "*yes*"
send "yes\r"
expect "*password*"
send "cslang\r"
expect "*#*"
EOF
}


consul agent -server -bootstrap -dc=poc-facto -client=0.0.0.0 -bind=0.0.0.0 -data-dir=/consul.d -ui-dir=/ui -config-dir=/consul.d/conf.d
