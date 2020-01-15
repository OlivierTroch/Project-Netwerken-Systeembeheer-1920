# Beknopte testplan voor productie-omgeving

## kilo1 configuratie controleren

1. `vagrant ssh kilo1`
2. 'ip address show eth1', hierin zie je dat eth1 het IP adres 172.16.1.1 met prefix 26 heeft
3. `ip route show`, de eerste entry hierin moet 'default via 172.16.1.62 dev eth1' zijn
4. `ping 172.16.1.62`, dit moet lukken
5. `ping 172.16.1.94`, dit moet lukken
6. `systemctl status dhcpd`, de status moet 'active (running)' zijn

## kilo1 DHCP scope voor VLAN 50 testen

### Fixed IP testen (Bravo1 kan vervangen worden door eender welke server in VLAN 50 met fixed IP, juist de L2switch kan hier niet gebruikt worden)

1. `vagrant ssh bravo1`
2. `ip address show eth1`, het IP adres moet 172.16.1.66/27 zijn
3. `ip route show`, 'default via 172.16.1.94' moet er in staan
4. `cat /etc/resolv.conf`, DNS servers 172.16.1.66 en 172.16.1.67 moeten erin staan, alsook het search domain green.local

## kilo1 DHCP scope voor VLAN 30 testen 

### Fixed IP testen (dit kan je doen voor eender welke server in VLAN 30)

1. `vagrant ssh lima1`
2. `ip address show eth1`, het IP adres moet 172.16.1.2/27 zijn
3. `ip route show`, 'default via 172.16.1.62' moet er in staan
4. `cat /etc/resolv.conf`, DNS servers 172.16.1.66 en 172.16.1.67 moeten erin staan, alsook het search domain green.local

## kilo1 DHCP scope voor VLAN 20 testen

### Dynamic IP testen (dit kan je doen voor eender welke client in VLAN 20)

1. `ip address show eth1`, het IP adres moet in de range '172.16.0.10 - 172.16.0.253' liggen.
2. `ip route show`, 'default via 172.16.0.254' moet er in staan
3. `cat /etc/resolv.conf`, DNS servers 172.16.1.66 en 172.16.1.67 moeten erin staan, alsook het search domain green.local

