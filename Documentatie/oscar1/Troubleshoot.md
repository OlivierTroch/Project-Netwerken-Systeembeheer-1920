# Troubleshoot

## Niet alle hosts kunnen worden gemonitord

* Staan de ip-adressen/hostnames juist ingesteld
* Zijn er firewall-regels die zorgen dat er geen data kan worden opgehaald?

## Grafana: No data

Indien op het grafana dashboard bij bepaalde zaken staat "No data" kan je rechtsboven de timespan van de grafieken aanpassen, standaard staat dit op zeven dagen. Indien de server nog maar net is opgestart heeft hij nog geen 7 dagen oude data. Selecteer dan bv.: laatste 5 minuten

## Geen servers bereikbaar

De oscar1 server maakt gebruik van de DNS-server bravo1 om de hostnamen (alfa1,bravo1,...) om te zetten naar IP-addressen.  
 Indien er geen verbinding kan gemaakt worden met de DNS-server bravo1, dan zal prometheus geen verbinding kunnen maken met de andere servers.  
Zorg er dus altijd voor dat de prometheus server connectie heeft met de server DNS-server.