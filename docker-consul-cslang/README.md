## Synopsis

This project creates a docker image for consul that triggers flows on a remote CloudSlang server, the image is based on ubuntu:14.04 

## Prerequisites

You need to have CloudSlang Server with ssh access, the CloudSlang image tested with this project is available on Docker Hub under the name cloudslang/cloudslang-dev.

## Installation

Before building the image you need to make some changes on the health check and startup scripts according to your enviroment.

#### start-consul.sh

This script starts the ssh and consul server, also copy the rsa key to the cloudslang server so no password is prompted 

replace <ssh_Port> and <CloudSlangServer_IP> according to your cloudslang container configuration

```
...
/usr/bin/expect <<EOF
spawn ssh-copy-id -p <ssh_Port> root@<CloudSlangServer_IP>
expect "*yes*"
send "yes\r"
expect "*password*"
send "cslang\r"
expect "*#*"
EOF
} 
...
```

#### disk_usage.sh
The script calls a cloudslang flow to check the disk usage on a host

Replace <Docker_Host>,<docker_user> and <docker_password> with the targeted docker host for image cleanup 

```
ssh -p <ssh_Port> root@<CloudSlangServer_IP> 'cslang run --f /usr/cslang/cslang/content/io/cloudslang/base/os/linux/diskspace_health_check.sl --i docker_host=<Docker_Host>,docker_username=<docker_user>,docker_password=<docker_password>,percentage=<DF_Threshold>,timeout=3000 --cp /usr/cslang/cslang/content/io/cloudslang/' 2>&1 >/consul.d/conf.d/tmp.txt
```

#### clearDiskSpace.sh
replace <ssh_Port> and <CloudSlangServer_IP> according to your cloudslang container configuration

```
...
ssh -p <ssh_Port> root@<CloudSlangServer_IP> 'cslang run --f /usr/cslang/cslang/content/io/cloudslang/docker/images/clear_unused_images.sl --i docker_host=<Docker_Host>,docker_username=<Docker_user>,docker_password=<Docker_Password>,timeout=3000 --cp /usr/cslang/cslang/content/io/cloudslang/'
...
```

## Start the Container

docker run -it -p 50022:22 -p 58500:8500 -p 50053:53 -p 58400:8400 -h consul.local --name ConsulServer <Image_ID>

