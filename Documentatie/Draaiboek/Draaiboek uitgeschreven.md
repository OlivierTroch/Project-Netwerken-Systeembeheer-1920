# Draaiboek Linux 

*Geschreven door: Thibault Dewitte & Bernard Deploige*  
*In samenwerking met: Joeri Verhavert, Olivier Troch*

## Ter info

Dit document is ter referentie voor onze eerste opstelling van de productie-omgeving op 18 november 2019.  
Er wordt verwacht dat iedereen dit document grondig heeft gelezen en dat iedereen weet wat er van hun verwacht wordt.

### Tijdsschema

| Tijd | Wat? |
| :----------- | :----------- | 
| 09u00-09u15 | Meeting 1 | 
| 09u15-12u00 | Sessie 1 | 
| 12u00-12u30 | Middagpauze | 
| 12u30-12u45 | Meeting 2| 
| 12u45-16u00 | Sessie 2 | 
| 16u00-16u45 | Evaluatie | 
| 16u45-17u00 | Opruimen | 
| 17u00-17u15 | Meeting 3 | 


## Planning

**Prioriteitslijst**  
Deze prioriteitslijst toont aan in welke volgorde we de machines zullen opstarten.

1. Netwerk & server opstellen (R&S & Productie-omgeving)
2. Kilo1 (DHCP)
3. Quebec1 (Forwarding DNS)
4. Alfa1 (Domeinserver)
5. Bravo1 & Charlie1 (DNS)
6. Oscar1 (Monitoring-systeem)
7. Papa1 (PXEBoot-server)
8. November1 (MariaDB)
9. Echo1 (Webserver)
10. Mike1 (Content management systeem)
11. Lima1 (Interne file-server)
12. Delta1 (Mailserver)


Zulu1 (firewall) kan apart worden opgesteld doorheen de hele dag.


### Meeting 1

In deze meeting gaan we nog even vlug een korte planning overlopen en herinneren wie aan te spreken indien er problemen zijn.  
Er wordt van iedereen verwacht dat ze dit document hebben gelezen en weten wat hun individuele taken zijn.  
Het tijdsschema wordt ook nog even overlopen maar iedereen zou dit al moeten kennen.  
Het is ook belangrijk om te vermelden dat elke groep en in het algemeen wordt bijgehouden waar het fout loopt en hoe we dit kunnen vermijden in de toekomst.  


### Sessie 1

Eerst en vooral zal alles moeten worden opgesteld door de teams van Routers & Switching en de productie-omgeving: hiervoor wordt maximum één uur voorzien.  
Tijdens dit ene uur wordt er verwacht van de andere groepen dat ze hun testplan, testrapport en troubleshooting documentatie allemaal klaar hebben staan.  
Eens het netwerk volledig is opgesteld zou aan de hand van `vagrant up` alles in de volgorde van de prioriteitslijst worden opgesteld.  
Het is van cruciaal belang dat elke groep op voorhand alles heeft getest en voorbereid is op alle mogelijke situaties.   
Indien er fouten zijn moet elke groep klaarzitten om deze zo snel mogelijk op te lossen, zodat alles vlot kan verlopen.  
Als er fouten voorkomen is het belangrijk dat deze genoteerd worden zodat we deze kunnen vermijden/oplossen voor de effectieve productiedag.  
Vanaf een server up is wordt er verwacht dat de bijhorende groep hun testplan volgt en dit zo efficiënt mogelijk probeert te doen.  
De testplannen kunnen apart worden uitgevoerd - zelfs als andere servers nog niet up and running zijn.  
Vooraf wordt ook een algemeen testplan opgesteld door de groep van de productie-omgeving: eens alles up and running is kan dit worden uitgevoerd.  


### Middagpauze

Gezamelijke middagpauze van 12u00 tot 12u30. We bestellen pizza voor iedereen van Domino's.  
De bestellingslijst van pizza wordt via een google doc woensdag 13 november aangemaakt: iedereen kan dan zijn gewenste pizza, maat en kostprijs meegeven (indien er deals zijn zeker checken.)  
Donderdagavond 14 november wordt deze lijst dan gefinaliseerd en zal er gevraagd worden op Trello om uw kost van de pizza dan over te schrijven naar een gezamelijke rekening.  
Er wordt verwacht dat dit van iedereen gebeurt vóór zondag zodat we de maandag kunnen bestellen.  
Als iemand niet gestort heeft dan zullen we de pizza van deze persoon niet bestellen.  


### Meeting 2

In deze meeting zullen we kort bespreken waar het fout loopt en hoe we dit kunnen oplossen tijdens sessie 2.  
We vermelden ook dat groepen waarbij alles goed verloopt hun testrapporten verder afwerken tijdens sessie 2.  


### Sessie 2

In deze sessie wordt verwacht dat de problemen die zich voordeden in sessie 1 worden opgelost.  
Testrapporten moeten volledig opgesteld zijn voor alle groepen.  
Het is hier opnieuw van belang dat alles voldoende gedocumenteerd is zodat we tijdens de finale productiedag op alle scenario's voorbereid zijn.  
Het laatste uur checkt het productieteam opnieuw of alles in orde is om geëvalueerd te worden.  


### Evaluatie

De docenten volgen ons globaal testplan en geven hierop feedback.  
Deze feedback staat niet op punten maar is toch wel heel belangrijk ivm de actuele productie-release in week 13.  


### Opruimen

Eens de evaluatie is afgerond wordt alles netjes opgeruimd: al het gebruikt materiaal wordt gereset en de desbetreffende kabels worden opgeborgen.  


### Meeting 3

Korte meeting om nog eens te reïtereren hoe alles verlopen is. 
Alle groepen kort overlopen hoe het gegaan is.  
