#!/bin/sh

ssh -p <ssh_Port> root@<CloudSlangServer_IP> 'cslang run --f /usr/cslang/cslang/content/io/cloudslang/docker/images/clear_unused_images.sl --i docker_host=<Docker_Host>,docker_username=<Docker_user>,docker_password=<Docker_Password>,timeout=3000 --cp /usr/cslang/cslang/content/io/cloudslang/'

