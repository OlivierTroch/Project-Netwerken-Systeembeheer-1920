Ansible Role: TFTP Server
=========

Installs and configures Trivial File Transfer Protocol server.

Requirements
------------

None.

Role Variables
--------------

None.

Dependencies
------------

- [xinetd](https://github.com/shomatan/ansible-role-xinetd.git)

Example Playbook
----------------

```yaml
- hosts: all
  roles:
    - { role: shomatan.tftp }
```

License
-------

BSD

Author Information
------------------

Shoma Nishitateno (shoma416@gmail.com)