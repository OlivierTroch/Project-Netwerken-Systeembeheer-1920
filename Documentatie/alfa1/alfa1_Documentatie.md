# Alfa1 documentatie
## Alfa1 assignment
  
Een domeinserver voor green.local voor gecentraliseerd beheer van gebruikers. Er zijn twee mogelijke pistes om dit te realiseren. Enerzijds via een LDAP-server (OpenLDAP, 389 Directory Server), anderzijds via een Linux-versie van de Active Directory Domain Controller (Samba 4). De verantwoordelijke kiest zelf welk platform gebruikt wordt.

Client-pc’s hebben geen eigen gebruikers, authenticatie gebeurt telkens via de domeinserver.

Maak onderstaande afdelingen (groepen) aan.

* IT Administratie
* Verkoop
* Administratie
* Ontwikkeling
* Directie

Maak een duidelijk verschil tussen gebruikers, computers en groepen. Voeg enkele gebruikers en minstens 5 werkstations toe (één in IT-Administratie, één in Ontwikkeling, één in Verkoop, één in Administratie en één in Directie).
 
## Vooraf

Voor het gecentraliseerd beheer van de gebruikers kiezen we voor [OpenLDAP](https://www.openldap.org/). Concreet staat deze server in voor de authenticatie van de users. Servers zoals Lima1 (directoryserver) en Delta1 (mailserver) hebben de gebruikers uit onze server nodig om op die manier de user enkel toegang te verlenen tot de bestanden en directories waarvoor hij permissies heeft.
Om dit te bereiken schrijven we dus een server-rol voor Alfa1, maar ook een client-rol voor Lima1 en Delta1. 

## De LDAP-server: Alfa1

We baseren ons op de rollen van [net2grid](https://github.com/net2grid) voor de configuratie van de OpenLDAP service. 
Deze rollen zijn echter verouderd en werken niet meer, daarom gaan we dus task voor task kijken waar de problemen zitten.

### Installatie en configuratie

#### openldap-server

Ons playbook doorloopt eerst en vooral de openldap-server rol, die ervoor zorgt dat de service correct geinstalleerd wordt.
Afhankelijk van de Linux distributie, downloaden en installeren we verschillende packages. Wij gebruiken een Redhat versie, en downloaden dus de nodige packages voor een LDAP-server op Redhat.
In de files map van de openldap-server rol vinden we de slapd en ldap files. Hier voeren we een kleine wijziging door om ervoor te zorgen dat de server te bereiken is via de juiste URI. Concreet zorgen we er dus voor dat SLAPD_LDAPI de waarde is die gebruikt wordt.
```
#...\ansible\roles\openldap-server\files

# Run slapd with -h "... ldapi:/// ..."
#   yes/no, default: yes
SLAPD_LDAPI=yes
```
Verder doorloopt het playbook deze rol probleemloos.

#### openldap-config

Bij openldap-config beginnen de problemen. De manier waarop users worden toegevoegd aan de server, alsook de manier waarop users bereikbaar zijn vanop de client is veranderd. Daarom moeten we redelijk wat aanpassingen maken aan de rol om deze aan de praat te krijgen.

De relevante hostvariabelen voor onze opstelling zijn de volgende, te vinden in hosts/alfa1.yml.
```
#ldap-config configuration
default_user_password: letmein

openldap_create_organizationalunits:
  - Afdelingen

openldap_create_groups:
  - name: IT_Administratie
    gid: 1001
    memberuid: 
      - bert
      - milan
    group_ou: ou=Afdelingen
  - name: Verkoop
    gid: 1002
    group_ou: ou=Afdelingen
  - name: Administratie
    gid: 1003
    group_ou: ou=Afdelingen
  - name: Ontwikkeling
    gid: 1004
    memberuid:
      - bert
    group_ou: ou=Afdelingen
  - name: Directie
    gid: 1005
    group_ou: ou=Afdelingen

openldap_create_users:
  - name: milan
    cn: Milan Dewilde
    sn: Dewilde
    password: milan
    email: dewilde.milan@hotmail.com
    group_ou: ou=Afdelingen
    uidNumber: 1501
  - name: bert
    cn: Bert Van Vreckem
    sn: Van Vreckem
    password: bert
    email: bert@green.local
    group_ou: ou=Afdelingen
    uidNumber: 1502

openldap_add_uniquemember:
  - name: milan
    member_dn: uid=milan,ou=Afdelingen
    group_dn: cn=default-users,ou=Afdelingen
```
In dit bestand worden 2 users en de 5 gevraagde afdelingen voor ons domein gedefinieerd, alsook de users die aan deze groepen moeten worden toegevoegd. Deze groepen worden gebruikt door de directoryserver om permissies te bepalen per user.
De templates die gebruikt worden om deze items toe te voegen, zijn verouderd. 
We bekijken per template de foutmeldingen, te beginnen met groups.ldif.j2, het template om groepen aan de ldap-server toe te voegen.
De up-to-date versie van dit bestand dient er zo uit te zien:
```
# Groups
dn: cn={{ item.name }},{{ item.group_ou }},dc={{ openldap_server_domain_name.split('.')[0] }},dc={{ openldap_server_domain_name.split('.')[1] }}
objectClass: posixgroup
objectClass: top
cn: {{ item.name }}
{% if item.memberuid is defined %}
{% for group_name in item.memberuid %}
memberuid: {{group_name}}
{% endfor %}
{% endif %}
gidNumber: {{ item.gid }}
description: {{ item.name|capitalize }}
```
We zorgen ervoor dat de groepen worden toegevoegd als **posixgroup** zodat ze bereikbaar zijn voor rechtstreekse authenticatie vanop de clientsystemen.
Ook zorgt een kort scriptje in deze .ldif ervoor dat meerdere users kunnen worden toegevoegd aan eenzelfde group, wat voordien niet mogelijk was.
Een eigenschap van de **posixgroup** is dat ze verplicht een gidNumber krijgen, anders krijgen we hier een foutmelding.

Vervolgens bekijken we de template voor users, users.ldif.j2.
```
# Define a person here
dn: uid={{ item.name }},{{ item.group_ou }},dc={{ openldap_server_domain_name.split('.')[0] }},dc={{ openldap_server_domain_name.split('.')[1] }}
objectClass: top
objectClass: person
objectClass: posixAccount
objectClass: shadowAccount
cn: {{ item.cn }}
sn: {{ item.sn }}
uid: {{ item.name }}
userPassword: {{ item.password }}
gidNumber: 100
uidNumber: {{ item.uidNumber }}
homeDirectory: /home/{{ item.name }}
loginShell: /bin/bash
gecos: {{ item.name }}
shadowLastChange: 12
shadowMax: 10000000
shadowWarning: 0
```
In dit bestand zorgen we ervoor dat de user als objectClass een posixAccount en een shadowAccount meekrijgt. Dit is opnieuw om ervoor te zorgen dat de users rechtstreeks te bereiken zijn vanop de clientsystemen.
Een posixAccount krijgt verplicht een homedirectory mee, in dit geval dus gewoon met de naam van de user. 
Een shadowAccount zorgt ervoor dat de user een wachtwoord krijgt, maar door een onvolledigheid in het OpenLDAP systeem kan er niet voor worden gezorgd dat de user zijn wachtwoord na een eerste keer inloggen **niet** moet wijzigen. 
Omdat de mailserver ons gevraagd heeft om er toch voor te zorgen dat dit wachtwoord enkel te wijzigen is vanop de LDAP-server, voorzien we de workaround door de maximale leeftijd van een shadow een zodanig hoge waarde toe te kennen, dat deze niet te bereiken is.

#### openldap-client

Deze rol schrijven we zelf om ervoor te zorgen dat een server **van bij de uitvoering van het playbook** als ldap-client wordt geconfigureerd. 
Dit zorgt ervoor dat ldap-authenticatie vanaf de eerste login op een van de clients mogelijk is, zolang alfa1 daarvoor al online werd gebracht.

Concreet doet deze rol slechts 2 dingen: 
Eerst en vooral downloaden en installeren we de OS-specifieke packages die ervoor zorgen dat de openldap-commands gekend zijn vanop de client.
Ten tweede zorgen we ervoor dat authenticatie kan verlopen via onze server. Hiervoor specifieren we het ip-adres van de LDAP-server en ook het domein, zijnde 'green.local'
```
---
- name: Use LDAP
  shell: authconfig --enableldap --enableldapauth --ldapserver={{ openldap_server_address }} --ldapbasedn="dc={{ openldap_server_domain_name.split('.')[0] }},dc={{ openldap_server_domain_name.split('.')[1] }}" --enablemkhomedir --updateall

```

### Inloggen op de LDAP-server: Alfa1

Via ssh is Alfa1 te bereiken met user vagrant. 
Als we inloggen kunnen we eenvoudig nagaan of de slapd.service runt met commando `systemctl status slapd`, iets wat we beter bij elke nieuwe installatie eerst en vooral proberen. 
Daarna is het ook handig om te kijken of alle LDAP-entries aangemaakt zijn met commando `ldapsearch -x -LLL`.
Het is normaal dat de users en groepen uit de LDAP-server niet beschikbaar zijn als posixUser en posixGroup op Alfa1 zelf, gezien we deze authenticatie niet hebben aangezet voor Alfa1, dit is ook niet nodig. 

### Inloggen op de LDAP-clients: Lima1 en Delta1

Na het doorlopen van het playbook zien we dat onze rol probleemloos is geinstalleerd op beide clients.
We verifieren de connectie met de LDAP-server door commando `ldapsearch -x -LLL` op de client uit te voeren.
Vervolgens kunnen we eenvoudig nagaan of de users en groepen bereikbaar zijn op het systeem zelf door commandos `getent group` en `getent passwd` uit te voeren.
Bij de output zien we duidelijk onze users terug:
```
[vagrant@lima1 ~]$ getent passwd
...
...
...
milan:x:1501:100:milan:/home/milan:/bin/bash
bert:x:1502:100:bert:/home/bert:/bin/bash
```

en onze groepen:
```
[vagrant@lima1 ~]$ getent group
...
...
...
IT_Administratie:*:1001:bert,milan
Verkoop:*:1002:
Administratie:*:1003:
Ontwikkeling:*:1004:bert
Directie:*:1005:
```

Tenslotte is het nuttig om te testen of we kunnen inloggen als een van de users uit de ldap server, dit kan met commando `su milan` of `su bert`.