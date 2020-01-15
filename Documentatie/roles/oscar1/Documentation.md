# Documentatie

## To Do

- [x] Zoeken naar goede ansible role
- [x] Prometheus laten draaien op server `oscar1`
- [ ] Prometheus op anders servers installeren
- [ ] Prometheus queries schrijven
- [ ] Zorgen dat andere servers naar prometheus rapporteren
- [ ] Querying zodat juiste informatie wordt getoond
- [x] Installatie *Grafana* met ansible
- [ ] Zorgen dat alles correct wordt weergegeven op grafana

## Notes to Stijn

> Bij testen zorgen dat je andere servers in `ansible/servers.yml` in commentaar zet. Deze gaven bij mij soms foutmeldingen omdat er dingen bij hen nog niet werken.
>
> Installatie lukt bij mij, zie [output](commandoutput.txt).
>
> Pingen naar het ip-adres van oscar1 (`172.16.1.5`), gaat zonder problemen, maar als ik `172.16.1.5:9100`(!1) probeer te openen in Firefox, dan lukt dit niet. Dit al geprbeerd maar werkte niet:
>
> * Firewallregel toevoegen met http en https (`sudo firewall-cmd --add-service http`)
> * Log over prometheus nog niet gevonden, als je dit googled krijg je resultaten van hoe logs er in importeren of hoe de logs bekijken als het draait op docker
>
> Weet dus niet zeker als prometheus al draait op het systeem. Configuratiebestanden (`/etc/prometheus/*`) kan ik wel bekijken op de vm.
> 
> !1: deze poort staat ingesteld in [server.yml](/ansible/servers.yml)

## Notes to Maarten

> De prometheus server is bereikbaar via `172.16.1.5:9090`
> Grafana is geinstalleerd, bereikbaar via `172.16.1.5:3000`
>   Grafana username: `admin`
>   Grafana password: `oscar1`
> Het viel mij op dat standaard Firewalld is uitgeschakeld bij het opstarten van de server

## Stappenplan opzetten

1. `vagrant up oscar1`

## Stappenplan enkele server

1. Installeer prometheus-role van [Ansible Galaxy](https://galaxy.ansible.com/cloudalchemy/prometheus):

```bash
ansible-galaxy install cloudalchemy.prometheus
```

2. Vul het playbook aan met volgende code

```yml
---
- hosts: oscar1
  become: true
  gather_facts: yes
  roles:
  - oscar1
  vars:
    prometheus_targets:
      node:
      - targets:
        - 172.16.1.5:9100
        labels:
          env: demosite
```
