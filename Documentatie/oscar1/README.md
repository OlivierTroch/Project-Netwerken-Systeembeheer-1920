# Oscar1 Asssignment

Een monitoringsysteem dat de toestand van het gehele netwerk + services kan vi-sualiseren. Het specifieke systeem kunnen jullie zelf kiezen: Elastic Stack, Collectd,Sensu, ...Overleg hierover met jullie begeleider.

Afhankelijk van het type apparaat worden minstens volgende parameters opge-volgd:

*  Cisco routers en switches en Firewalls (via SNMP)

   * CPU-gebruik
   * Geheugengebruik
   * Inkomend verkeer op alle netwerkpoorten
   * Uitgaand verkeer op alle netwerkpoorten

* Linux servers (zowel fysieke hosts als VMs)
  * CPU-gebruikmGeheugengebruikmToestand van de harde schij(f)(ven)
  * Toestand van de specifieke service die op de machine draait (bv. metrieken over de database-queries, HTTP-requests, DNS-requests, enz.)

* Werkstations:
  * CPU-gebruik
  * Geheugengebruik
  * Toestand van de harde schij(f)(ven)
  * Gebruikerslogins

De resultaten zijn raadpleegbaar via een dashboard dat ook oposcar1draait, via urlhttps://mon.green.local/. Sommige monitoringsystemen hebben een ingebouwdsysteem voor visualisatie (bv. Kibana voor Elastic Stack), er bestaan ook afzonder-lijke tools (bv. Grafana of Graphite)