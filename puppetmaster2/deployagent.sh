#!/bin/bash
#set -x
LOG_FILE=/tmp/puppetagent.log

if [ -f /etc/lsb-release ] || [ -f /etc/debian_version ]; then
    . /etc/lsb-release
    DISTRO=$DISTRIB_ID
echo "Ajout du puppet master dans /etc/hosts"
sudo -i bash -c "echo '172.16.1.18  puppetm.lab.local puppetm' >> /etc/hosts 2>&1" | tee -a $LOG_FILE

echo "Installation de puppet agent" 2>&1 | tee -a $LOG_FILE
sudo -i wget http://puppetm.lab.local/files/puppetlabs-release-trusty.deb 2>&1 | tee -a $LOG_FILE
sudo -i dpkg -i puppetlabs-release-trusty.deb 2>&1 | tee -a $LOG_FILE
sudo -i apt-get update 2>&1 | tee -a $LOG_FILE
sudo -i apt-get install -y puppet 2>&1 | tee -a $LOG_FILE
echo "Modification du fichier /etc/default/puppet" 2>&1 | tee -a $LOG_FILE

sudo -i sed -i 's/START=no/START=yes/' /etc/default/puppet 2>&1 | tee -a $LOG_FILE

echo "Verouillage MAJ version Puppet" 2>&1 | tee -a $LOG_FILE

sudo -i touch /etc/apt/preferences.d/00-puppet.pref 2>&1 | tee -a $LOG_FILE
sudo bash -c "echo '#/etc/apt/preferences.d/00-puppet.pref' > /etc/apt/preferences.d/00-puppet.pref" 2>&1 | tee -a $LOG_FILE
sudo bash -c "echo 'Package: puppet puppet-common' >> /etc/apt/preferences.d/00-puppet.pref" 2>&1 | tee -a $LOG_FILE
sudo bash -c "echo 'Pin: version 3.7*' >> /etc/apt/preferences.d/00-puppet.pref" 2>&1 | tee -a $LOG_FILE
sudo bash -c "echo 'Pin-Priority: 501' >> /etc/apt/preferences.d/00-puppet.pref" 2>&1 | tee -a $LOG_FILE

echo "Modification du fichier puppet.conf" 2>&1 | tee -a $LOG_FILE
sudo cp /etc/puppet/puppet.conf /root/ 2>&1 | tee -a $LOG_FILE
sudo -i sed -i '/templatedir/d' /etc/puppet/puppet.conf
sudo -i sed -i '/master/d' /etc/puppet/puppet.conf
sudo -i sed -i '/#/d' /etc/puppet/puppet.conf
sudo -i sed -i '10i runinterval = 300' /etc/puppet/puppet.conf 2>&1 | tee -a $LOG_FILE
sudo bash -c "echo '[agent]' >> /etc/puppet/puppet.conf 2>&1" | tee -a $LOG_FILE
sudo bash -c "echo 'server = puppetm.lab.local' >> /etc/puppet/puppet.conf 2>&1" | tee -a $LOG_FILE

echo "Demarrage du service puppet" 2>&1 | tee -a $LOG_FILE
sudo service puppet start 2>&1 | tee -a $LOG_FILE

elif [ -f /etc/redhat-release ]; then
    DISTRO="Red Hat"

echo "Ajout du puppet master dans /etc/hosts"
bash -c "echo '172.16.1.18 puppetm' >> /etc/hosts 2>&1" | tee -a $LOG_FILE

echo "Ajout du depot local dans /etc/hosts"
bash -c "echo '172.16.1.30 rhel6repo' >> /etc/hosts 2>&1" | tee -a $LOG_FILE

echo "Configuration du service ntp"
mv /etc/ntp.conf /root/ 2>&1 | tee -a $LOG_FILE
touch /etc/ntp.conf 2>&1 | tee -a $LOG_FILE
bash -c "echo 'tinker panic 0' >> /etc/ntp.conf 2>&1" | tee -a $LOG_FILE
bash -c "echo 'restrict 127.0.0.1' >> /etc/ntp.conf 2>&1" | tee -a $LOG_FILE
bash -c "echo 'restrict default kod nomodify notrap' >> /etc/ntp.conf 2>&1" | tee -a $LOG_FILE
bash -c "echo 'server 0.puppetm' >> /etc/ntp.conf 2>&1" | tee -a $LOG_FILE
bash -c "echo 'driftfile /var/lib/ntp/drift' >> /etc/ntp.conf 2>&1" | tee -a $LOG_FILE
bash -c "echo '0.puppetm' >> /etc/ntp/step-tickers  2>&1" | tee -a $LOG_FILE
service ntpd start
chkconfig ntpd on

echo "Configuration du repo yum local" 2>&1 | tee -a $LOG_FILE
mv /etc/yum.repos.d/*.repo /root/
cd /root/
yum-config-manager --disable redhat.repo rhel-source.repo centos.repo

touch /etc/yum.repos.d/local.repo

cat > /etc/yum.repos.d/local.repo << EOF
[localrepo]
name=Local Rhel6 Repo
baseurl=http://rhel6repo/CentOS/6/6
enabled=1
gpgcheck=0
EOF

yum-config-manager --enable local.repo

echo "Installation de puppet agent" 2>&1 | tee -a $LOG_FILE
#sudo rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm
wget http://puppetm/files/puppetrpms.tar.gz
tar -xzvf puppetrpms.tar.gz
cd puppetrpms
rpm -ivh --nodeps *.rpm
#yum install -y puppet

echo "Enregistrement du service puppet dans le systeme" 2>&1 | tee -a $LOG_FILE
chkconfig puppet on

echo "Modification du fichier puppet.conf" 2>&1 | tee -a $LOG_FILE
cp /etc/puppet/puppet.conf /root/ 2>&1 | tee -a $LOG_FILE
bash -c "echo 'server = puppetm' >> /etc/puppet/puppet.conf 2>&1" | tee -a $LOG_FILE
#sed -i '13i runinterval = 60' /etc/puppet/puppet.conf 2>&1 | tee -a $LOG_FILE

echo "Demarrage du service puppet" 2>&1 | tee -a $LOG_FILE
service puppet start 2>&1 | tee -a $LOG_FILE

#echo "Suppression des ssl sur le puppet agent" 2>&1 | tee -a $LOG_FILE
#cd /var/lib/puppet/ssl/
#rm -rf *.*
#puppet ca list
else
 DISTRO=$(uname -s)
fi
#echo "$DISTRO"

