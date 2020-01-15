# Documentatie Kilo1 (DHCP-server)

- Student name: Lincy De Groote en Yordi De Rijcke
- Leren werken met:
  - DHCP servers
  - pools
  - statische IP-adressen
  - statische MAC-adressen
  - subnetting
  - vagrant
  - ansible
  - git

Kilo1 is een DHCP-server die gebruikt wordt om de werkstations een correcte ip-configuratie te geven. De IP-configuratie houdt het volgende in: IP-adres, netwerkmask, default gateway en DNS. De servers krijgen een statisch IP-adres via MAC-adres. Hosts doorverwijzen naar PXEBoot server die willen booten over het netwerk.

- VLAN 20 : interne clients om Private
  -  **Dynamische DHCP scope: 172.16.0.1 - 172.16.0.253** 
  -  Toegang tot de publieke servers van de andere domeinen.
- VLAN 30 : interne servers
  - **Fixed DHCP adressen voor interne servers**
  - **Dynamische DHCP scope: 172.16.1.10 - 172.16.1.61**
  - Enkel bereikbaar voor hosts van het eigen domein.
- VLAN 50 : publiek toegankelijke servers
  - **Fixed DHCP adressen voor interne servers**
  - **Dynamische DHCP scope: 172.16.1.80 - 172.16.1.93**
  - Bereikbaar voor interne clients én voor clients van andere domeinen.
  
## Cheat sheet

| Command                  | Uitleg                                                    |
| ------------------------ | --------------------------------------------------------- |
| vagrant up {NAAM}        | opstarten van server via vagrant                          |
| vagrant provision {NAAM} | provisioning server via vagrant                           |
| vagrant destroy {NAAM}   | afbreken server                                           |
| dhclient -v {interface}  | Ip adres opvragen via DHCP op de effectieve interface     |
| ip a                     | IP configuratie bekijken                                  |
| ip r                     | Route configuratie bekijken                               |
| cat /etc/resolv.conf     | DNS configuratie bekijken                                 |
| ping {address}           | connectie testen met hosts                                |
| traceroute {address}     | een lijst van tussenliggende routers naar zijn bestemming |
| ip r \| grep default     | default gateway                                           |
| cat /etc/dhcp/dhcpd.conf | DHCP configuratie bekijken                                |
| systemctl restart dhcpd  | restart DHCP                                              |

## Procedure/Documentation

- Ga naar de website: https://galaxy.ansible.com/bertvv/dhcp

  - Deze rol wordt gebruikt om de DHCP-server te configureren

- Ga naar het document *`servers.yml`* in de map `Ansible`

  - Voeg de role toe aan de server Kilo1

  - ```
    - name: kilo1
      become: true
      roles:
        - kilo1-dhcp	
    ```

