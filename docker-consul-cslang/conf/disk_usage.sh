#!/bin/sh

ssh -p <ssh_Port> root@<CloudSlangServer_IP> 'cslang run --f /usr/cslang/cslang/content/io/cloudslang/base/os/linux/diskspace_health_check.sl --i docker_host=<Docker_Host>,docker_username=<docker_user>,docker_password=<docker_password>,percentage=<DF_Threshold>,timeout=3000 --cp /usr/cslang/cslang/content/io/cloudslang/' 2>&1 >/consul.d/conf.d/tmp.txt

res=$(grep 'result' /consul.d/conf.d/tmp.txt | cut -d : -f 3)

res="$(echo "${res}" | tr -d '[[:space:]]')"

if [ "$res" != "SUCCESS" ]; then
	exit 1
fi
exit 0
