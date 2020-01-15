# Research

Dit document beschrijft alle resources die nuttig zijn voor server Delta1.

## Links

- [Postfix antispam+virus](https://www.tecmint.com/integrate-clamav-and-spamassassin-to-protect-postfix-mails-from-viruses/)
- [Clam AV](https://www.linux.com/tutorials/using-clamav-kill-viruses-postfix/)
- [SELinux booleans](https://www.thegeekdiary.com/understanding-selinux-booleans/)
- [configure mailserver](https://xdeb.org/post/2018/02/07/run-your-own-mail-server-with-postfix-and-dovecot/)
- [Setup E-mail Server Centos](https://hostpresto.com/community/tutorials/how-to-setup-an-email-server-on-centos7/)
- [Postfix hardening](https://linux-audit.com/postfix-hardening-guide-for-security-and-privacy/)
- [Postfix with LDAP](http://www.postfix.org/LDAP_README.html)
- [Postfix with LDAP Backend Guide (Proberen)](https://www.dev-eth0.de/2016/12/19/postfix_ldap/?fbclid=IwAR3uWCGukmQ-JHyEr2bflWnhiSBOi8CdTjUVK6NWVW5zyZOzkfhTpAbehfU)

## Ansible roles

- Mailserver (postfix, dovecot): [bertvv.mailserver](https://galaxy.ansible.com/bertvv/mailserver)
- Squirrelmail: [bertvv.squirrelmail](https://galaxy.ansible.com/bertvv/squirrelmail)
- Clam AV: [jtyr.clamav](https://galaxy.ansible.com/jtyr/clamav)
- OpenLDAP-client

## Commands
s
| Commando                     | Uitvoering                                   |
| :----------------------------| :--------------------------------------------|
| `journalctl -f`              | laatste logberichten volgen                  |
| `setsebool [boolean] on|off` | zet selinux boolean aan of af                |
| `getsebool [boolean]`        | geeft aan of de selinux boolean aanstaat     |
| `./scripts/dependencies.sh ./ansible/servers.yml`| Ophalen van Ansible roles|


## Testen

Om te testen met gebruikers die lokaal zijn aangemaakt moet er in `/etc/postfix/master.cf` de lijn `-o smtpd_client_restrictions=permit_sasl_authenticated,reject` in commentaar gezet worden. Dit moet zo omdat lokale gebruikers anders geen toegang wordt gegeven om mails te versturen/ontvangen. 

Na dit aangepast te hebben moet `Postfix` vervolgens gereload worden door middel van het commando `sudo postfix reload`.

## Troubleshooting

### Squirrelmail: Recipient Address Rejected: Access denied

Zoals bij het testen hierboven, om er voor te zorgen dat de lokale gebruikers permissies hebben om mails te versturen en ontvangen moeten de twee lijnen in commentaar worden gezet. Als dit niet gebeurt hebben de gebruikers geen toegang en krijg je volgende error message:

![](https://github.com/HoGentTIN/p3ops-1920-green/blob/master/Documentatie/delta1/images/SquirrelmailRecipient.png)

### Versturen mail poort 25

Als er voor het versturen van mail gebruik gemaakt wordt van de standaard poort 25, dan lukt dit niet.

### Oplossing

Er moet gebruik gemaakt worden van de alternatieve poort 587.

### Verkeerde directory mail

Indien er in het configuratiescript `postfix_home_mailbox: /mail` staat, wordt er in plaats van een map `mail` een bestand aangemaakt. Dit zorgt er voor wanneer er mail wordt gestuurd naar een bepaalde gebruiker dat deze niet meer kan inloggen.

### Oplossing

Dit wordt opgelost door het pad correct mee te geven n.l. `postfix_home_mailbox: mail/`, dit zorgt er voor dat er effectief een directory mail wordt aangemaakt en dat gebruikers dus mail kunnen ontvangen.

### Alfa1 gebruikers om in te loggen

De gebruikers van alfa1 kunnen op onze server bekeken worden maar het lukt nog niet om hiermee op de webmail client in te loggen. Geeft voorlopig de foutmelding: 'password must be changed'.

### Connection dropped by IMAP server: Query: CAPABILITY

Deze error gebeurt wanneer er een gebruiker van Alfa1 wil inloggen maar de rechten niet heeft om de map mail aan te maken.

### Oplossing

De gebruiker moet eerst eens inloggen op de machine, dan worden de mappen meteen aangemaakt.

### Error 451: Temporary Lookup Failure

Deze error komt voor bij het versturen van een mail met een gebruiker sinds we de alfa1 gebruikers aan Delta1 hebben gekoppeld.

![](https://github.com/HoGentTIN/p3ops-1920-green/blob/master/Documentatie/delta1/images/Error451.png)

### Recipient address rejected: User unknown in local recipient table

https://serverfault.com/questions/179419/postfix-recipient-address-rejected-user-unknown-in-local-recipient-table

=> mail versturen naar bert@delta1.green.local werkt wel (gedeeltelijk, mail wordt nog altijd verworpen)

### Error: mail for delta1.green.local loops back to myself

https://talk.plesk.com/threads/solved-postfix-mail-for-domain-com-loops-back-to-myself.329459/
https://www.cyberciti.biz/faq/postfix-mail-for-domaincom-loops-back-to-myself-error-and-solution/

=> mail server staat niet aangekondigd in dns records

### Error: no file /etc/postfix/aliases.db

Reden: `aliases.db` staat in `/etc/`

Oplossing:
- `ln -s /etc/aliases.db /etc/postfix/aliases.db`

### Error: wrong user/password

Reden: delta1 maakt niet automatisch de home dir aan van een ldap-user

Oplossing:
- `vagrant ssh delta1 && sudo su [user]`
- OF `./scripts/delta1.sh`

### Mail verzenden lukt, mail ontvangen niet


Reden: ? geen errors, geen logs

### Error: postfix user unknown in virtual alias table

https://serverfault.com/questions/788967/postfix-user-unknown-in-virtual-alias-table

### Error: postfix: user unknown in local recipient table

https://serverfault.com/questions/846866/postfix-user-unknown-in-local-recipient-table-only-with-the-main-domain-hostna

http://www.postfix.org/STANDARD_CONFIGURATION_README.html