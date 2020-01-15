#!/bin/bash
echo "-----------------------------"
#Installing kvm and starting kvm
echo "-----------------------------"
echo "Installing and starting kvm.."
yum install qemu-kvm libvirt libvirt-python libguestfs-tools virt-install -y
service enable libvirtd
service start libvirtd
echo "-----------------------------"
#Installing vagrant
echo "Installing and configure vagrant.."
yum -y install https://releases.hashicorp.com/vagrant/2.2.6/vagrant_2.2.6_x86_64.rpm
sudo yum install -y gcc libvirt-devel
vagrant plugin install vagrant-libvirt
vagrant plugin install vagrant-mutate
vagrant plugin install vagrant-rekey-ssh
echo "-----------------------------"
echo "install ansible"
yum -y install epel-release
yum -y install ansible
#Installing git
cd /home/student/
echo "Installing git on system.."
yum install git -y
echo "-----------------------------"
#Installing and enable ssh
yum install -y openssh-server
service sshd start
echo "-----------------------------"
#Cloning the project repo
cd /home/admin/
git clone https://github.com/HoGentTIN/p3ops-1920-green.git
echo "-----------------------------"
# Updating Centos machine.
echo "Updating system.."
yum -y update
echo "-----------------------------"
#Showing ip
echo "-----------------------------"
/sbin/ifconfig enp2s0f0| grep 'inet'
/sbin/ifconfig enp2s0f1| grep 'inet'
/sbin/ifconfig lo| grep 'inet'
/sbin/ifconfig virbr0-nic| grep 'inet'
/sbin/ifconfig docker0| grep 'inet'
echo "-----------------------------"

