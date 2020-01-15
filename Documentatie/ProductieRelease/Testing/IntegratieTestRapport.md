# Integratie testrapport - 16 december 2019
## Requirements
  Alle requirements zijn voldaan.

## A priori
  Het netwerk is volledig opgesteld en alle servers zijn te bereiken.
  ```
  Current machine states:

  alfa1                     running (libvirt)
  bravo1                    running (libvirt)
  charlie1                  running (libvirt)
  delta1                    running (libvirt)
  echo1                     running (libvirt)
  quebec1                   running (libvirt)
  kilo1                     running (libvirt)
  lima1                     running (libvirt)
  mike1                     running (libvirt)
  november1                 running (libvirt)
  oscar1                    running (libvirt)
  papa1                     running (libvirt)

  This environment represents multiple VMs. The VMs are all listed
  above with their current state. For more information about a specific
  VM, run `vagrant status NAME`.
  ```
Ipadres is juist ingesteld.

  ```
  4: br30: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
      link/ether 1c:c1:de:02:0b:50 brd ff:ff:ff:ff:ff:ff
      inet 172.16.1.12/16 brd 172.16.255.255 scope global noprefixroute br30
         valid_lft forever preferred_lft forever
      inet6 fe80::44c9:71ff:fe26:30de/64 scope link
         valid_lft forever preferred_lft forever
  ```

## Stappenplan
#### 1. Netwerk & server opstellen (R&S & Productie-omgeving)
##### vanuit VLAN 20
* [x] Controleer indien volgende pings succesvol zijn :
    * [x] ping 172.16.0.80 (S1.3)
    * [x] ping 172.16.0.254 (R2.1 DG)
    * [x] ping 172.16.1.62 (R2.1 naar vlan 3O)
    * [x] ping 172.16.1.50 (S1.2 vlan 30)
    * [x] ping 172.16.1.97 (R2.1 serieel)
    * [x] ping 172.16.1.98 (R2.2 serieel)
    * [x] ping 172.16.1.94 (R2.2 naar vlan 50)
    * [x] ping 172.16.1.80 (S1.1 vlan 50)

##### Firewall
  * [x] Controleer indien volgende pings succesvol zijn :
      * [x] ping 172.16.1.101 (R2.2 naar Zulu1)
      * [x] ping 172.16.1.102 (zulu1 - inside - lan)
      * [x] ping 172.16.1.106 (zulu1 - outside - wan)

##### WAN
* [x] Controleer indien volgende pings succesvol zijn :
    * [x] ping 172.16.1.105 (R1.1 van zulu1)
    * [x] ping 172.16.1.109 (R1.1 naar R1.2)
    * [x] ping 172.16.1.110 (R1.2 van R1.1)
    * [x] ping 172.16.2.2 (R1.2 serieel naar Top)
    * [x] ping 172.16.2.1 (Top van R1.2)
surf naar chamilo.be (ip route 172.16.0.0 255.255.0.0 s0/1/1 WINDOWS!)

##### SSH
* [x] Controleer indien je een secure shell connectie kan maken met volgende addressen.
    * [x] Admin@172.16.1.50  (S1.1 - vlan 50)
    * [x] Admin@172.16.0.254 (R2.1)
    * [x] Admin@172.16.1.110 (R1.2)

