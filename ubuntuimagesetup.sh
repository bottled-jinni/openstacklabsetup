#!/bin/bash
#Openstack Ubuntu Server 14.04 LTS (Trusty Tahr)  template configuratio.
#=================Initial login=================
#ip netns exec qroute-xxxxxxxxxx ssh -i /root/KEY.pem ubuntu@INSTANCE_IP
# To get the value of qroute-xxxxxxxxxx, RUN 'ip netns list'
# To get the instance id, run 'openstack server list'. Make sure sourcing the correct file


#=================set up future logins=================
#Set up password login. 

#sudo vim /etc/ssh/sshd_config
#change 'PasswordAuthentication yes', default = no
#if automatin it
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo /etc/init.d/ssh restart

#Add new user, and change/set passwords for existing users. 
sudo useradd -m adminuser
#sudo passwd ubuntu #password=....
#sudo passwd adminuser #password=....
#sudo passwd root #password=....
#if Automating. 
sudo passwd adminuser #
sudo passwd ubuntu #
sudo passwd root #

#Make users sudoers
sudo su #now user = ubuntu
echo ' adminuser ALL=(ALL)   ALL' >> /etc/sudoers
echo ' ubuntu ALL=(ALL)   ALL' >> /etc/sudoers

#=================Install utilities. 
apt-get update -y
apt-get install weechat -y 
apt-get install vim tree -y
apt-get install docker.io -y
#Or else be root
sudo usermod -a -G docker adminuser
su - adminuser
