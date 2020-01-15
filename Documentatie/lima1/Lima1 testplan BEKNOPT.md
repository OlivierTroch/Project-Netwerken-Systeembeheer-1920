# Testplan Lima1

Author: [Jonas Spitaels](https://github.com/JonasSpitaels) & [Berkant Kücüksolak](https://github.com/BerkantKs)





# Bijkomende informatie (NIET NODIG)

Om de Lima1 fileserver op te zetten dienen de rollen rhbase (bertvv.rh-base), samba (bertvv.samba) en client voor openldap (openldap-client) geïnstalleerd te worden. Hieronder zijn een onderdeel 'Lokaal' en een onderdeel 'Met integratie' aangemaakt. 'Lokaal' betekent dat de system users en groups zelf worden aangemaakt in Lima1, en dat daarvan dus samba users en shares worden gemaakt. 'Met integratie' wil zeggen dat we de system groepen en users van Alfa1 krijgen, en dat wij hiervan dan samba users en shares kunnen maken. Aangezien de integratie sinds kort naar behoren werkt, kan lima1 met deze code worden opgesteld.




# NODIGE INFO

Om Lima1 met de alfa1 open-ldap integratie te testen, moet de code onder 'Met integratie' (dus NIET de code onder 'LOKAAL') in het 'Lima1.yml' bestand komen. Eens Alfa1 is opgestart, doe je daarna 'vagrant up lima1' en daarna, indien gewenst, 'vagrant provision lima1'. Tenslotte doe je 'vagrant ssh lima1'. Vervolgens controleer je a.d.h.v. de testcode bij het onderdeel 'Testcode' of de fileserver naar behoren werkt.




## Lokaal




#--firewall-----------------------------#
rhbase_firewall_allow_services:
  - samba
#-------------------------------#

rhbase_user_groups:
  - IT_Administratie
  - Verkoop
  - Administratie
  - Ontwikkeling
  - Directie 

samba_load_homes: true

#--users-----------------------------#
rhbase_users: 
  - name: Robert
    comment: 'Robert'
    password: 'abc123!'
    groups: 
      - IT_Administratie
      - Verkoop
      - Administratie
      - Ontwikkeling
      - Directie
  - name: Els
    comment: 'Els'
    password: 'cba321!'
    groups: 
      - IT_Administratie
      - Verkoop
      - Administratie
      - Ontwikkeling
      - Directie
  - name: Thomas
    comment: 'Thomas'
    password: 'def123!'
    groups: 
      - Directie
  - name: Noah
    comment: 'Noah'
    password: 'fed321!'
    groups: 
      - Directie
  - name: Emma
    comment: 'Emma'
    password: 'ghi123!'
    groups: 
      - Verkoop
  - name: Louise
    comment: 'Louise'
    password: 'ihg321!'
    groups: 
      - Verkoop
      - Administratie
  - name: Marie
    comment: 'Marie'
    password: 'jkl123!'
    groups: 
      - Ontwikkeling
  - name: Lucas
    comment: 'Lucas'
    password: 'ljk321!'
    groups: 
      - Ontwikkeling
      - IT_Administratie
  - name: Viktor
    comment: 'Viktor'
    password: 'mno123!'
    groups: 
      - IT_Administratie
  - name: Sarah
    comment: 'Sarah'
    password: 'onm321!'
    groups: 
      - IT_Administratie
      - Verkoop
  - name: Jade
    comment: 'jade'
    password: 'pqr123!'
    groups: 
      - Administratie
  - name: Lars
    comment: 'Lars'
    password: 'rqp321!'
    groups: 
      - IT_Administratie
      - Administratie
     


samba_users:
  - name: Robert
    password: abc123!
  - name: Els
    password: cba321!
  - name: Thomas
    password: def123!
  - name: Noah
    password: fed321!
  - name: Emma
    password: ghi123!
  - name: Louise
    password: ihg321!
  - name: Marie
    password: jkl123!
  - name: Lucas
    password: ljk321!
  - name: Viktor
    password: mno123!
  - name: Sarah
    password: onm321!
  - name: Jade
    password: pqr123!
  - name: Lars
    password: rqp321!

samba_shares:
  - name: IT_Administratie
    group: IT_Administratie
    valid_users: +IT_Administratie
    write_list: +IT_Administratie
  - name: Verkoop
    group: Verkoop
    valid_users: +Verkoop
    write_list: +Verkoop
  - name: Administratie
    group: Administratie
    valid_users: +Administratie
    write_list: +Administratie
  - name: Ontwikkeling
    group: Ontwikkeling
    valid_users: +Ontwikkeling
    write_list: +Ontwikkeling
  - name: Directie
    group: Directie
    valid_users: +Directie
    write_list: +Directie





## Met integratie


rhbase_firewall_allow_services:
  - samba

samba_load_homes: true

samba_users:
  - name: milan
    password: milan
  - name: bert
    password: bert 

samba_shares:
  - name: IT_Administratie
    group: IT_Administratie
    valid_users: +IT_Administratie
    write_list: +IT_Administratie
  - name: Verkoop
    group: Verkoop
    valid_users: +Verkoop
    write_list: +Verkoop
  - name: Administratie
    group: Administratie
    valid_users: +Administratie
    write_list: +Administratie
  - name: Ontwikkeling
    group: Ontwikkeling
    valid_users: +Ontwikkeling
    write_list: +Ontwikkeling
  - name: Directie
    group: Directie
    valid_users: +Directie
    write_list: +Directie




## TESTCODE (4 tests)

1. Test of de samba shares aangemaakt en dus beschikbaar zijn

Geef het volgende commando in: smbclient -L //lima1/
Er wordt daarna een wachtwoord gevraagd. Voer het volgende wachtwoord in: vagrant
Nu krijg je een overzicht van alle 5 de shares te zien.


2.  Test of je met samba user 'bert' kan inloggen op de share 'Ontwikkeling' waar hij WEL toegangsrechten op heeft

Geef het volgende commando in: smbclient //lima1/Ontwikkeling/ -Ubert%bert
Je krijgt nu normaal deze prompt te zien: smb: \>
Dit wil zeggen dat je ingelogd bent op de 'Ontwikkeling' share.


3. Test of je met samba user 'bert' kan inloggen op de share 'Administratie' waar hij GEEN toegangsrechten op heeft

Geef het volgende commando in: smbclient //lima1/Administratie/ -Ubert%bert
Je krijgt nu normaal deze error output te zien: 'NT_STATUS_ACCESS_DENIED'
Dit wil zeggen dat je als bert niet kan inloggen op de Administratie share.


4.  Test of je op een share kan inloggen als een gast op de 'Administratie' share  (of 1 van de 4 andere shares)

Geef het volgende commando in: smbclient //lima1/Administratie -U%
Je krijgt nu normaal deze error output te zien: 'NT_STATUS_ACCESS_DENIED'
Dit wil zeggen dat je als gast niet kan inloggen op de Administratie share (of 1 van de 4 andere shares).


---