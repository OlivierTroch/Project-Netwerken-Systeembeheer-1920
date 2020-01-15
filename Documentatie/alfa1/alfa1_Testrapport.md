# Alfa1 testrapport

### *Vooraf:* 

- Alfa1 en lima1 zijn gedestroyed met `vagrant destroy alfa1 lima1`
  - [ ] alfa1 en lima1 zijn niet actief (destroy)
- Alfa1 is geprovisioned met `vagrant up alfa1` en doorloopt succesvol het playbook.
  - [ ] alfa1 is correct geprovisioned, er zijn geen errors
- lima1 is geprovisioned met `vagrant up lima1` en doorloopt succesvol het playbook.
  - [ ] lima1 is correct geprovisioned, er zijn geen errors

### Testen alfa1

- Maak een SSH-verbinding met `vagrant ssh alfa1`

  - [ ] SSH-verbinding met alfa1 is succesvol

- Controleer of de LDAP service runt met `systemctl status slapd`

  - [ ] Status is `active (running)` 

- Maak een LDIF aan voor de testuser

  ```
  cat << EOF > testuser.ldif
  dn: uid=testuser,dc=green,dc=local
  objectClass: top
  objectClass: person
  objectClass: posixAccount
  objectClass: shadowAccount
  cn: testuser
  sn: testuser
  uid: testuser
  userPassword: test123
  gidNumber: 100
  uidNumber: 1234
  homeDirectory: /home/testuser
  loginShell: /bin/bash
  gecos: testuser
  shadowLastChange: 12
  shadowMax: 10000000
  shadowWarning: 0
  EOF
  ```

- Voeg de testuser toe aan LDAP met `ldapadd -h localhost -x -D "cn=Manager,dc=green,dc=local" -w letmein -f testuser.ldif`

  - [ ] user is toegevoegd aan LDAP zonder error

- Verifieer dat de LDAP server bereikbaar is met `ldapsearch -x -LLL`

  - [ ] Alle entries zijn zichtbaar inclusief de nieuwe testuser

### Testen op client (lima1)

- Maak een SSH-verbinding met `vagrant ssh lima1`
  - [ ] SSH-verbinding met lima1 is succesvol
- Probeer de LDAP server te bereiken met `ldapsearch -x -LLL`
  - [ ] Alle entries zijn zichtbaar inclusief de nieuwe testuser
- Controleer dat alle gebruikers gekend zijn op het systeem met `getent passwd`
  - [ ] De gebruikers `milan, bert, testuser` zijn gekend
- Controleer dat je kan inloggen als LDAP user met `su testuser`
  - [ ] Er kan ingelogd worden met de user testuser
- Controleer dat alle groepen gekend zijn met `getent group`
  - [ ] De groepen `IT_Administratie, Verkoop, Administratie, Ontwikkeling, Directie` zijn gekend

### Opmerkingen/problemen

Schrijf hier problemen of opmerkingen die je bent tegengekomen tijdens het testen van de server.

