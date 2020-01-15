# Testplan papa1 voor productierelease

## ISO files in pxeboot rol plaatsen & controleren of ze er zijn

Vooraleer de pxeserver wordt up gebracht aan de hand van Ansible, zorgen we dat de server al onze nodige bestanden heeft voor de papa1-pxeserver rol
Ga op laptop naar de papa1-pxeserver map en gebruik secure copy:

TEMP: ww: GreenAdmin18
Opmerking: VLAN 20 172.16.0.0 /24
gateway: 172.16.0.254

Opmerking: bij het up brengen van andere VM's  (dus voor en na papa1) de iso files  verplaatsen naar een andere folder, zodat niet elke rol de iso's in een shared folder laden.
De iso files plaatsen we  tijdelijk in /home/student/

	scp -r files student@172.16.1.10:/home/student/p3ops-1920-green/ansible/roles/papa1-pxeserver

testen: Check in de server of de files aanwezig zijn:

	ssh student@172.16.1.10
	cd /home/p3ops-1920-green/ansible/roles/papa1-pxeserver/files
	ls



## Services

Controleer op de PXEserver dat volgende services correct draaien: 
- nginx

        systemctl status nginx
- xinetd
        
  
        systemctl status xinetd

## Mounts
Verifiëer dat de iso files correct gemount zijn:

    cat /proc/mounts | grep /var/www/html
Moet als uitvoer geven:

    /dev/loop0 /var/www/html/centos8 iso9660 ro,relatime 0 0
    /dev/loop1 /var/www/html/fedora iso9660 ro,relatime 0 0

## Connectiviteit met nieuwe vm's
- Werkstation booten met als eerste bootoptie "boot via network"
- Blauw scherm moet zichtbaar worden met opties voor CentOS8 en Fedora Workstation
- Bij het kiezen van de CentOS8 optie worden de installatie files gemount en begint de installatie van de OS zonder foutmeldingen
- Bij het kiezen van de Fedora optie worden de correcte files gemount en begint de installatie van de OS zonder foutmeldingen

&rarr; De hosts geboot & geïnstalleerd adhv de PXEboot server worden apart getest adhv test files. Deze bevinden zich buiten het algemeen testplan.

# Hosts testen

## CentOS

Zoek het ip adres op host adhv

	ip a

### Test mogelijkheid tot Ansible gebruiken als CMS adhv:

	#wachtwoord is papacentos
	ssh root@~ipaddrhost~

### Test admin user:

	#wachtwoord is AdminGreen
	su admin

### test package installatie / configuratie updates
   * touch testfile
   * nano: nano testfile -> ctrl x
   * vim: vim testfile -> :q
   * test autocompletion in bash met tab
   * test net-tools: ifconfig
   * curl: curl -> ok als er suggesties gegeven worden, NOK als er staat "curl command not found" 

### test monitoring

Surf naar ~ipaddrhost~:9100

## Fedora

### Inloggen met user

 root : root
 vagrant : vagrant

### controlleer aanwezigheid Firefox (webbrowser)
  * Ga na of u het icoontje van firefox op uw bureaublad ziet. 
### controleer aanwezigheid Libreoffice (Office)
  * Ga na of u het icoontje van Libreoffice op uw bureaublad ziet. 
### Controleer aanwezigheid thunderbird (Mailclient)
  * Ga na of u het icoontje van thunderbird op uw bureaublad ziet. 
### Controleer aanwezigheid okular (PDF-viewer)
  * Ga na of u het icoontje van okular op uw bureaublad ziet. 
### test monitoring
  * Surf naar ~ipaddrhost~:9100