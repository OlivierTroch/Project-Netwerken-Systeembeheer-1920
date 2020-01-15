# Monitoring Specifieke Servers

## Alfa1: OpenLDAP

- Gebruik [Tomcz LDAP_exporter](https://github.com/tomcz/openldap_exporter)
- Onderdeel van [Mesaguy.Prometheus](https://galaxy.ansible.com/mesaguy/prometheus) rol

## Bravo1 + Charlie1: DNS Bind

- Gebruik [DigitalOcean BIND exporter](https://github.com/digitalocean/bind_exporter)
- Onderdeel van [Mesaguy.Prometheus](https://galaxy.ansible.com/mesaguy/prometheus) rol
- In orde

## Echo1: Nginx server

- Deze exporters gevonden [Knyar Nginx Lua Exporter](https://github.com/knyar/nginx-lua-prometheus) en [Hnlq715 exporter](https://github.com/hnlq715/nginx-vts-exporter)
- Deze 2 exporters staan niet op ansible-galaxy

## Kilo1: DHCP

- Deze exporter gevonden [Atonkyra DHCP stats prometheus](https://github.com/atonkyra/dhcp-stats-prometheus)
- Deze exporter staat niet op ansible-galaxy

## Lima1: Fileserver

- Nog zoeken achter rollen

## November1: Mariadb Gallera cluster

- Gebruik [Prometheus mysqld_exporter](https://github.com/prometheus/mysqld_exporter) (*Official*)
- Onderdeel van [Mesaguy.Prometheus](https://galaxy.ansible.com/mesaguy/prometheus) rol
