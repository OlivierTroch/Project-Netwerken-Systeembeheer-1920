Ansible role: nginx
=========

[![Build Status](https://travis-ci.org/shomatan/ansible-nginx.svg?branch=master)](https://travis-ci.org/shomatan/ansible-nginx)

Installs and configures [Nginx](http://nginx.org/) Open Source HTTP and reverse proxy server.

Requirements
------------

None.

Role Variables
--------------

Available variables are listed below, along with default values (see defaults/main.yml):

Dependencies
------------

None.

Example Playbook
----------------

    - hosts: servers
      roles:
         - { role: shomatan.nginx }
