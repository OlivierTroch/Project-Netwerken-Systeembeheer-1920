# Documentatie Productie-release
## Flash Centos on USB
### Software
* Download gepaste software voor het crëeren van een Live usb. Dit kan Rufus, Etcher,etc..
        * Rufus : [Download rufus](https://rufus.ie/)
        * Etcher : [Download Etcher](https://www.balena.io/etcher/)
* Download CentOS iso file.
        * CentOS : [Download CentOS ISO](https://www.centos.org/download/)
### Flash Live USB(Indien je etcher hebt gekozen)
![Etcher image](Images/etcher.png)
* Selecteer "Select image".
* Vervolgens kies je de gepaste ISO file.
* Als laatste kies je voor "Flash!"

### Configuratie
* Boot de server via de USB stick. Dit doe je door volgende stappen te volgen:
    * a
    * b
    * c
![opstart image](Images/Opstart.png)
* Vervolgens kies je voor "Test this media & install Centos Linux 8..."
![Keyboard](Images/Opstart.png)
* Nu ben je in de configuratie van Centos. Hier vindt je alle nodige settings die je kunt aanpassen.
![configuratie scherm](Images/taalscherm.png)
* Kies je de gepaste taal.
* Klik vervolgens op Continue.
* Indien je de keylayout wilt aanpassen, dan kies je voor 'keyboard'.
    * Klik op het plusje om een nieuw keyboard layout toe te voegen.
    * Klik op add wanneer je jouw gepaste keylayout hebt gekozen.  
![configuratie scherm](Images/Timezone.png)
* Indien je de datum en tijd wilt aanpassen, dan kies je voor 'Time & Date'.
    * Kies je gepaste timezone, en klik op "Done".
![software](Images/software_selection.png)
* Vervolgens kies je voor "Software Selection", omdat we een Minimale CentOS server willen.
    *   Kies voor "Minimal Install".
    *   Indien je wilt kan je een aantal "Add-ons" selecteren.
![software](Images/destination.png)
* Als voorlaatste kies je voor "Installation Destination"
    * Kies voor de gepaste disk om de installatie uit te voeren.
    * Klik vervolgens op "Done".
* Indien je wenst, kan je nog zaken aanpassen zoals kdump, network & hostname, security policy.
    * Dit is niet verplicht.
* Klik op "Begin Installatie" om de installatie te beginnen.
![user](Images/adminuserCentos.png)
* Het systeem vraag je nu, om een gebruik aan te maken. Maak een gebruiker aan met volgende eigenschapppen:
    * Full name: admin.
    * User name: admin.
    * Vink "Make this user administrator" aan.
    * Vink : "Require a password to this account" aan.
    * Geef een gepast wachtwoord in.
    * Klik op "Done"
* Wacht tot de installatie voltooid is.
    * Sluit de machine af.
    * Haal de usb uit de server.
    * Start the machine terug op.
### Run script
