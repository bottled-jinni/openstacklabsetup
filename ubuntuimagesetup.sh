#!/bin/bash
#Openstack Ubuntu Server 14.04 LTS (Trusty Tahr)  template configuratio.
#=================Initial login=================
#ip netns exec qroute-xxxxxxxxxx ssh -i /root/KEY.pem ubuntu@INSTANCE_IP
# To get the value of qroute-xxxxxxxxxx, RUN 'ip netns list'
# To get the instance id, run 'openstack server list'. Make sure sourcing the correct file

#Assumes 'sudo su'
#=================set up future logins=================

#Set up password login. 
#sudo vim /etc/ssh/sshd_config
#change 'PasswordAuthentication yes', default = no
#if automatin it
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
/etc/init.d/ssh restart

#Add new user, and change/set passwords for existing users. 
useradd -m adminuser
echo -e "password\npassword" | passwd adminuser
echo -e "password\npassword" | passwd ubuntu

#Make users sudoers
echo ' adminuser ALL=(ALL)   ALL' >> /etc/sudoers
echo ' ubuntu ALL=(ALL)   ALL' >> /etc/sudoers

#=================Install utilities. 
apt-get update -y
apt-get install -y weechat vim tree
apt-get install docker.io -y
#Or else be root
usermod -a -G docker adminuser
