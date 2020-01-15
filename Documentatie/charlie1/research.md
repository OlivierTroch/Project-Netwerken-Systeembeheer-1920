# List of the collected research material

## Manual installation

[BIND Installation on an Ubuntu server](https://www.digitalocean.com/community/tutorials/how-to-configure-bind-as-an-authoritative-only-dns-server-on-ubuntu-14-04)

Altough this article is targeted towards Debian based distros, specifically Ubuntu in this case, the author describes the installation and configuration proces in an easy to read fashion which helps you understand the principles of the DNS server.

[Installatie van BIND op een CentOS 7 server](http://linuxpitstop.com/dns-server-setup-using-bind-9-on-centos-7-linux/)

The second article describes the installation proces for a RHEL server. It is recommended to read the fundementals and principles of a DNS BIND server first before blindly following this tutorial. 

## Automatic installation with Ansible

In order to automatically install the desired configuration for our DNS server, we've chosen to use Ansible role provided by [Bert van Vreckem](https://github.com/bertvv/ansible-role-bind). 

This repo also contains the necessary documentation to install the specified role. For our specific use case, please head to our [testplan](./testplan.md) which describes the variables we will be using.