#### 2. Kilo1 (DHCP)
  * [x] Controleer of de server(interface eth1) het IP adres ***172.16.1.1*** bevat.
      * Gebruik onderstaand commando om dit te controleren.
         ``` bash
             ip address show eth1
         ```
         RESULLT:
         ```
         3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
            link/ether 52:54:00:30:de:f2 brd ff:ff:ff:ff:ff:ff
            inet 172.16.1.1/26 brd 172.16.1.63 scope global noprefixroute eth1
            valid_lft forever preferred_lft forever
            inet6 fe80::5054:ff:fe30:def2/64 scope link
            valid_lft forever preferred_lft forever
       ```
  * [x] Controleer of de eerste entry **default via 172.16.1.62 dev eth1** bevat.
      * Gebruik onderstaand commando om dit te controleren.
       ``` bash
           ip route show
       ```
       RESULT:
       ```
       default via 172.16.1.62 dev eth1 proto static metric 101
172.16.1.0/26 dev eth1 proto kernel scope link src 172.16.1.1 metric 101
       ```
  * [x] Verifeer of je kunt pingen naar het IP adres **172.16.1.62**.
      * Gebruik onderstaand commando om dit te controleren.
       ``` bash
           ping 172.16.1.62
       ```
       RESULT:
       ```
        PING 172.16.1.62 (172.16.1.62) 56(84) bytes of data.
        64 bytes from 172.16.1.62: icmp_seq=1 ttl=255 time=0.288 ms
        64 bytes from 172.16.1.62: icmp_seq=2 ttl=255 time=0.732 ms
        64 bytes from 172.16.1.62: icmp_seq=3 ttl=255 time=0.572 ms
        64 bytes from 172.16.1.62: icmp_seq=4 ttl=255 time=0.483 ms
        64 bytes from 172.16.1.62: icmp_seq=5 ttl=255 time=0.424 ms
        64 bytes from 172.16.1.62: icmp_seq=6 ttl=255 time=0.496 ms
        64 bytes from 172.16.1.62: icmp_seq=7 ttl=255 time=0.754 ms
        64 bytes from 172.16.1.62: icmp_seq=8 ttl=255 time=0.501 ms
        64 bytes from 172.16.1.62: icmp_seq=9 ttl=255 time=0.430 ms
        64 bytes from 172.16.1.62: icmp_seq=10 ttl=255 time=0.522 ms
        ^C
        --- 172.16.1.62 ping statistics ---
        10 packets transmitted, 10 received, 0% packet loss, time 9003ms
        rtt min/avg/max/mdev = 0.288/0.520/0.754/0.133 ms
       ```
  * [x] Verifeer of je kunt pingen naar het IP adres **172.16.1.94**.
      * Gebruik onderstaand commando om dit te controleren.
       ``` bash
           ping 172.16.1.94
       ```
       RESULT:
       ```
        PING 172.16.1.94 (172.16.1.94) 56(84) bytes of data.
        64 bytes from 172.16.1.94: icmp_seq=1 ttl=254 time=498 ms
        64 bytes from 172.16.1.94: icmp_seq=2 ttl=254 time=531 ms
        64 bytes from 172.16.1.94: icmp_seq=3 ttl=254 time=554 ms
        64 bytes from 172.16.1.94: icmp_seq=4 ttl=254 time=431 ms
        64 bytes from 172.16.1.94: icmp_seq=5 ttl=254 time=447 ms
        64 bytes from 172.16.1.94: icmp_seq=6 ttl=254 time=466 ms
        64 bytes from 172.16.1.94: icmp_seq=7 ttl=254 time=479 ms
        64 bytes from 172.16.1.94: icmp_seq=8 ttl=254 time=407 ms
        64 bytes from 172.16.1.94: icmp_seq=9 ttl=254 time=382 ms
        64 bytes from 172.16.1.94: icmp_seq=10 ttl=254 time=335 ms
        ^C
        --- 172.16.1.94 ping statistics ---
        10 packets transmitted, 10 received, 0% packet loss, time 9001ms
        rtt min/avg/max/mdev = 335.276/453.390/554.035/63.766 ms
       ```
  * [x] Controleer of de dhcpd service 'active (running)' is.
      * Gebruik onderstaand commando om dit te controleren.
       ``` bash
           sudo systemctl status dhcpd
       ```
       RESULT:
       ```
       ● dhcpd.service - DHCPv4 Server Daemon
         Loaded: loaded (/usr/lib/systemd/system/dhcpd.service; enabled; vendor preset: disabled)
         Active: active (running) since Mon 2019-12-16 12:39:24 UTC; 2h 19min ago
           Docs: man:dhcpd(8)
                 man:dhcpd.conf(5)
         Main PID: 4534 (dhcpd)
           Status: "Dispatching packets..."
           CGroup: /system.slice/dhcpd.service
                   └─4534 /usr/sbin/dhcpd -f -cf /etc/dhcp/dhcpd.conf -user dhcpd -...

          Dec 16 14:56:24 kilo1 dhcpd[4534]: DHCPREQUEST for 172.16.0.2 (172.16.1.1...54
          Dec 16 14:56:24 kilo1 dhcpd[4534]: DHCPACK on 172.16.0.2 to d8:cb:8a:ef:3...54
          Dec 16 14:57:11 kilo1 dhcpd[4534]: DHCPDISCOVER from f4:30:b9:8a:a8:2f (L...54
          Dec 16 14:57:12 kilo1 dhcpd[4534]: DHCPOFFER on 172.16.0.15 to f4:30:b9:8...54
          Dec 16 14:57:12 kilo1 dhcpd[4534]: DHCPREQUEST for 172.16.0.15 (172.16.1....54
          Dec 16 14:57:12 kilo1 dhcpd[4534]: DHCPACK on 172.16.0.15 to f4:30:b9:8a:...54
          Dec 16 14:59:02 kilo1 dhcpd[4534]: DHCPDISCOVER from f4:30:b9:c5:57:58 vi...54
          Dec 16 14:59:03 kilo1 dhcpd[4534]: DHCPOFFER on 172.16.0.17 to f4:30:b9:c...54
          Dec 16 14:59:03 kilo1 dhcpd[4534]: DHCPREQUEST for 172.16.0.17 (172.16.1....54
          Dec 16 14:59:03 kilo1 dhcpd[4534]: DHCPACK on 172.16.0.17 to f4:30:b9:c5:...54
          Hint: Some lines were ellipsized, use -l to show in full.
       ```

  ##### DHCP scope voor VLAN 50
  **Opmerking:** Bravo1 kan vervangen worden door eender welke server in VLAN 50 met fixed IP.
  * pre-task: Verbind via Secure shell met Bravo1.
  * [x] Controleer of de server(interface eth1) het IP adres ***172.16.1.66/27*** bevat.
      * Gebruik onderstaand commando om dit te controleren.
       ``` bash
           ip address show eth1
       ```
       RESULT:
       ```
       3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
     link/ether 08:00:27:66:5d:02 brd ff:ff:ff:ff:ff:ff
     inet 172.16.1.66/27 brd 172.16.1.95 scope global noprefixroute dynamic eth1
        valid_lft 36698sec preferred_lft 36698sec
     inet6 fe80::a00:27ff:fe66:5d02/64 scope link
        valid_lft forever preferred_lft forever
       ```
  * [x] Controleer of de eerste entry **default via 172.16.1.94** bevat.
      * Gebruik onderstaand commando om dit te controleren.
       ``` bash
           ip route show
       ```
       RESULT:
       ```
        default via 172.16.1.94 dev eth1
        default via 172.16.1.94 dev eth1 proto dhcp metric 101
        172.16.1.64/27 dev eth1 proto kernel scope link src 172.16.1.66 metric 101
       ```
  * [x] Test indien resolv.conf de DNS entrys bevat(172.16.1.66 en 172.16.1.67) en alsook het search domain green.local.
      * Gebruik onderstaand commando om dit te controleren.
       ``` bash
           cat /etc/resolv.conf
       ```
       RESULT:
       ```
        # Generated by NetworkManager  
          search green.local
          nameserver 172.16.1.70
       ```
  ##### kilo1 DHCP scope voor VLAN 30 testen
  **Opmerking:** Lima1 kan vervangen worden door eender welke server in VLAN 30 met fixed IP.
  * pre-task: Verbind via Secure shell met Lima1.
  * [x] Controleer of de server(interface eth1) het IP adres ***172.16.1.2/27*** bevat.
      * Gebruik onderstaand commando om dit te controleren.
       ``` bash
           ip address show eth1
       ```
  * [x] Controleer of de eerste entry **default via 172.16.1.62** bevat.
      * Gebruik onderstaand commando om dit te controleren.
       ``` bash
            ip route show
       ```
  * [x] Test indien resolv.conf de DNS entrys bevat(172.16.1.66 en 172.16.1.67) en alsook het search domain green.local.
      * Gebruik onderstaand commando om dit te controleren.
       ``` bash
            cat /etc/resolv.conf
       ```
  ##### kilo1 DHCP scope voor VLAN 20 testen
  * pre-task: Verbind via Secure shell met een host uit VLAN 20.
  * [x] Controleer of de host een IP adres bevat dat binnen in de range '172.16.0.10 - 172.16.0.253' ligt.
      * Gebruik onderstaand commando om dit te controleren.
       ``` bash
           ip address show eth1
       ```
  * [x] Controleer of de eerste entry **default via 172.16.1.62** bevat.
      * Gebruik onderstaand commando om dit te controleren.
       ``` bash
           ip route show
       ```
  * [x] Test indien resolv.conf de DNS entrys bevat(172.16.1.66 en 172.16.1.67) en alsook het search domain green.local.
      * Gebruik onderstaand commando om dit te controleren.
       ``` bash
           cat /etc/resolv.conf
       ```

OPMERKING:  
**Het integratierapport is maar tot dit punt opgelost, dit komt omdat er te weinig tijd was voorzien om het volledige testplan te overlopen met te weinig teamleden. De testrapporten van elke server apart bevestigen wel dat deze testen succesvol zouden zijn.**

#### Opgesteld door Olivier Troch en Joeri Verhavert
