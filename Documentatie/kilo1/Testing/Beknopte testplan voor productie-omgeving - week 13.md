# Beknopte testplan voor productie-omgeving: week 13

## kilo1 configuratie controleren

- [x] `vagrant ssh kilo1`
- [x] `ip address show eth1`, hierin zie je dat eth1 het IP adres 172.16.1.1 met prefix 26 heeft
- [x] `ip route show`, de eerste entry hierin moet 'default via 172.16.1.62 dev eth1' zijn
- [x] `ping 172.16.1.62`, dit moet lukken
- [x] `ping 172.16.1.94`, dit moet lukken
- [x] `systemctl status dhcpd`, de status moet 'active (running)' zijn

## kilo1 DHCP scope voor VLAN 50 testen

### Fixed IP testen (Bravo1 kan vervangen worden door eender welke server in VLAN 50 met fixed IP, juist de L2switch kan hier niet gebruikt worden)

- [x] `vagrant ssh bravo1`
- [x] `ip address show eth1`, het IP adres moet 172.16.1.66/27 zijn
- [x] `ip route show`, 'default via 172.16.1.94' moet er in staan
- [x] `cat /etc/resolv.conf`, DNS server/forwarder 172.16.1.70 moeten erin staan, alsook het search domain green.local

## kilo1 DHCP scope voor VLAN 30 testen 

### Fixed IP testen (dit kan je doen voor eender welke server in VLAN 30)

- [x] `vagrant ssh oscar1`
- [x] `ip address show eth1`, het IP adres moet 172.16.1.5/27 zijn
- [x] `ip route show`, 'default via 172.16.1.62' moet er in staan
- [x] `cat /etc/resolv.conf`, DNS server/forwarder 172.16.1.70 moeten erin staan, alsook het search domain green.local

## kilo1 DHCP scope voor VLAN 20 testen

### Dynamic IP testen (dit kan je doen voor eender welke client in VLAN 20)

- [x] `ip address show eth1`, het IP adres moet in de range '172.16.0.10 - 172.16.0.253' liggen.
- [x] `ip route show`, 'default via 172.16.0.254' moet er in staan
- [x] `cat /etc/resolv.conf`, DNS server/forwarder 172.16.1.70 moeten erin staan, alsook het search domain green.local


## Problemen

- DNS-server
  - Bravo1 en Charlie1 meegegeven => moest Quebec1 zijn
  - oplossing: configfile aanpassen op server
    - 172.16.1.66 en 172.16.1.67 vervangen door 172.16.1.70 ( quebec1)
  - oplossing: DHCP-requests
    - alle servers die al een DHCP hadden met verkeerde DNS server moeten een nieuw DHCP-request versturen
    - alle clients moeten opnieuw verbinden