#!/bin/bash

echo "Memulai provisioning"

echo "Setup Software Sources"
cp /vagrant/provisioning/config/sources.list /etc/apt/sources.list
cp /vagrant/provisioning/config/environment /etc/environment

apt-get update
apt-get upgrade -y
apt-get dist-upgrade -y

echo "Instalasi Git"
apt-get install -y git

echo "Instalasi Maven"
apt-get install -y maven

echo "Instalasi gradle"
apt-get install -y gradle

echo "Instalasi nodejs"
apt-get install -y nodejs

echo "Instalasi gradle"
apt-get install -y npm
sudo npm install -g update

echo "Install Java"
wget --no-check-certificate https://github.com/aglover/ubuntu-equip/raw/master/equip_java8.sh && bash equip_java8.sh

echo "Setup MySQL"
apt-get install -y debconf-utils

debconf-set-selections <<< "mysql-server mysql-server/root_password password admin"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password admin"

apt-get install -y mysql-server

echo "CI Test Repo"
cd /home/vagrant/web
git clone https://github.com/anteknik/10132016MMI.git

echo "clone spring.io"
cd /home/vagrant/web
git clone https://github.com/spring-io/sagan.git
mv /home/vagrant/web/sagan /home/vagrant/web/springio
cd springio 
./gradlew build
cd /home/vagrant/web/springio/sagan-site
../gradlew build -x check

echo "Selesai provisioning"
