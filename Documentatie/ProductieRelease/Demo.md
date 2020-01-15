## Demo

Alle servers moeten getoond worden dat ze runnen & werken.

### Server status

Plan A: Aan de hand van Oscar1 tonen dat alle servers up and running zijn en dat de gegevens kunnen worden opgehaald.
Plan B: Pingen naar elke server

### Operationaliteit van de servers

Kilo1 (DHCP): Adhv een client een IP adres opvragen (kan een minuutje duren)  
Quebec1 (Forwarding DNS): Vanuit dezelfde client naar www.google.com surfen  
Alfa1 (Domeinserver): "getent passwd" EN "getent group" op de client - inloggen met gemaakte users kan ook  
Bravo1 & Charlie1 (DNS): nslookup doen naar willekeurige server binnen green.local (bvb. nslookup alfa1.green.local)  
Oscar1 (Monitoring-systeem): via mon.green.local inloggen met gebruikersnaam "admin" wachtwoord  "oscar1"  
Papa1 (PXEBoot-server): Aan de twee laptops zullen Robin en Piet demonstreren dat PXEBoot werkt   
November1 (MariaDB): Dylano zal dit demonstreren  
Echo1 (Webserver): Karel zal dit demonstreren  
Mike1 (Content management systeem): Karel zat dit demonstreren  
Lima1 (Interne file-server): Lima groep zal dit demonstreren  
Delta1 (Mailserver): Delta groep zal dit demonstreren  