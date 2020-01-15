# CentOS kickstart file

## 1. Wat er allemaal mis ging

Het is aangeraden om eerst een fysieke install te doen en van daaruit de anaconda kickstart file te halen.
installs van de minimale CentOS 8 faalde telkens opnieuw (heel wat verschillende virtualbox instelling geprobeerd + zowel op ubuntu systeem als windows systeem) en ik kreeg telkens een zeer kleurrijk scherm als resultaat. CentOS 8 heeft ook nog geen aparte minimale install, enkel de 8gb iso met als optie tijdens installatie de minimale versie. Hierdoor ben ik uiteindelijk toch overgeschakeld naar CentOS 7.

Vervolgens probeerde ik via een gui programma een geavanceerder kickstart file te maken. 

	sudo apt-get install system-config-kickstart
	system-config-kickstart
Dit moet uitgevoerd worden op de os in kwestie. Doordat ik dit runde op mijn ubuntu machine, gaf dit syntax voor een ubuntu kickstart file. En kon ik enkel een Ubuntu optie aanklikken.

## 2. Installeer centos en neem de anaconda-ks.cfg

Na installatie van centos op een fysieke laptop , nam ik de anaconda-ks.cfg over via ssh.

Opmerking: ingloggegevens: root : "papacentos"

Deze sloeg ik op als "centos_base.cfg" en ik paste 2 lijnen aan:
We willen geen grafische installatie, dus veranderen "graphical" naar "text". En netwerk installation omdat onze pxe-server via http werkt.

	# use network installation
	url --url="http://172.16.1.6:8188/centos8"
	# changed graphical to text
	text

###  Testen pxeboot en aanpassen centos8.cfg

Verplaats en hernoem de kickstarter file: roles/papa1-pxeserver/templates/centos8.cfg

in de [documentatie](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/installation_guide/sect-kickstart-syntax#sect-kickstart-packages) alles opgezocht dat "(required)" was.

Testen doormiddel van een nieuwe vm te booten in virtualbox met  "Network" als eerste bootoptie. Bij netwerkopties intern netwerk aanduiden.
Testboot via netwerk gaf veel fouten in verband met de drive "sdb"
 Oplossing : elkens "sdb"veranderen naar "sda", dit is vermoedlijk omdat ik de eerste manuele install via usb deed en hij hierdoor de drive toen sdb noemde.

@minimal package werd niet gevonden => opgelost door weg te halen

De pxeboot was succesvol met de aangepaste basis kickstarter. Vervolgens gaan we de kickstarter file meer configureren:

Verwijderd:

	network  --hostname=localhost.localdomain

Toevoegingen:

```
# Reboot after installation
reboot
```

na reboot gebruikte hij opnieuw de netwerkboot, voeg bij bootloader de optie "--leavebootorder" toe om de installatie als eerste bootoptie in te stellen:

	bootloader --append=" crashkernel=auto" --location=mbr --boot-drive=sda --leavebootorder

Opmerking: De bootorder werd niet automatisch aangepast, maar de redhat documentatie zegt duidelijk dat --leavebootorder dit zou moeten doen. Vermoedelijk werkt dit wel in een werkelijke omgeving, maar niet met virtualbox, omdat hier de bootorder niet werd aangepast.


## 4. Configuratie systeem 

### 4.1 voorconfiguratie 

User admin toevoegen

	# Maak user admin aan
	user --name="admin" --password="AdminGreen" --groups="wheel"

Handige packages installeren & het systeem updaten.
Bij post-scripts (tussen %post %end):

	#deze code werd aangepast, zie volgende square
	sudo dnf install nano vim wget curl net-tools lsof bash-completion
	sudo dnf update

Om de scripts te testen, heb ik bij virtualbox de eerste adapter  een Nat adapter gemaakt en de 2e een internal network.
Getest: tijdens installatie in de shell successvol 8.8.8.8 kunnen pingen.

Opmerking: bij storage-log krijg ik vaak de melding: "Failed to reset SElinux context for ... -> later kan dit beter bekeken worden

De installatie duurde zeer lang / bleef haperen.
Oplossing :

	sudo dnf -y install nano vim wget curl net-tools lsof bash-completion
	#sudo dnf update

Geven de yes optie mee aan dnf installe en zetten voorlopig de update in commentaar tijdens de testfase.

Getest: 

* Inloggen met de gebruiker admin was succesvol. (+ group gecheckt met "vim /etc/group")
* "vim" en "ifconfig" werken, dus de packages zijn succesvol geïnstalleerd.

### 4.2 configuratie Configuration management system

Als CMS koos ik voor SaltStack, omdat deze met Python en yaml werkt en deze is alsook ontworpen als CLI based tool is (we hebben geen desktop environement op de servers + installatie is minder zwaar / lang zonder gui).

De scripts voor SaltStack komen bij de post-installatiescripts (tussen %post %end).:

	sudo dnf -y install epel-release
	sudo dnf -y install python3-pip
	#sudo pip3 install --upgrade pip	#???
	#pip install --upgrade setuptools
	sudo  pip3 install salt

sinds CentOS 8 is enkel "pip" niet voldoende, er moet specifiek gegaan worden voor pip2 of pip3

TODO: bekijken en aanpassen /etc/salt/minion
Hierin moet de ip van de "master" correct ingesteld staan alsook de "id" (naam vd minion)

verander master-ip

	sed -i -e 's/[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}/172.16.1.254/g' /etc/salt/minion

random stuk tekst:
head /dev/urandom | tr -dc A-Za-z0-9 | head -c10

neem mac-address:
cat /sys/class/net/enp0s3/address

```
sed '/etc/salt/minion'
```

#### Salt master

Zorg dat je werkt met het ip address ingesteld in /etc/salt/minion 

	sudo dnf install epel-release
	sudo dnf install python-pip
	pip install salt

run debug mode in een andere terminal

	salt-master -l debug 
Voeg key van minion toe

	salt-key -L	# list all keys and look for unacceted keys
	salt-key -a "naamvandeminion"	#accept that salt key

Testmogelijkheden (met '*' selecteer je alle minions)

	#ping fuction in de test module: ping de minion
	salt '*' test.ping
	#run een commando:
	salt '*' cmd.run 'pwd'
	#statische informatie over de minion
	salt 'minionnaam' grains.items

### SaltStack probleem, probeer puppet cms

voor server:

```
# dnf install https://yum.puppetlabs.com/puppet-release-el-8.noarch.rpm
# dnf install puppetserver
# puppet resource package puppetserver ensure=latest
# systemctl start puppetserver
# systemctl enable puppetserver

```

client

	# dnf install puppet
	# puppet resource package puppet ensure=latest
	# systemctl start puppet
	# systemctl enable puppet

Test puppet:



### 4.3 scripts om opgenomen te worden door monitoring



sources:

* https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/installation_guide/sect-kickstart-syntax#sect-kickstart-packages
* https://linuxconfig.org/how-to-install-puppet-on-redhat-8