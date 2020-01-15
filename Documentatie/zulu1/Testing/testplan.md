# Testplan setup en configuratie Zulu1
## Setup
1. Op het hostsysteem, ga naar de locale directory van het project repo.
2. Voer het commando `vagrant up Zulu1` uit.
3. Eens machine up to running is controleer volgende interfaces:
  * WAN : 192.168.1.106/30
  * LAN: 192.168.1.102/29
4. Deze interfaces zijn statisch ingegeven.

## Configuratie

Om het testplan verder uit te werken, moet je verbinding maken met het interne netwerk. Meer informatie over hoe je dit moet doen, vind je in de documentatie.

1. Controleer of de hostname Zulu1 is.
2. Zulu1 moet zich bevinden in het domein green.local.
3. Vervolgens mag het admin account het default wachtwoord niet meer bevatten.
4. Check of het systeem up to date is, dit zou het geval moeten zijn.
5. Als volgende stap controleer je of de SNMP Daemon service enabled is.
6. Er zouden 3 Firewall aliases aanwezig moeten zijn, genaamd:
    * HTTPandHTTPS, met volgende settings:
        >* Type: Port(s)
        >* Port: 80 (HTTP)
        >* Port: 443 (HTTP/S)
    * IMAPandIMAPS
        >* Type: Port(s)
        >* Port: 143 (IMAP)
        >* Port: 993 (IMAP/S)
    * POandPOPS
       >* Type: Port(s)
       >* Port: 110 (POP3)
       >* Port: 995 (POP/S)
7. Volgende firewall rules zijn aanwezig:
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

  7.2 Voor LAN, mag je de standaard rules laten staan, controleer of deze aanwezig zijn:
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

 8. Op firewall Zulu1, zou DHCP relay enabled moeten zijn. Dit bevat het ip adres van de DHCP server.
 9. DHCP server service is disabled.
 10. Vervolgens staat ipv6 ook gedisabled, samen met de DNS Resolver.
 11. Controleer of user1 aanwezig is, met volgende settings:
    *wachtwoord: Zulu1User1.*
    *De user bevindt zich in de groep users en niet in de groep admins.*
 12. Group users heeft volgende privileges:
      >*WebCfg - Diagnostics: Backup & Restore Allow access to the 'Diagnostics: Backup & Restore' page. (admin privilege)
      >*WebCfg - Diagnostics: CPU Utilization Allow access to the 'Diagnostics: CPU Utilization' page.  
      >*WebCfg - Diagnostics: pf Table IP addresses Allow access to the 'Diagnostics: Tables' page.
      >*WebCfg - Diagnostics: Ping  Allow access to the 'Diagnostics: Ping' page.
      >*WebCfg - Diagnostics: Reboot System Allow access to the 'Diagnostics: Reboot System' page.  
      >*WebCfg - Diagnostics: Show States Allow access to the 'Diagnostics: Show States' page.  
      >*WebCfg - Services: Load Balancer: Monitors  Allow access to the 'Services: Load Balancer: Monitors' page.
      >*WebCfg - Services: SNMP Allow access to the 'Services: SNMP' page.  
      >*WebCfg - Status: Logs: DHCP Allow access to the 'Status: Logs: DHCP' page.  
      >*WebCfg - Status: Logs: Firewall Allow access to the 'Status: Logs: Firewall' page.  
      >*WebCfg - Status: Logs: Gateways Allow access to the 'Status: Logs: System: Gateways' page.  
      >*WebCfg - Status: Logs: Resolver Allow access to the 'Status: Logs: System: Resolver' page.  
      >*WebCfg - Status: Monitoring Allow access to monitoring status page  
      >*WebCfg - Status: System Logs: Firewall (Dynamic View) Allow access to the 'Status: System Logs: Firewall (Dynamic View)' page
      >*WebCfg - Status: System Logs: Firewall Log Summary  Allow access to the 'Status: System Logs: Firewall Log Summary' page  
      >*WebCfg - Status: System Logs: IPsec VPN Allow access to the 'Status: System Logs: IPsec VPN' page.  
      >*WebCfg - Status: System Logs: IPsec VPN Allow access to the 'Status: System Logs: IPsec VPN' page.  
      >*WebCfg - Status: System Logs: Load Balancer Allow access to the 'Status: System Logs: Load Balancer' page.  
      >*WebCfg - Status: System Logs: NTP Allow access to the 'Status: System Logs: NTP' page.  
      >*WebCfg - Status: System Logs: OpenVPN Allow access to the 'Status: System Logs: OpenVPN' page.  
      >*WebCfg - Status: System Logs: Portal Auth Allow access to the 'Status: System Logs: Portal Auth' page.  
      >*WebCfg - Status: System Logs: Routing Allow access to the 'Status: System Logs: System: Routing' page.  
      >*WebCfg - Status: System Logs: Wireless  Allow access to the 'Status: System Logs: System: Wireless' page.
      >*WebCfg - System: Static Routes  Allow access to the 'System: Static Routes' page.*

13. Vervolgens controleer je de status van NAT, deze zou disabled moeten zijn.
14. Verifeer indien 2 gateway's zijn ingesteld met volgende eigenschappen:
      * Een internal gateway met:
          * Disabled: Unchecked
          * Interface: LAN
          * Address Family: IPV4
          * Name: internal_gateway
          * Gateway: 172.16.1.101
      * Een external gateway met:
          * Disabled: Unchecked
          * Interface: WAN
          * Address Family: IPV4
          * Name: internal_gateway
          * Gateway: 172.16.1.105
15. Als laatste controleer je of 4 statische routes aanwezig zijn met volgende eigenschappen:
    * Route 1
        * Destination network: 172.16.0.0/24
        * Gateway: internal_gateway - 172.16.1.101
        * Disabled: Unchecked
    * Route 2
        * Destination network: 172.16.1.0/26
        * Gateway: internal_gateway - 172.16.1.101
        * Disabled: Unchecked
    * Route 3
        * Destination network: 172.16.1.64/27
        * Gateway: internal_gateway - 172.16.1.101
        * Disabled: Unchecked
    * Route 4
        * Destination network: 172.16.1.96/30
        * Gateway: internal_gateway - 172.16.1.101
        * Disabled: Unchecked

#### Ping
16. Controleer van een client indien je kunt pingen naar:
    * het LAN interface
    * het WAN interface
    * Een interface achter de WAN interface
