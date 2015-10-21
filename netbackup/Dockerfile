docker run -ti -P centos:6.6 /bin/bash

yum install -y wget
cd /tmp
wget ftp://172.16.1.243/OpsCenter_7.6.1_Unix.gz
tar xzvf OpsCenter_7.6.1_Unix.gz
rm -rf OpsCenter_7.6.1_Unix.gz
cd OpsCenter_7.6.1_Unix
yum install -y libSM.i686
./install
rm -rf OpsCenter_7.6.1_Unix

wget ftp://172.16.1.243/NetBackup_7.6.1_LinuxR_x86_64.gz
yum install -y tar
tar xzvf NetBackup_7.6.1_LinuxR_x86_64.gz
rm -rf NetBackup_7.6.1_LinuxR_x86_64.gz
cd NetBackup_7.6.1_LinuxR_x86_64
./install
KLN3-OPX6-UUOJ-W4GY-CR3P-3PV8-OG9Z-9E7H-HEHP-PPPO
rm -rf NetBackup_7.6.1_LinuxR_x86_64

cd
mkdir -p /backups
/usr/openv/netbackup/bin/bpadm
mkdir -p .ssh
echo "StrictHostKeyChecking no" >> ~/.ssh/config

