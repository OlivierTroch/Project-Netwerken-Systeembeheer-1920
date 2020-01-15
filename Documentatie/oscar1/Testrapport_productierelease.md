# Testrapport Oscar 1

> Voor het testen van deze server is het belangrijk dat bravo1 opstaat. Deze server is nodig voor het resolven van hostnames.

Breng de virtuele machine 'up' met het volgende commando: `vagrant up oscar1`.  
Bekijk de uitvoer van dit commando. Dit mag geen foutmeldingen geven.

- [x] Commando geeft geen foutmeldingen

## Testen Prometheus website

- **172.16.1.5:9090** -  *Prometheus*
  - [x] Website kan worden bekeken
  - Op deze website ga je naar *Status > Targets*.
  - Alle servers, routers, switches en firewalls die aanstaan, moeten onder de hoofding *SNMP* als **state** *up* hebben.
    - [x] Dit is in orde

## Testen Grafana dashboards

- **172.16.1.5:3000** - *Grafana dashboard*
  - [x] Website kan worden bekeken
  - Log op deze website in met volgende gegevens:
    - **Gebruikersnaam**: admin
    - **Wachtwoord**: oscar1
    - [x] Op de website kan worden ingelogd

### Node Exporter Server Metrics Dashboard

> Op deze website ga je naar *Home (linksboven) > Node Exporter Server Metrics*.

- Selecteer de gewenste servers bij *Node* (linksboven)
- Verander de tijd (*rechtsboven*) van *Last 7 days* naar *Last 5 minutes*
- Krijg je nergens de foutmelding *No Data*? (Behalve bij Conntrack)
  - [x] In orde

## Node Exporter Full Dashboard

> Selecteer het dashboard *Node Exporter Full* (Links bovenaan, waar *Node Exporter Server Metrics*)

- Kies de gewenste server bij *Host* (linksboven)
- Verander de tijd (*rechtsboven*) van *Last 7 days* naar *Last 5 minutes*
- Krijg je nergens de foutmelding *No Data*?
  - [x] In orde

### SNMP Interface Througput Dashboard

> Selecteer het dashboard *SNMP Interface Throughput* (Links bovenaan, waar *Node Exporter Server Metrics*)

- Kies de gewenste server bij *Host* (linksboven)
- Verander de tijd (*rechtsboven*) van *Last 7 days* naar *Last 5 minutes*
- Krijg je nergens de foutmelding *No Data*?
  - [x] In orde

## Testen monitoren specifieke services

### Bind DNS Monitoring

#### Voorbereiding

- Voor het testen van DNS monitoring moeten `bravo1` en `charlie1` draaien. Dit doe je met volgend commando:

```bash
vagrant up bravo1 charlie1
```

#### Testen

- **172.16.1.5:9090** - *Prometheus*
  - [x] Website kan worden bekeken
  - Op deze website ga je naar *Status > Targets*.
  - Alle servers die draaien, moeten onder de hoofding *Bind* als **state** *up* hebben in de tabel.
    - [x] Dit is in orde
- **172.16.1.5:3000** - *Grafana dashboard*
  - Op deze website ga je naar *Home (linksboven) > Bind DNS (Fixed)*.
  - Kies de gewenste server bij *Instance* (linksboven)
  - Verander de tijd (*rechtsboven*) van *Last 7 days* naar *Last 5 minutes*
  - Krijg je nergens de foutmelding *No Data*?
  > Enkel bij "Resolver Cashe RR Sets" , "CPU Usage" en "Named CPU Time" wordt er geen data gevonden
    - [x] In orde

### MariaDB monitoring

#### Voorbereiding

- Voor het testen van DNS monitoring moeten `november1` draaien. Dit doe je met volgend commando:

```bash
vagrant up november1
```

#### Testen

- **172.16.1.5:9090** - *Prometheus*
  - [x] Website kan worden bekeken
  - Op deze website ga je naar *Status > Targets*.
  - Alle servers die draaien, moeten onder de hoofding *MySQL* als **state** *up* hebben in de tabel.
    - [x] Dit is in orde
- **172.16.1.5:3000** - *Grafana dashboard*
  - Op deze website ga je naar *Home (linksboven) > MySQL Overview*.
  - Kies de gewenste server bij *Host* (linksboven)
  - Verander de tijd (*rechtsboven*) van *Last 7 days* naar *Last 5 minutes*
  - Krijg je nergens de foutmelding *No Data*?
    - [x] In orde

### Nginx Monitoring

#### Voorbereiding

- Voor het testen van DNS monitoring moeten `echo1` en `mike1` draaien. Dit doe je met volgend commando:

```bash
vagrant up echo1 mike1
```

#### Testen

- **172.16.1.5:9090** -  *Prometheus*
  - [ ] Website kan worden bekeken
  - Op deze website ga je naar *Status > Targets*.
  - Alle servers die draaien, moeten onder de hoofding *Nginx* als **state** *up* hebben in de tabel.
    - [ ] Dit is in orde
- **172.16.1.5:3000** - *Grafana dashboard*
  - Op deze website ga je naar *Home (linksboven) > NGINX by nginxinc*.
  - Kies de gewenste server bij *Instance* (linksboven)
  - Verander de tijd (*rechtsboven*) van *Last 7 days* naar *Last 5 minutes*
  - Krijg je nergens de foutmelding *No Data*?
    - [ ] In orde

> **Indien alles in orde**:
> - [ ] Testen geslaagd!
