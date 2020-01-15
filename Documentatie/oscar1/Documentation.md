# Documentatie

## To Do

- [x] Zoeken naar goede ansible role
- [x] Prometheus laten draaien op server `oscar1`
- [X] Node exporter op anders servers installeren
- [X] Zorgen dat andere servers naar prometheus rapporteren
- [X] Querying zodat juiste informatie wordt getoond
- [x] Installatie *Grafana* met ansible
- [X] Zorgen dat alles correct wordt weergegeven op grafana
- [X] SNMP Monitoring
- [ ] Monitoring specifieke services
- [ ] Monitoring client pc's

## Stappenplan opzetten

1. `vagrant up oscar1`

## Uitleg configuratie bestanden

1. Installeer prometheus-role van [Ansible Galaxy](https://galaxy.ansible.com/cloudalchemy/prometheus)

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
    - bertvv.rh-base
    - cloudalchemy.prometheus
    - cloudalchemy.grafana
    - cloudalchemy.snmp-exporter
    - jdauphant.dns
```

3. Maak het bestand `ansible/host_vars/oscar1.yml` aan en voeg volgende code toe.  

Functionaliteit code:

- Nodige firewall regels instellen
- DNS servers van de server instellen (de DNS server moet opstaan om de servers te kunnen monitoren)
- Prometheus targets toevoegen (apparaten die gemonitored moeten worden)
  - Bind DNS monitoring
  - Generieke monitoring (CPU, RAM, netwerk, ...)
  - SNMP Monitoring (Cisco + firewall)
- Grafana credentials instellen
- Grafana datasource instellen
- Grafana dashboard downloaden

``` yml
---
---
rhbase_firewall_allow_services:
  - http
  - https
rhbase_firewall_allow_ports:
  - 9090/tcp
  - 3000/tcp
  - 9116/tcp

dns_nameservers: 
  - 172.16.1.66 
  - 10.0.2.3

prometheus_scrape_configs:
  - job_name: "bind"
    metrics_path: "/metrics"
    static_configs:
      - targets:
        - bravo1.green.local:9119
        - charlie1.green.local:9119

  - job_name: "prometheus"
    metrics_path: "/metrics"
    static_configs:
      - targets:
          - alpha1.green.local:9100
          - bravo1.green.local:9100
          - charlie1.green.local:9100
          - delta1.green.local:9100
          - echo1.green.local:9100
          - kilo1.green.local:9100
          - lima1.green.local:9100
          - mike1.green.local:9100
          - november1.green.local:9100
          - oscar1.green.local:9100
          - papa1.green.local:9100
          - quebec1.green.local:9100
  - job_name: 'snmp'
    static_configs:
      - targets:
        - 172.16.1.97  # SNMP device.
        - 172.16.1.98
        - 172.16.1.80
        - 172.16.1.50
        - 172.16.0.80
        - zulu1.green.local
    metrics_path: /snmp
    params:
      module: [if_mib]
    relabel_configs:
      - source_labels: [__address__]
        target_label: __param_target
      - source_labels: [__param_target]
        target_label: instance
      - target_label: __address__
        replacement: 172.16.1.5:9116  # The SNMP exporter's real hostname:port.

grafana_security:
  admin_user: admin
  admin_password: oscar1
grafana_datasources:
  - name: "prometheus"
    type: "prometheus"
    access: proxy
    url: 'http://localhost:9090'
    basicAuth: false
grafana_dashboards:
  - dashboard_id: 405 # Algemeen
    revision_id: 8
    datasource: 'prometheus' 
  - dashboard_id: 1860 # Node exporter full, 1 server tegelijk
    revision_id: 15
    datasource: 'prometheus' 
  - dashboard_id: 2408 # SNMP Interface throughput
    revision_id: 1
    datasource: 'prometheus'
  - dashboard_id: 10024 # BIND DNS
    revision_id: 1
    datasource: 'prometheus'
```

1. Voeg aan alle servers in het bestand `ansible/servers.yml` de rol cloudalchemy.node-exporter toe.

## Bekijken van de grafieken met grafana

1. Zet oscar1 en bravo1 op `vagrant up bravo1 oscar1` (oscar1 heeft bravo1 nodig om de namen te resolven naar IP adressen)
2. Zet de verschillende servers die je wenst te monitoren op
3. Surf naar 172.16.1.5:3000
4. Login met gebruikersnaam `admin` en wachtwoord `oscar1`
5. Klik linksboven op home
6. Selecteer het enige dashboard in de lijst
7. Bekijk de grafieken

## Status Monitoring verschillende linux servers

|  Server   | Monitoring status                         |
| :-------: | ----------------------------------------- |
|   Alfa1   | Success                                   |
|  Bravo1   | Success                                   |
| Charlie1  | Success                                   |
|  Delta1   | Success --> mits toevoegen firewall regel |
|   Echo1   | Success                                   |
|   Kilo1   | Success                                   |
|   Lima1   | Success                                   |
|   Mike1   | Success                                   |
| November1 | Success                                   |
|  Oscar1   | Success                                   |
|   Papa1   | Success                                   |
|   Zulu1   | Success --> Via SNMP                      |

## Troubleshooting

### Grafana: No data

Indien op het grafana dashboard bij bepaalde zaken staat "No data" kan je rechtsboven de timespan van de grafieken aanpassen, standaard staat dit op zeven dagen. Indien de server nog maar net is opgestart heeft hij nog geen 7 dagen oude data. Selecteer dan bv.: laatste 5 minuten

## Geen servers bereikbaar

De oscar1 server maakt gebruik van de DNS-server bravo1 om de hostnamen (alfa1,bravo1,...) om te zetten naar IP-addressen.  
 Indien er geen verbinding kan gemaakt worden met de DNS-server bravo1, dan zal prometheus geen verbinding kunnen maken met de andere servers.  
Zorg er dus altijd voor dat de prometheus server connectie heeft met de server DNS-server.

## Resources

- [MariaDB monitoring](https://dzone.com/articles/monitoring-mysql-server-metrics-using-prometheus-g)