- Ga naar het bestand *`kilo1.yml`* in de map `host_vars`

  - Voeg dit toe aan het document om de DHCP toe te laten in de firewall

    - ```
      rhbase_firewall_allow_services:
        - dhcp
      ```

  - Voeg dit toe  aan het document om de DNS servers toe te voegen aan je DHCP-systeem

    - ```
      dhcp_global_domain_name_servers:
        - 172.16.1.66
        - 172.16.1.67
      ```

  - Voeg een lease time toe (om de zoveel tijd een nieuw IP geven) (12uur)

    - ```
      dhcp_global_default_lease_time: 43200
      dhcp_global_max_lease_time: 43200
      ```

  - Voeg een global domain name toe

    - ```
      dhcp_global_domain_name: green.local
      ```

  - Voeg een PXEboot server toe

    - ```
      # PXEboot config
      dhcp_global_bootp: allow
      dhcp_global_booting: allow
      dhcp_global_next_server: 172.16.1.6  # papa1
      dhcp_global_filename: "centos/pxelinux.0"
      ```

  - Maak subnetten aan per VLAN

    - Per VLAN maak je een subnet aan met daarin een pool met een bepaalde range waarin de IP-adressen mogen vallen. De ranges worden bepaald via de IP-table.

    - Algemeen:

      - IP= netwerk-adres
      - netmask
      - routers = default gateway
      - pools: begin en eind-adres

    - `VLAN 20`: krijgt een range waaruit de dynamische adressen mogen uitgedeeld worden via dhcp

    - `VLAN 30 en 50`: krijgt een range waarin de statische IP-adressen worden gereserveerd via dhcp

    - ```
      dhcp_subnets:
          # VLAN 20
        - ip: 172.16.0.0
          netmask: 255.255.255.0
          routers: 172.16.0.254
          pools:
            - range_begin: 172.16.0.1
              range_end: 172.16.0.253

          # VLAN 30
        - ip: 172.16.1.0
          netmask: 255.255.255.192
          routers: 172.16.1.62
          pools:
            - range_begin: 172.16.1.10
              range_end: 172.16.1.61

          # VLAN 50
        - ip: 172.16.1.64
          netmask: 255.255.255.224
          routers: 172.16.1.94
          pools:
            - range_begin: 172.16.1.80
              range_end: 172.16.1.93
      ```
    - Geef elke host met een statisch IP een statische MAC adres mee en IP-adres
      - Begin met een random MAC-adres zoals bijvoorbeeld '08:00:27:66:5D:01', geef hieraan het bijhorende IP-adres bepaald door de IP-table. Voor de volgende server tel je 1 op bij het vorig MAC-adres en geef je opnieuw het bijhorend IP-adres bepaald door de IP-table. Doe zo verder tot dat je alle servers een statisch MAC-adres en IP-adres hebt gegeven.

      - ```
        # Fixed IP via MAC
        dhcp_hosts:
          - name: Alfa1
            mac: '08:00:27:66:5D:01'
            ip: 172.16.1.65
          - name: Bravo1
            mac: '08:00:27:66:5D:02'
            ip: 172.16.1.66
          - name: Charlie1
            mac: '08:00:27:66:5D:03'
            ip: 172.16.1.67
          - name: Delta1
            mac: '08:00:27:66:5D:04'
            ip: 172.16.1.68
          - name: Echo1
            mac: '08:00:27:66:5D:05'
            ip: 172.16.1.69
          - name: Lima1
            mac: '08:00:27:66:5D:06'
            ip: 172.16.1.2
          - name: Mike1
            mac: '08:00:27:66:5D:07'
            ip: 172.16.1.3
          - name: November1
            mac: '08:00:27:66:5D:08'
            ip: 172.16.1.4
          - name: Oscar1
            mac: '08:00:27:66:5D:09'
            ip: 172.16.1.5
          - name: Papa1
            mac: '08:00:27:66:5D:0A'
            ip: 172.16.1.6
        ```

        ​


## To Do

- [x] correcte ansible role vinden
- [x] ansible rol toevoegen
- [x] bestand aanmaken kilo.yml in juiste map (host_vars)
- [x] bestand kilo.yml configureren
  - [x] firewall
  - [x] DNS domainen toevoegen
  - [x] lease time
  - [x] global domain name
  - [x] subnets (per VLAN?)
  - [x] statische IP via MAC
- [x] controle (testplan)
  - [x] controle VLAN
    - [x] controleer per VLAN of het IP-adres uit de juiste range komt
  - [x] controle statische IP via MAC
    - [x] controleer per server of het IP-adres correct is
- [x] Documentatie
  - [x] Inleiding
    - [x] wat leren we
    - [x] cheatsheet
  - [x] stappenplan
  - [x] extra uitleg bij stappenplan
  - [x] testplan
  - [x] TO DO
  - [x] resources

## Resources

https://en.wikipedia.org/wiki/Private_network

https://galaxy.ansible.com/bertvv/dhcp

https://www.if-not-true-then-false.com/2018/fedora-28-workstation-install-guide/

https://docs.fedoraproject.org/en-US/Fedora/25/pdf/Networking_Guide/Fedora-25-Networking_Guide-en-US.pdf

https://support.rackspace.com/how-to/changing-dns-settings-on-linux/

https://www.cyberciti.biz/faq/linux-unix-find-out-dns-server-ip-address-names/172

<https://lifehacker.com/how-to-set-up-dhcp-reservations-and-never-check-an-ip-5822605>
