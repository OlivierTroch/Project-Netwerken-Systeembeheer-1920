# DHCP server 'kilo1' testplan

## Benodigdheden
- Computer met 2 ethernet interfaces
- Cisco L2 switch
- Cisco router

## Opstelling netwerkapparatuur
### Fysieke opstelling
1. Verbind de router met de switch (f0/1)
2. Verbind de switch tweemaal (f0/2, f0/3) met de PC
3. Verbind de router met de PC (consolekabel)
4. Verbind de switch met de PC (consolekabel)

### Router instellen
`enable`  
`configure terminal`  
`interface f0/1.20`  
`encapsulation dot1Q 20`  
`ip address 172.16.0.254 255.255.255.0`  
`ip helper-address 172.16.1.1`  
`no shutdown`  
`interface f0/1.30`  
`encapsulation dot1Q 30`  
`ip address 172.16.1.62 255.255.255.192`  
`no shutdown`  
`interface f0/1.50`  
`encapsulation dot1Q 50`  
`ip address 172.16.1.94 255.255.255.224`  
`ip helper-address 172.16.1.1`  
`no shutdown`  
`interface f0/1`  
`no shutdown`  

### Switch instellen
`enable`  
`configure terminal`  
`vlan 20`  
`vlan 30`  
`vlan 50`  
`interface f0/1`  
`switchport mode trunk`  
`no shutdown`  
`interface f0/2`  
`switchport mode access`  
`switchport access vlan 20`  
`no shutdown`  
`interface f0/3`  
`switchport mode access`  
`switchport access vlan 30`  
`no shutdown`  
`interface f0/5`  
`switchport mode access`  
`switchport acces vlan 50`  
`no shutdown`  

### kilo1 instellen
1. `vagrant up kilo1 --provison`, dit zal falen vanwege een non-host-only IP adres op eth1, wordt hierna opgelost
2. `vagrant ssh kilo1`
3. Verander BOOTPROTO=dhcp naar BOOTPROTO=none in /etc/sysconfig/network-scripts/ifcfg-eth1
4. Stel het IP adres in voor eth1 `echo 'IPADDR=172.16.1.1' | sudo tee --append /etc/sysconfig/network-scripts/ifcfg-eth1`
5. Stel het netmask in voor eth1 `echo 'NETMASK=255.255.255.192' | sudo tee --append /etc/sysconfig/network-scripts/ifcfg-eth1´
6. `sudo poweroff`
7. Navigeer naar VirtualBox > kilo1 VM > Settings > Network > Adapter 2
8. Verander 'Attached-to' naar 'Bridged adapter'
9. Verander 'Name' naar de netwerkinterface die verbonden is met f0/3 op de switch
10. Klik 'OK'
11. Start de VM in VirtualBox
12. Voeg een defaultroute toe naar de cisco router `sudo ip route add default via 172.16.1.62 dev eth1`
13. `sudo systemctl restart dhcpd`

### kilo1 configuratie controleren
1. `vagrant ssh kilo1`
2. 'ip address show eth1', hierin zie je dat eth1 het IP adres 172.16.1.1 met prefix 26 heeft
3. `ip route show`, de eerste entry hierin moet 'default via 172.16.1.62 dev eth1' zijn
4. `ping 172.16.1.62`, dit moet lukken
5. `ping 172.16.1.94`, dit moet lukken
6. `systemctl status dhcpd`, de status moet 'active (running)' zijn

### DHCP client instellen
1. `vagrant up bravo1 --provison`
2. `vagrant ssh kilo1`
3. `sudo poweroff`
4. Navigeer naar VirtualBox > bravo1 VM > Settings > Network > Adapter 2
5. Verander 'Attached-to' naar 'Bridged adapter'
6. Verander 'Name' naar de netwerkinterface die verbonden is met f0/5 op de switch
7. Klik 'OK'
8. Start de VM in VirtualBox
9. `sudo systemctl restart dhcpd`

## kilo1 DHCP scope voor VLAN 50 testen
### Fixed IP testen
1. `vagrant ssh bravo1`
2. `ip address show eth1`, het IP adres moet 172.16.1.66/27 zijn
3. `ip route show`, 'default via 172.16.1.94' moet er in staan
4. `cat /etc/resolv.conf`, DNS servers 172.16.1.66 en 172.16.1.67 moeten erin staan, alsook het search domain green.local

### Dynamisch IP testen
1. `sudo poweroff`
2. Navigeer naar VirtualBox > bravo1 VM > Settings > Network > Adapter 2 > Advanced
3. Verander het MAC adres van de adapter naar '080037665D02'
4. Klik 'OK'
5. Start de VM in VirtualBox
6. `vagrant ssh bravo1`
7. Vraag een nieuw IP adres op via `sudo dhclient eth1`
8. `ip address show eth1`, het IP adres moet in de range '172.16.1.80 - 172.16.1.93' liggen.
9. `ip route show`, 'default via 172.16.1.94' moet er in staan
10. `cat /etc/resolv.conf`, DNS servers 172.16.1.66 en 172.16.1.67 moeten erin staan, alsook het search domain green.local

## kilo1 DHCP scope voor VLAN 30 testen
### Fixed IP testen
1. `sudo poweroff`
2. Navigeer naar VirtualBox > bravo1 VM > Settings > Network > Adapter 2 > Advanced
3. Verander 'Name' naar de netwerkinterface die verbonden is met f0/3 op de switch
4. Verander het MAC adres van de adapter naar '080027665D06'
5. Klik 'OK'
6. Start de VM in VirtualBox
7. `vagrant ssh bravo1`
8. Vraag een nieuw IP adres op via `sudo dhclient eth1`
9. `ip address show eth1`, het IP adres moet 172.16.1.2/26 zijn
10. `ip route show`, 'default via 172.16.1.62' moet er in staan
11. `cat /etc/resolv.conf`, DNS servers 172.16.1.66 en 172.16.1.67 moeten erin staan, alsook het search domain green.local

### Dynamisch IP testen
1. `sudo poweroff`
2. Navigeer naar VirtualBox > bravo1 VM > Settings > Network > Adapter 2 > Advanced
3. Verander het MAC adres van de adapter naar '080037665D06'
4. Klik 'OK'
5. Start de VM in VirtualBox
6. `vagrant ssh bravo1`
7. Vraag een nieuw IP adres op via `sudo dhclient eth1`
8. `ip address show eth1`, het IP adres moet in de range '172.16.1.10 - 172.16.1.61' liggen.
9. `ip route show`, 'default via 172.16.1.62' moet er in staan
10. `cat /etc/resolv.conf`, DNS servers 172.16.1.66 en 172.16.1.67 moeten erin staan, alsook het search domain green.local
