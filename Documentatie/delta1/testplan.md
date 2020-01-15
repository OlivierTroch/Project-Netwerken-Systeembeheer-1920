# Testplan Delta1

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

1. Correct ip-adres

Run volgende commando's in terminal op de host

```
$ bats /vagrant/test/delta1/delta1.bats
```

2. Correcte default gateway

Wordt nagekeken in bovenstaande bats test.

3. Correcte firewall instellingen

Worden nagekeken in bovenstaande bats test.

4. Inloggen webportaal en mailbox bekijken in webbrowser

Open browser op url http://172.16.1.68/webmail

Log in met gegevens:

```
Name: johndoe
Password: test123
```

Klik op "INBOX" in de linkerkolom

5. Mail verzenden BINNEN domein

Klik op "Compose" bovenaan de webpagina en voer volgende gegevens in

```
To: ericdoe@green.local
Subject: anytesttexthere
```

en in het tekstveld:

```
Testtext in textarea from johndoe@green.local
```

Klik op "Sent" in de linkerkolom. Hier zou de mail moeten terechtkomen.

6. Mail verzenden BUITEN domein

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

7. Mail ontvangen BINNEN domein

Klik op "Sign Out" rechts bovenaan de webpagina. Log weer in met volgende gegevens:

```
Name: ericdoe
Password: test123
```

Hier zou de mail van "johndoe@green.local" moeten terechtkomen.

8. Mail ontvangen BUITEN domein

Deze test kan pas uitgevoerd worden in samenwerking met Windows-kant van het project.