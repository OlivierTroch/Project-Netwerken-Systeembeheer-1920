# Testplan Lima1

Author: [Jonas Spitaels](https://github.com/JonasSpitaels) & [Berkant Kücüksolak](https://github.com/BerkantKs)


## Rh-base and Samba

The roles we will be using to set up the internal fileserver are Rh-base and Samba. 

Rh-base can be used for multiple things, but we are only using it to:
- Create users and groups
- Manage firewall rules 

And we are using Samba to:
- Create share directories
- Manage Samba users and passwords
- Manage access to shares

In this test plan, we will desbribe the steps to install the internal fileserver with Rh-base and Samba.

The roles are both written by [Bert van Vreckem](https://github.com/bertvv/ansible-role-samba).

The configuration is done by setting variables to our specific needs.

## Requirements


This role requires you to have Ansible installed, preferably the latest version. You do not need to use a specific OS in order to use this role but you will need a terminal that is able to run Ansible.


## Role Variables


For our use case, we will use the following variables that are passed to each role. A description is also provided.

- Rh-base

```yaml

rhbase_firewall_allow_services:                      #Used to allow certain services through the firewall, in our case: Samba.
rhbase_user_groups:                #Used to create the groups on system, as specified by Alfa1.
rhbase_users:                   #Used to create users on system. This role has a lot of keys. They will be described now.
name:                   #Used to describe a name for the user.
comment:                   #Used to write a comment connected to the user. Definetly not necessary.
password:                   #Used to create a password for the user.
groups:                   #Used to add the specific rh-base user to the defined groups.


```

- Samba

```yaml

samba_load_homes:                      #Used to create a home directory for users created by Samba.
samba_users:                #Used to create Samba users. We use the 'name' and 'password' key to define both of these.
samba_shares:                   #used to create shares. We will describe a dict with the keys now.
name:                   #Used to describe a name fore the Samba share.
group:                   #Used to decribe the name of the system group defined by rh-base (see before) to which system user may be added. This system group is used to create the Samba share on.
valid_users:                   #Used to give read access to users / groups
write_list:                   #Used to write access to users / groups.

```


To see the full list of supported variables for rh-base, head to [Bert Van Vreckem's repository](https://github.com/bertvv/ansible-role-rh-base), and to see the full list of supported variables for samba, head to [Bert Van Vreckem's repository](https://github.com/bertvv/ansible-role-samba)

## Steps to configure lima1 with rh-base and samba role

1. (Recommended method): clone both the [ansible-role-rh-base](https://github.com/bertvv/ansible-role-rh-base) repository and the [ansible-role-samba](https://github.com/bertvv/ansible-role-samba) in the ansible/roles directory. The directory should be respectively called: bertvv.rh-base & bertvv.samba

2. Open with your preffered text editor ansible/host_vars/lima1.yml. Create the file if it is not present yet.

4. Copy the following [configuration](./lima1.yml) and paste it in lima1.yml. Be careful with spacing and syntax. Ansible is very strict with the way it reads files.

5. Next, verify if lima1 has an entry in ansible/servers.yml. If not, add the following lines:

```yaml

- hosts: lima1
  become: true
  roles:
    - bertvv.rh-base
    - bertvv.samba

```

6. If you're using Vagrant to launch the DNS server,  make sure bravo1 has an entry in vagrant-hosts.yml. If not, add the following two lines:

```yaml

  #Lima1 fileserver
- name: lima1
  ip: 172.16.1.2
  box: bento/centos-7.6

```

7. Launch the server. If you are using vagrant, the ansible provisioning should automatically start. 

8. The Ansible configuration should succeed. If not, check if you made a syntax mistake or forgot  to fill in a necessary variable. Open a github issue if you are unable to resolve the error.

9. check -> zie 'testplan lima1 BEKNOPT'


## License

BSD
