# Handleiding Quebec1

## Opstarten server
Wanneer je je bevindt in de rootmap van het project, kan je de server doen starten met het volgende commando in de Terminal/CMD:
```bash
vagrant up quebec1
```

## Uitleg Ansible rollen
Op deze server worden 2 rollen geïnstalleerd:
* [bertvv.rh-base]()
* [bertvv.dnsmasq]()

Dit wordt op de volgende manier gedaan in servers.yml:
```yml
- name: Configure quebec1
  hosts: quebec1
  gather_facts: yes
  remote_user: root
  roles:
    - bertvv.rh-base
    - bertvv.dnsmasq
```

Deze configuratie zorgt ervoor dat iedere keer dat je de server opstart, deze rollen automatisch zullen geïnstalleerd worden.
Er wordt gebruikgemaakt van de standaardvariabelen van deze rollen. Indien er variabelen gespecifieerd zijn in /host_vars/quebec1.yml zullen deze gebruikt worden door de rollen.

## Uitleg Variabelen in quebec1.yml
### bertvv.rh-base
[Ansible Galaxy Link]()

```yml
rhbase_firewall_allow_services:
  - dns
```

Deze aanpassing zorgt ervoor dat de firewall alle DNS verkeer zal doorlaten.

### bertvv.dnsmasq
[Ansible Galaxy Link]()

```yml
dnsmasq_domain: 'green.local'
```

De aanpassing van deze variabele zorgt ervoor dat de server in het juiste domein zal zitten.

```yml
dnsmasq_domain_needed: 'false'
```

Deze aanpassing zorgt ervoor dat lokale requests van clients nog steeds geforward zullen worden.

```yml
dnsmasq_upstream_servers:
  - /green.local/172.16.1.66
  - /green.local/172.16.1.67

  - 8.8.8.8
```

In deze variabele zitten meerdere zaken.
* 172.16.1.66 is het IP-adres van Beta1, de Primary DNS
* 172.16.1.67 is het IP-adres van Charlie1, de Secondary DNS

* 8.8.8.8 is de DNS van Google, dit wordt gebruikt wanneer de opgevraagde adressen zich niet binnen het domein bevinden.