# Technische documentatie fedora kickstart file

In dit document zal ik de fedora kickstart file verder toelichten. Deze is uiteindelijk nooit getest omdat ik de hele tijd gebruik maakte van een live versie van fedora waardoor de kickstart file nooit uitgevoerd werd. 

## Uitleg kickstart file

### Systeem configuratie
Als eerrste wordt de bootloader option ingesteld. Dit is de plek waar het OS opgeslaan zal worden eenmaal het via het netwerk verstuurd is. Daarna worden enkele opties mee gegeven, waaronder de link naar de pxeserver, het juiste toetsenbordformaat en de systeemtaal. 

Daarna ziet u dat er een user `vagrant` toegevoegd wordt met geëncrypteerd wachtwoord `vagrant`. Ook het rootwachtwoord wordt ingesteld. De firewall wordt geconfigureerd om het juiste verkeer door te laten en de interfaces worden ingesteld om dhcp te gebruiken. 
Hierna worden nog enkele opties zoals systeem configuratieinfo, tijdzone en schijf partitionering ingesteld. 

### Post scripts
Vanaf de `%post` tag worden de post scripts uitgevoerd. Deze zijn grotendeels om de liveversie van fedora te ondersteunen. Helemaal op het einde heb ik nog enkele zaken toegevoegd. Node Exporter wordt gedownload en geconfigureerd. Dit is iets dat de mensen van de monitoringserver nodig hadden voor het monitoren van onze hosts. 
Daarna wordt ook Okular geïnstalleerd. Dit is een applicatie om PDF bestanden te lezen. 
Als laatste worden ook nog enkele lijnen code toegevoegd voor de ladp server. Zo moet met alle gebruikers van het domein ingelodgd kunnen worden op onze host. De `%end` wijst op het einde van de post scripts. 


### Packages
 
Vanaf de `%packages` beginnen de packages die geïnstalleerd moeten worden. Dit zijn veelal applicatie, zoals firefox als webbrowser of libreoffice als alternatief voor de office software. Bij de `%end` stoppen de packages en eindigt ook deze kickstartfile. 