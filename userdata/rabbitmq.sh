#!/bin/bash
sudo yum install epel-release -y
sudo yum update -y
sudo yum install wget -y
sudo yum install firewalld -y
cd /tmp/
dnf -y install centos-release-rabbitmq-38
 dnf --enablerepo=centos-rabbitmq-38 -y install rabbitmq-server
 systemctl enable --now rabbitmq-server
 systemctl start firewalld 
 systemctl enable firewalld
 firewall-cmd --add-port=5672/tcp
 firewall-cmd --runtime-to-permanent
 systemctl restart firewalld
sudo systemctl start rabbitmq-server
sudo systemctl enable rabbitmq-server
sudo systemctl status rabbitmq-server
sudo sh -c 'echo "loopback_users = none" | sudo tee /etc/rabbitmq/rabbitmq.conf'
sudo cat /etc/rabbitmq/rabbitmq.conf
sudo rabbitmqctl add_user test test
sudo rabbitmqctl set_user_tags test administrator
sudo rabbitmqctl set_permissions -p / test ".*" ".*" ".*"
sudo rabbitmqctl delete_user guest
sudo rabbitmqctl list_users
sudo systemctl restart rabbitmq-server
