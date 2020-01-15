# Testplan setup en configuratie Zulu1 
## Setup 
1. Na het uitvoeren van 'Vagrant up Zulu1' controleerde ik de WAN en LAN, deze waren beiden in orde.

## Configuratie

Ik heb een extra host aangemaakt om zo via een intern netwerk de server te bereiken en volgende instellingen te controleren. De nummers komen overreen met degene uit het testplan.

1. OK, de hostname is Zulu1.  
2. OK, Zulu1 bevindt zich in het juiste domein.   
3. OK, het standaard wachtwoord is veranderd.  
4. OK, via de navigatiebalk, klikken op 'System' en dan op update. Dit was up to date.  
5. OK, deze zijn enabled.
6. OK, de 3 volgende firewall aliassen zijn aanwezig. 
    * HTTPandHTTPS, met volgende settings:
        >* Type: Port(s)
        >* Port: 80 (HTTP)
        >* Port: 443 (HTTP/S)
    * IMAPandIMAPS
        >* Type: Port(s)
        >* Port: 143 (IMAP)
        >* Port: 993 (IMAP/S)
    * POPandPOPS
       >* Type: Port(s)
       >* Port: 110 (POP3)
       >* Port: 995 (POP/S)
7. OK, volgende firewall rules zijn aanwezig. 
    7.1 Voor WAN zou je volgende rules moeten hebben: 
      * Rule 1: webserver(Echo1).
        >* Action: Pass
        >* Interface: WAN
        >* Address Family: IPV4
        >* Protocol: TCP
        >* Source: ANY
        >* Destination: Single host or alias (172.16.1.69)
        >* Destination Port Range: 
            >* other - custom (HTTP_HTTPS)
     * Rule 2: mailserver SMTP.

        >* Action: Pass
        >* Interface: WAN
        >* Source: ANY
        >* Destination: Single host or alias (172.16.1.68)
        >* Destination Port Range
            >* SMTP(465) to SMTP(465)

    * Rule 3: mailserver IMAP.

        >* Action: Pass
        >* Interface: WAN
        >* Source: ANY
        >* Destination: Single host or alias (172.16.1.68)
        >* Destination Port Range: 
           > * other - custom (IMAP_IMAPS)

   * Rule 4: mailserver POP.
        >* Action: Pass
        >* Interface: WAN
        >* Source: ANY
        >* Destination: Single host or alias (172.16.1.68)
        >* Destination Port Range: 
            >* other - custom (POP3_POP/S)
            
  7.2 OK, de standaard rules zijn aanwezig.   
   * Rule 1: IPV4
        >* Action: Pass
        >* Interface: LAN
        >* Source: LAN net
        >* Destination: any

   * Rule 2: IPV6
        >* Action: Pass
        >* Interface: LAN
        >* Source: LAN net
        >* Destination: any
   * Rule 3: Antilock-rule
        >* Destination Port Range
        >* port 80 en 443

 8. OK, DHCP Relay is enabled met het juiste ip adres.   
 9. OK, DHCP server service is disabled. 
 10. OK, ipv6 is disabled. Alsook de DNS Resolver.
 11. OK, user1 is aanwezig met de volgende settings:   
    *wachtwoord: Zulu1User1.
    *De user bevindt zich in de groep users en niet in de groep admins.
 12. OK, group users hebben volgende priviledges(zie testplan.md).
 13. OK, NAT is disabled. 
