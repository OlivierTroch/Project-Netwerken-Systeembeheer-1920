# productiedag

## Testen netwerk en afhankelijkheden

dhcp testen door via gepatchte poort met laptop ip address te proberen krijgen

Ping papa1 om te checken of onze server up is:

	ping 172.16.1.6

vanaf dat we papa1 kunnen pingen
=> centos proberen pxebooten
=> sshen naar 172.16.1.6 en controleren of alles eruit ziet als bedoeld

pingen naar alfa1

	172.16.1.65

vanaf we alfa1 kunnen pingen
=> fedora kan pxeboot (script in kickstart fedora voor inlogmogelijkheden alfa1)

## Testen pxeserver

Controleer op de PXEserver dat volgende services correct draaien: 

- nginx

      systemctl status nginx

- xinetd
        

      systemctl status xinetd

Verifiëer dat de iso files correct gemount zijn:

    cat /proc/mounts | grep /var/www/html

Moet als uitvoer geven:

    /dev/loop0 /var/www/html/centos8 iso9660 ro,relatime 0 0
    /dev/loop1 /var/www/html/fedora iso9660 ro,relatime 0 0

## Testen CentOS

Zoek het ip adres op host adhv

	ip a

Test mogelijkheid tot Ansible gebruiken als CMS adhv:

	#wachtwoord is papacentos
	ssh root@~ipaddrhost~

Test admin user:

	#wachtwoord is AdminGreen
	su admin

test package installatie / configuratie updates

   * touch testfile
   * nano: nano testfile -> ctrl x
   * vim: vim testfile -> :q
   * test autocompletion in bash met tab
   * test net-tools: ifconfig
   * curl: curl -> ok als er suggesties gegeven worden, NOK als er staat "curl command not found" 

test monitoring

Surf naar ~ipaddrhost~:9100

test internetverbinding

	curl icanhazip.com

deze curl moet antwoorden met uw publiek ip address.

## Testen Fedora

Inloggen met user

testfedora : testPass

controlleer aanwezigheid Firefox (webbrowser)

  * Ga na of u het icoontje van firefox op uw bureaublad ziet. 

controleer aanwezigheid Libreoffice (Office)

  * Ga na of u het icoontje van Libreoffice op uw bureaublad ziet. 

Controleer aanwezigheid thunderbird (Mailclient)

  * Ga na of u het icoontje van thunderbird op uw bureaublad ziet. 

Controleer aanwezigheid okular (PDF-viewer)

  * Ga na of u het icoontje van okular op uw bureaublad ziet. 

test monitoring

  * Surf naar ~ipaddrhost~:9100

test inloggen door alfa1

* alfa1 test dit

-----

# Productiedag report

## Testen netwerk en afhankelijkheden

* Dhcp werkt : we kregen met laptop een ip adress toegewezen, namelijk: 172.16.0.6 /24
  * pxeboot slaagde niet, kreeg geen dhcp offer
  * => probeer pingen naar dhcp server (172.16.1.1) - dit was succesvol, dus dhcp kan ip's toewijzen (aan laptop) en we kunnen dhcp pingen, maar toch krijgen onze clients geen ip address bij het booten via netwerk.
  * We dachten dat het netwerk te traag ging en dat de computers te snel opgaven met dhcp discover.  Dust stopten patchten we de ethernetkabels naar het netwerk waarin de dhcp server stond. Dit loste niets Op.
  * Door het feit dat we wel ip adressen kregen met laptops en niet met de 2 clients van school, dachten we dat het probleem lag aan de 2 clients. Na pxebooten met laptop kreeg deze wel dhcp offers. Dus we stopten met het gebruik van deze clients.
  * Oplossing: neem virtualbox, verbind laptop met pc, start een virtuele client, stel enkel een bridged adapter in voor de virtuele client en neem netwerk als eerste optie om te booten.
* Pingen naar papa1 succesvol! (ping 172.16.1.6)
* pingen naar alfa1 succesvol (172.16.1.65)

## Testen pxeserver

* sshen naar papa1 werkt (student:student)
* systemctl nginx - ok
* xinetd  - ok
* isofiles correct gemount

## Testen CentOS

* azerty juist ingesteld

* inloggen (root : papacentos) - ok

* inloggen (admin : AdminGreen) - ok 

* monitoring - NOK

  * curl 127.0.0.1:9100 ---

    * sudo systemctl status node_exporter

    * /tmp vonden we wel de node_exporter files

    * we konden deze niet unpacken, dus het probleem was hoogstwss dat in de kickstartfile het script deze ook niet konden unpacken

    * installeren tar

    * service knn starten, maar

    * ...
    
      

* ssh vanop machine in het netwerk (voor Ansible (root : papacentos)) - ok 

* packages allemaal succesvol getest - ok

* internetverbinding - ok



## Testen Fedora

* Libreoffice - ok
* Firefox - ok
* Thunderbird - ok
* Okular (pdf) - ok
* monitoring - NOK
* LDAP : inloggen door team alfa1 -
  * Bij rebooten viel heel de installatie van fedora weg.
  * Misschien installeren we de live versie van fedora
  * Oplossing: downloaden andere fedora iso en met scp de huidige fedore iso vervangen.
  * scp Fedora_Workstation.iso student@172.16.1.6:/home/student
  * manueel verzetten van de iso naar /vagrant/ansible/roles/papa1-pxeserver/files
    * sudo cp /home/student/Fedora_Workstation.iso /vagrant/ansible/roles/papa1-pxeserver/files
  * Opnieuw mounten van nieuwe iso
    * sudo umount /var/www/html/fedora/
    * sudo mount -o loop /vagrant/ansible/roles/papa1-pxeserver/files/Fedora_Workstation.iso /var/www/html/fedora
  * -> probleem met installatie source (is dit omdat het nu een minimal iso is en de kickstart onvolledig is hiervoor?)
    * "Error setting up software source"
    * "Erorr checking software selection"