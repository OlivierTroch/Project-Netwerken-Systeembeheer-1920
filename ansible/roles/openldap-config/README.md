# net2grid.openldap_config

This role wraps ```net2grid.openldap_server``` to add DIT, groups and users.

## Requirements

Ansible 2.x

## Dependencies

- net2grid.openldap_server

## Example Playbook

    default_user_password: password123
    
    openldap_create_organizationalunits:
      - Bindings
      - Customers
      - Groups
      - Hosts
      - People
      - System
    
    openldap_create_groups:
      - name: my_group
        gid: 1001
    
    openldap_create_people:
      - name: remco
        cn: Remco Brink
        sn: Brink
        password: remco
        email: remco@net2grid.com

    openldap_create_bindings:
      - name: hostro
        cn: hostbinding read-only
        sn: read-only
        password: passwordhostro
        email: hostmaster@net2grid.com
    
    # These LDIFs will be applied to all people
    openldap_user_ldifs:
      - uniquemember.ldif.j2
  
## License

MIT / BSD

## Author Information

Remco Brink
