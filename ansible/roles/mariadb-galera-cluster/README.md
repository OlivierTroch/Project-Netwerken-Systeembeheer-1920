# Ansible Role: mariadb-galera-cluster
=========

A simple Ansible role for installing and configuring the MariaDB Galera cluster 10.3 for RHEL/CentOS 7.

- Install the necessary packages;
- Create configuration file;


Requirements
------------

- The SELINUX and firewall settings are not considered to be a concern of this role.

Role Variables
--------------


None of the variables below are required

| Variable                                     | Default                       | Comments                                                                                |
| :---                                         | :---                          | :---                                                                                    |
| `galera_cluster_group`                       |                               | group in invetory                                                                       |
| `galera_cluster_name`                        |                               | cluster name                                                                            |
| `root_login`                                 |                               | user root                                                                               |
| `root_password`                              |                               | root password                                                                           |
|



Dependencies
------------

No dependencies.

## In the file start_cluster.yml it is necessary to inform the IP of the first node that will be the master

Examplo:

- name: start first node
  command: galera_new_cluster
  when: ansible_default_ipv4.address == '192.168.0.23'

Example Inventory File
----------------------
[galera_cluster_nodes]
192.168.0.23
192.168.0.24
192.168.0.28


Example Playbook
----------------

---
- hosts: galera_cluster_nodes

  become: yes
  
  roles:
  
    - /path/mariadb-galera-cluster
...

## Contributing

Issues, feature requests, ideas are appreciated and can be posted in the Issues section.


Author Information
------------------
LinkedIn: https://br.linkedin.com/in/almircandido
