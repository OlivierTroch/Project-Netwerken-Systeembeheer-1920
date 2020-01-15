Ansible role: pxe-server-kickstart
=========

Installs and configures PXE/TFTP server.

Requirements
------------

None.

Role Variables
--------------

|Key|Type|Description|Default|
|:--|:---|:----------|:------|
|pxe_server_kickstart_listen|String||127.0.0.1:8188|
|pxe_server_kickstart_iso_file_path|String||/var/lib/tftpboot/centos7.iso|
|pxe_server_kickstart_iso_download_path|String||[CentOS-7-x86_64-Minimal-1511.iso](http://ftp.riken.jp/Linux/centos/7/isos/x86_64/CentOS-7-x86_64-Minimal-1511.iso)|
|pxe_server_kickstart_iso_mount_path|String||/var/www/html/centos7|
|pxe_server_kickstart_file_path|String||/var/www/html/kickstart|
|pxe_server_kickstart_default_timeout|Integer||300|
|pxe_server_kickstart_default_title|String||########## CentOS 7 PXE Boot Menu ##########|
|pxe_server_kickstart_default_menu|Hash|Key: display label name. Value: kickstart file name.|{}|

Dependencies
------------

- [dhcpd](https://github.com/shomatan/ansible-role-dhcpd.git)
- [nginx](https://github.com/shomatan/ansible-role-nginx.git)
- [tftp](https://github.com/shomatan/ansible-role-tftp.git)
- [xinetd](https://github.com/shomatan/ansible-role-xinetd.git)

Example Playbook
----------------

```yaml
- hosts: all
  roles:
    - { role: pxe-server-kickstart-kickstart }
  vars:
    pxe_server_kickstart_listen: "192.168.33.2:8188"
    pxe_server_kickstart_default_menu:
      "Install CentOS7": "centos7.ks"
    dhcpd_bind_interface: enp0s8
    dhcpd_subnets:
      - subnet: 192.168.33.0
        routers: 192.168.33.5
        netmask: 255.255.255.0
        next_server: 192.168.33.2
        range: "192.168.33.240 192.168.33.250"
        options:
          filename: centos/pxelinux.0
```

License
-------

BSD

Author Information
------------------

Shoma Nishitateno (shoma416@gmail.com)
