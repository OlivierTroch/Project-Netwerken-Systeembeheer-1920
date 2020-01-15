<https://www.golinuxcloud.com/ldap-tutorial-for-beginners-configure-linux/>

<https://www.tecmint.com/install-openldap-server-for-centralized-authentication/>

https://www.openldap.org/

firewall settings aanpassen => 

rhbase_firewall_allow_ports:

  - 80/tcp
  - 389/tcp
  - 9830/tcp
  - 636/tcp
  - 3269/tcp

rhbase_firewall_interfaces:
  - enp0s3
  - enp0s8



<https://galaxy.ansible.com/net2grid/389-ds>

zelf een ansible rol schrijven?

<https://www.azavea.com/blog/2014/10/09/creating-ansible-roles-from-scratch-part-1/>

<https://www.youtube.com/watch?v=KgoDnSGvJJg>

installeren ansible op windows 10 zodat ik zelf een rol kan schrijven

<https://www.youtube.com/watch?v=4sMFybv74Uo>

rol aanmaken

<https://galaxy.ansible.com/docs/contributing/creating_role.html>

<https://galaxy.ansible.com/docs/contributing/importing.html><https://www.digitalocean.com/community/tutorials/how-to-install-git-on-ubuntu-18-04>

=> rol niet zelf aanmaken, te veel tijdverlies

=> rol die wij nu gebruiken aanpassen! download 389ds role in zip en pas aan

<https://github.com/net2grid/ansible-role-389-ds>

<https://github.com/net2grid/ansible-openldap_config>

<https://github.com/net2grid/openldap_server>

<https://www.openldap.org/doc/admin24/install.html>

<https://www.python-ldap.org/en/latest/installing.html>

<http://www.port389.org/docs/389ds/design/task-invocation-via-ldap.html>

