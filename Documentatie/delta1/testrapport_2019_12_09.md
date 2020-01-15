# Testrapport Delta1

Auteur: Beau Bellon

## Requirements
- Correct IP-adres
- Correcte default gateway
- Correcte firewall instellingen
- Users kunnen mail naar elkaar verzenden BINNEN het eigen domein
- Users kunnen mail van elkaar ontvangen BINNEN het eigen domein
- Users kunnen mail naar elkaar verzenden BUITEN het eigen domein
- Users kunnen mail van elkaar ontvangen BUITEN het eigen domein
- Users kunnen inloggen in het webportaal
- Users kunnen hun mailbox bekijken in een webbrowser

## Stappenplan

### Stap 1: Correct IP-adres

Run volgende commando's in terminal op de host:

```
$ bats /vagrant/test/delta1/delta1.bats
```

Alle tests slagen zoals hieronder wordt weergegeven:

```
[vagrant@delta1 ~]$ bats /vagrant/test/delta1/delta1.bats
 ✓ Correct IP address
 ✓ Correct nameserver 1
 ✓ Correct nameserver 2
 ✓ Firewall is running
 ✓ Service 'https' allowed through firewall
 ✓ Service 'imaps' allowed through firewall
 ✓ Service 'smtps' allowed through firewall
 ✓ Service 'smtp-submission' allowed through firewall
 ✓ Service 'ldap' allowed through firewall

9 tests, 0 failures
```
### Stap 2: Correcte default gateway

De output bovenaan toont dat de default gateway correct is ingesteld

### Stap 3: Correcte firewall instellingen

De output bovenaan toont dat de firewall instellingen correct zijn

### Stap 4: Inloggen webportaal en mailbox bekijken in webbrowser

Open browser op url http://172.16.1.68/webmail

Log in met gegevens:

```
Name: johndoe
Password: test123
```

Klik op "INBOX" in de linkerkolom

De schermafbeelding hieronder toont dat dit succesvol is:

![](https://github.com/HoGentTIN/p3ops-1920-green/blob/master/Documentatie/delta1/images/InloggenWebmail.png)

![](https://github.com/HoGentTIN/p3ops-1920-green/blob/master/Documentatie/delta1/images/MailboxTest.png)

### Stap 5: Mail verzenden BINNEN domein

Klik op "Compose" bovenaan de webpagina en voer volgende gegevens in

```
To: ericdoe@green.local
Subject: test
```

en in het tekstveld:

```
Testmail van johndoe@green.local
```

Klik op "Send" in de linkerkolom.

![](https://github.com/HoGentTIN/p3ops-1920-green/blob/master/Documentatie/delta1/images/MailVerzenden.png)

### Stap 6: Mail verzenden BUITEN domein

Klik op "Compose" bovenaan de webpagina en voer volgende gegevens in

```
To: ericdoe@red.local
Subject: anytesttexthere
```

en in het tekstveld:

```
Testtext in textarea from johndoe@green.local
```

Klik op "Sent" in de linkerkolom. Hier zou de mail moeten terechtkomen.

Deze test kan pas uitgevoerd worden in samenwerking met Windows-kant van het project.

### Stap 7: Mail ontvangen BINNEN domein

Klik op "Sign Out" rechts bovenaan de webpagina. Log weer in met volgende gegevens:

```
Name: ericdoe
Password: test123
```

In de inbox zien we nu dat er een ongelezen mail is van ericdoe@green.local:


Als we vervolgens op het onderwerp van de mail klikken zien we dit allemaal correct is:

![](https://github.com/HoGentTIN/p3ops-1920-green/blob/master/Documentatie/delta1/images/MailOntvangenInbox.png)


![](https://github.com/HoGentTIN/p3ops-1920-green/blob/master/Documentatie/delta1/images/MailOntvangenMail.png)

### Stap 8: Mail ontvangen BUITEN domein

Deze test kan pas uitgevoerd worden in samenwerking met Windows-kant van het project.