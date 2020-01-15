# Testplan Zulu1
## Requirements
* De server is up and running.
* XML bestand in geimporteerd.
* Externe computer is geconnecteerd om de web GUI te bereiken.

### Controleer de interfaces via de web GUI
* [] Controleer of deze correct ingesteld zijn.
	* WAN: 172.16.1.106/30
    * LAN: 172.16.1.102/30

* [] Controleer of de daemon services aan staan.
    * Kies voor services in de navigatiebalk en druk op SNMP in het dropdown menu.
	* De services staan aan, met polling port 161.

* [] Controleer of de juiste roles/aliases aan staan
	* Kies voor firewall in de navigatiebalk en druk op aliases in het dropdown menu.
	* De volgende aliases moeten bestaan:
		* HTTPandHTTPS
			* Poort 80 & 443
		* IMAPandIMAPS
			* Poort 143 & 993
		* POPandPOPS
			* Poort 110 & 995

* [] Controleer of DHCP Server is uitgeschakeld
	* Kies voor services in de navigatiebalk en druk op DHCP Server in het dropdown menu
	* Enable DHCP is niet aangeduid

* [] Controleer of IPv6 is uitgeschakeld
	* Kies voor system in de navigatiebalk, druk op advanced in het dropdown menu en druk vervolgens op networking
	* Allow IPv6 is aangeduid (dit betekend dat ipv6 geblokeerd wordt.)

* [] Ping naar de interfaces van je externe computer
	* Gebruik je commandline en ping naar:
		* WAN: 172.16.1.106/30
		* LAN: 172.18.1.102/30
