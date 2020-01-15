# Tesplan Charlie1

Author: [Jolien Vervinckt](https://github.com/JolienVervinckt) & [Robin Ophalvens](https://github.com/RobinOphalvens)


## DNS BIND

This role installs the BIND implementation of DNS on a specified server. In this tutorial, we will walk through the steps to install the secondary/slave DNS server on our Charlie1 server.

The role, written by [Bert van Vreckem](https://github.com/bertvv/ansible-role-bind), has the ability to enable the epel repo, install bind along with its utils, edit the main configuration file, create forward and reverse zones and its zone files. In this however, the role will synchronise this server to primary server and will not create zones files.

The configuration is done by setting variables to our specific needs.

## Requirements


This role requires you to have Ansible installed, preferably the latest version. You do not need to use a specific OS in order to use this role but you will need a terminal that is able to run Ansible.

## Role Variables

Contrary to Bravo1, Charlie1 is takes far less variables to configure it to our needs. Our job is to make sure our secondary dns server (also known as the slave) listens on the correct IPv4 interface, set to which network it should respond, who the primary DNS server is and which domain we will be using.

```yaml

    bind_listen_ipv4:               #Specifies on which ipv4 interface the DNS server should listen to               
    bind_allow_query:               #Specifies to which network the server should respond to
    bind_zone_master_server_ip:     #Sets who will act as the master server
    bind_zone_domains:              #Describes the domains which will be used
  

```


To see the full list of supported variables, head to [Bert Van Vreckem's repository](https://github.com/bertvv/ansible-role-bind)

## Steps to configure charlie1 with bind-role role

1. If you already have the role installed during the bravo1 configuration, you can reuse this role again. If not, clone the [ansible-role-bind](https://github.com/bertvv/ansible-role-bind) repository in ansible/roles.

2. Make sure following files are deleted since they are no longer needed.

* .git 
* .gitignore
* CHANGELOG.md
* README.md
* LICENSE.md

3. Open with your preffered text editor ansible/host_vars/charlie1.yml. Create the file if it is not present yet.

4. Copy the following [configuration](./charlie1.yml) and paste it in charlie1.yml. Be careful with spacing and syntax. Ansible is very strict with the way it reads files.

5. Next, verify if charlie1 has an entry in ansible/servers.yml. If not, add the following lines:

```yaml

- name: Configure charlie1
  hosts: charlie1
  remote_user: root
  gather_facts: yes
  roles:
    - dnsBindBravoCharlie

```

6. If you're using Vagrant to launch the DNS server,  make sure bravo1 has an entry in vagrant-hosts.yml. If not, add the following two lines:

```yaml

  #Charlie1 DNS Server
- name: Charlie1
  mac: '08:00:27:66:5D:03'
  ip: 172.16.1.67

```

7. Launch the server. If you are using vagrant, the ansible provisioning should automatically start. 

8. The Ansible configuration should succeed. If not, check if you made a syntax mistake or forgot  to fill in a necessary variable. Open a github issue if you are unable to resolve the error.

9. On every host system that will be using the DNS server, open with your text editor /etc/resolv.conf. If you are using vagrant, it will use the DNS servers which are linked with your NAT interface. Change the ip address next to nameserver to the IP of your DNS server. In our case, this will be 172.16.1.66.
Add a second line with "nameserver 172.16.1.67". This will be our backup DNS server.

10. If the configuration succeeded, you can verify that the DNS server is working by pinging "charlie1.green.local". Keep in mind that the server will only respond to requests from the 172.16 network. If you are pinging from your physical computer, which usually has an ip in the 192.168 network, the ping will fail.

11. You can also check if the configuration files are edited accordingly by logging in into the server through ssh and using the cat command in the terminal. Each config file should look like this:

* [/etc/named.conf](./Configuratiefiles/named.conf)
* [/etc/hostname](./Configuratiefiles/hostname)
* [/etc/hosts](./Configuratiefiles/hosts)
* [/etc/resolv.conf](./Configuratiefiles/resolv.conf)

## License

BSD
