# Testplan Bravo1

Author: [Jolien Vervinckt](https://github.com/JolienVervinckt) & [Robin Ophalvens](https://github.com/RobinOphalvens)


## DNS BIND


This role installs the BIND implementation of DNS on a specified server. In this tutorial, we will walk through the steps to install the Authoritive DNS server on our Bravo1 server.

The role, written by [Bert van Vreckem](https://github.com/bertvv/ansible-role-bind), has the ability to enable the epel repo, install bind along with its utils, edit the main configuration file, create forward and reverse zones and its zone files.

The configuration is done by setting variables to our specific needs.

## Requirements


This role requires you to have Ansible installed, preferably the latest version. You do not need to use a specific OS in order to use this role but you will need a terminal that is able to run Ansible.


## Role Variables


For our use case, we will use the following variables that are passed to the role. A description is also provided.

```yaml

bind_zone_dir:                      #Sets the path to the server directory
bind_zone_file_mode:                #The permissions for the main config file
bind_allow_query:                   #Specifies which network is allowed to query the DNS server
bind_listen_ipv4:                   #Sets on which interface the DNS server will listen
bind_listen_ipv6:                   #Sets on which interface the DNS will listen for IPV6 networks
bind_recursion:                     #Boolean. Sets if recursion is allowed. Strongly recommended to turn this off if you are running an authoritive server
bind_query_log:                     #Specifies where the logs should be saved
bind_check_names:                   #Check host names for compliance with RFC 952 and RFC 1123 and take the defined action (e.g. warn, ignore, fail).
bind_zone_master_server_ip:         #REQUIRED. This variable decides if the role will install the master or server role on the specified server.
bind_zone_minimum_ttl:              #Minimum time to live field in SOA record
bind_zone_time_to_refresh:          #Time to expire field in SOA record
bind_zone_time_to_retry:            #Time to expire field in SOA record
bind_zone_time_to_expire:           #Time to refresh field in SOA record
bind_zone_domains:                  #Name of domains that will be used. Example: green.local
name:                               #Name of the host that should be resolved. Example: bravo1
ip:                                 #IP of the host that should be resolved. Example: 172.16.1.66
aliases:                            #Additional name for the host. Example: ns1
network:                            #Network of the domain
role:                               #Name of the Ansible role that will be used

```

To see the full list of supported variables, head to [Bert Van Vreckem's repository](https://github.com/bertvv/ansible-role-bind)

## Steps to configure bravo1 with bind-role role

1. (Recommended method): clone the [ansible-role-bind](https://github.com/bertvv/ansible-role-bind) repository in the ansible/roles directory. The directory should be called: dnsBindBravoCharlie

2. Delete following files:
* .git 
* .gitignore
* CHANGELOG.md
* README.md
* LICENSE.md

3. Open with your preffered text editor ansible/host_vars/bravo1.yml. Create the file if it is not present yet.

4. Copy the following [configuration](./bravo1.yml) and paste it in bravo1.yml. Be careful with spacing and syntax. Ansible is very strict with the way it reads files.

5. Next, verify if bravo1 has an entry in ansible/servers.yml. If not, add the following lines:

```yaml

- name: Configure bravo1
  hosts: bravo1
  remote_user: root
  gather_facts: yes
  roles:
    - dnsBindBravoCharlie

```

6. If you're using Vagrant to launch the DNS server,  make sure bravo1 has an entry in vagrant-hosts.yml. If not, add the following two lines:

```yaml

  #Bravo1 DNS Server
- name: bravo1
  mac: '08:00:27:66:5D:02'
  ip: 172.16.1.66

```

IMPORTANT! In our case, Bravo1 will be the authoritive master server. In order for Ansible to correctly recognise its function, make sure that the ip address above and the variable "bind_zone_master_server_ip:" are matching. Otherwise, this server will be given the slave role.

7. Launch the server. If you are using vagrant, the ansible provisioning should automatically start. 

8. The Ansible configuration should succeed. If not, check if you made a syntax mistake or forgot  to fill in a necessary variable. Open a github issue if you are unable to resolve the error.

9. On every host that will be using the DNS server, open with your text editor /etc/resolv.conf. If you are using vagrant, it will use the DNS servers which are linked with your NAT interface. Change the ip address next to nameserver to the IP of your DNS server. In our case, this will be 172.16.1.66.
Add a second line with "nameserver 172.16.1.67". This will be our backup DNS server.

10. If the configuration succeeded, you can verify that the DNS server is working by pinging "bravo1.green.local". Keep in mind that the server will only respond to requests from the 172.16 network. If you are pinging from your physical computer, which usually has an ip in the 192.168 network, the ping will fail.

11. You can also check if the configuration files are edited accordingly by logging in into the server through ssh and using the cat command in the terminal. Each config file should look like this:

* [/etc/named.conf](./Configuratiefiles/named.conf)
* [/etc/hostname](./Configuratiefiles/hostname)
* [/etc/hosts](./Configuratiefiles/hosts)
* [/etc/resolv.conf](./Configuratiefiles/resolv.conf)
* [/var/local/named-zones/green.local](./Configuratiefiles/green.local)


## License

BSD

