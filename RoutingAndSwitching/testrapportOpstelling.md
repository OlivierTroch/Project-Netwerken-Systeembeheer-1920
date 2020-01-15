# Testrapport opstelling green

##Ter referentie
Voor de opstelling is er gebruik gemaakt van onderstaande IP-tabel opgesteld met VLSM berekening.

### Overzicht netwerk

| Subnet | Aantal hosts | Netwerk adres | Mask | Subnetmask | Range | Broadcast |
| :--- | :---       | :---   | :---   | :---   | :---   | :---   |
|20|128|172.16.0.0 |/24|255.255.255.0|172.16.0.1 - 172.16.0.254|172.16.0.255|
|30|40|172.16.1.0|/26|255.255.255.192|172.16.1.1 - 172.16.1.62|172.16.1.63|
|50|30|172.16.1.64|/27|255.255.255.224|172.16.1.65 - 172.16.1.94|172.16.1.95|
|40|2|172.16.1.96|/30|255.255.255.252|172.16.1.97 - 172.16.1.102|172.16.1.103|
|60|2|172.16.1.100|/30|255.255.255.252|172.16.1.101 - 172.16.1.102|172.16.1.103|
|70|2|172.16.1.104|/30|255.255.255.252|172.16.1.105 - 172.16.1.106|172.16.1.107|

### IP-adressen

| Naam | VLAN | IP-adres |
| :--- | :---       | :---   |
| Alpha1 | VLAN 50 | 172.16.1.65 |
| Bravo1 | VLAN 50 | 172.16.1.66 |
| Charlie1 | VLAN 50 | 172.16.1.67 |
| Delta1 | VLAN 50 | 172.16.1.68 |
| Echo1 | VLAN 50 | 172.16.1.69 |
| Kilo1 | VLAN 30 | 172.16.1.1 |
| Lima1 | VLAN 30 | 172.16.1.2 |
| Mike1 | VLAN 30 | 172.16.1.3 |
| November1 | VLAN 30 | 172.16.1.4 |
| Oscar1 | VLAN 30 | 172.16.1.5 |
| Papa1 | VLAN 30 | 172.16.1.6 |
| Zulu1 | VLAN 70 | 172.16.1.106 |
| Zulu1 | VLAN 60 | 172.16.1.102 |
| Router0 | VLAN 70 | 172.16.1.105 |
| Switch1 | VLAN 40 | 172.16.1.97 |
| Switch2 | VLAN 40 | 172.16.1.98 |
| Clients | VLAN 20 | 172.16.0.1 - 172.16.0.254 (DHCP) |
| Management | VLAN 99 | 172.16.99.1 |

# Te testen:

## Router0
#### Overzicht
 - [x] Hostnames en IP-adres geconfigureerd
 - [x] ACL opgesteld
 - [x] Router RIPv2 ingesteld
 - [x] Interface G0/0 open
 - [x] Interface S0/1/0 open

### Hostnames en IP-adres geconfigureerd
Als de prompt iets anders is dan de standaard `router>`, dan is er een hostname geconfigureerd. Kan ook gecheckt worden door `show running-config` 

```
Router0# show running-config 
Building configuration...

Current configuration : 970 bytes
!
version 15.1
no service timestamps log datetime msec
no service timestamps debug datetime msec
no service password-encryption
!
hostname Router0
```
**Voldaan**

### Router RIPv2 en ACL opgesteld
```
Router0# show running-config 
!
router rip
 version 2
 network 172.16.0.0
 no auto-summary
!
ip nat inside source list 1 interface GigabitEthernet0/0 overload
ip classless
!
```
**Voldaan**

### Interface G0/0 en Interface S0/1/0

```
Router0# show ip interface brief
Interface              IP-Address      OK? Method Status                Protocol 
GigabitEthernet0/0     172.16.1.105    YES manual up                    up 
GigabitEthernet0/1     unassigned      YES unset  administratively down down 
Serial0/1/0            unassigned      YES unset  administratively down down 
Serial0/1/1            unassigned      YES unset  administratively down down 
Vlan1                  unassigned      YES unset  administratively down down
```

**Voldaan**

## Router2
#### Overzicht
 - [x] Hostnames en IP-adres geconfigureerd
 - [x] ACL opgesteld
 - [x] Router RIPv2 ingesteld
 - [x] Interface G0/0 open
 - [x] Interface S0/1/0 open


## Switch0L2
#### Overzicht
 - [x] Hostname geconfigureerd
 - [x] Switchport mode Trunk op f0/1 vlan 20
 - [x] Switchport mode Acces f0/2-7 vlan 20

### Hostnames en IP-adres geconfigureerd
Als de prompt iets anders is dan de standaard `switch>`, dan is er een hostname geconfigureerd. Kan ook gecheckt worden door `show running-config` 

```
Switch0L2# show running-config 
Building configuration...

Current configuration : 1444 bytes
!
version 12.2
no service timestamps log datetime msec
no service timestamps debug datetime msec
no service password-encryption
!
hostname Switch0L2
```
**Voldaan**

### Switchport mode Trunk op vlan 20 en Switchport mode Acces f0/2-7 vlan 20
```
Switch0L2# show running-config 
hostname Switch0L2
!
!
!
!
!
spanning-tree mode pvst
spanning-tree extend system-id
!
interface FastEthernet0/1
 switchport trunk allowed vlan 20
 switchport mode trunk
!
interface FastEthernet0/2
 switchport access vlan 20
 switchport mode access
!
interface FastEthernet0/3
 switchport access vlan 20
 switchport mode access
!
interface FastEthernet0/4
 switchport access vlan 20
 switchport mode access
!
interface FastEthernet0/5
 switchport access vlan 20
 switchport mode access
!
interface FastEthernet0/6
 switchport access vlan 20
 switchport mode access
!
interface FastEthernet0/7
 switchport access vlan 20
 switchport mode access
!
```

**Voldaan**

## Switch1L3
#### Overzicht
 - [x] Hostname geconfigureerd
 - [x] Switchport mode Trunk op f0/1-2
 - [x] Switchport mode Acces f0/3-8 vlan 30

### Hostnames en IP-adres geconfigureerd
Als de prompt iets anders is dan de standaard `switch>`, dan is er een hostname geconfigureerd. Kan ook gecheckt worden door `show running-config` 

```
Switch1L3#show running-config 
Building configuration...

Current configuration : 1710 bytes
!
version 12.2(37)SE1
no service timestamps log datetime msec
no service timestamps debug datetime msec
no service password-encryption
!
hostname Switch1L3
```
**Voldaan**

### Switchport mode Trunk op f0/1-2 en Switchport mode Acces f0/3-8 vlan 30
```
Switch1L3#show running-config 
Building configuration...

Current configuration : 1710 bytes
!
version 12.2(37)SE1
no service timestamps log datetime msec
no service timestamps debug datetime msec
no service password-encryption
!
hostname Switch1L3
!
!
!
spanning-tree mode pvst
!
!
!
!
!
!
interface FastEthernet0/1
 switchport trunk encapsulation dot1q
!
interface FastEthernet0/2
 switchport trunk allowed vlan 20
 switchport trunk encapsulation dot1q
!
interface FastEthernet0/3
 switchport access vlan 30
 switchport mode access
 switchport nonegotiate
!
interface FastEthernet0/4
 switchport access vlan 30
 switchport mode access
 switchport nonegotiate
!
interface FastEthernet0/5
 switchport access vlan 30
 switchport mode access
 switchport nonegotiate
!
interface FastEthernet0/6
 switchport access vlan 30
 switchport mode access
 switchport nonegotiate
!
interface FastEthernet0/7
 switchport access vlan 30
 switchport mode access
 switchport nonegotiate
!
interface FastEthernet0/8
 switchport access vlan 30
 switchport mode access
 switchport nonegotiate
```

**Voldaan**

## Switch2L3
#### Overzicht
 - [x] Hostname geconfigureerd
 - [x] Vlan 20 opgesteld en IP toegekend
 - [x] Vlan 30 opgesteld en IP toegekend
 - [x] Vlan 40 opgesteld en IP toegekend
 - [x] Switchport trunk encapsulation dot1q op interface f0/1 & f0/3
 - [x] Router RIPv2 network 172.16.1.64
 
### Hostnames en IP-adres geconfigureerd
Als de prompt iets anders is dan de standaard `switch>`, dan is er een hostname geconfigureerd. Kan ook gecheckt worden door `show running-config` 

```
Switch2L3#show running-config 
Building configuration...

Current configuration : 1541 bytes
!
version 12.2(37)SE1
no service timestamps log datetime msec
no service timestamps debug datetime msec
no service password-encryption
!
hostname Switch2L3
```
**Voldaan**

### Switchport trunk encapsulation dot1q op interface f0/1 & f0/3
```
Switch2L3# show running-config 
Building configuration...

Current configuration : 1541 bytes
!
version 12.2(37)SE1
no service timestamps log datetime msec
no service timestamps debug datetime msec
no service password-encryption
!
hostname Switch2L3
!
!
ip routing
!
!
spanning-tree mode pvst
!
!
interface FastEthernet0/1
 switchport trunk encapsulation dot1q
!
interface FastEthernet0/2
!
interface FastEthernet0/3
 switchport trunk encapsulation dot1q
```
**Voldaan**

### Vlan 20/30/40 opgesteld en IP toegekend
```
Switch2L3# show running-config
!
interface Vlan20
 mac-address 0001.43d6.bd01
 ip address 172.16.0.1 255.255.255.0
!
interface Vlan30
 mac-address 0001.43d6.bd02
 ip address 172.16.1.1 255.255.255.192
!
interface Vlan40
 mac-address 0001.43d6.bd03
 ip address 172.16.1.102 255.255.255.252
```
**Voldaan**

### Router RIPv2

```
Switch2L3# show running-config
!
 router rip
 version 2
 network 172.16.0.0
```
**Voldaan**

## Switch3L2
#### Overzicht
 - [x] Hostname geconfigureerd
 - [x] Vlan 50 opgesteld
 - [x] Switchport mode access vlan 50 op interfaces f0/1-5
 - [x] Switchport mode trunk native vlan 1 op f0/6. Allowed vlan 50 & 20

### Hostnames en IP-adres geconfigureerd
Als de prompt iets anders is dan de standaard `switch>`, dan is er een hostname geconfigureerd. Kan ook gecheckt worden door `show running-config` 

```
Switch3L2#show running-config 
Building configuration...

Current configuration : 1396 bytes
!
version 12.2
no service timestamps log datetime msec
no service timestamps debug datetime msec
no service password-encryption
!
hostname Switch3L2
```

**Voldaan**

### Vlan 50 opgesteld en Switchport mode access vlan 50 op interfaces f0/1-5

```
Switch3L2#show running-config 
Building configuration...

Current configuration : 1396 bytes
!
version 12.2
no service timestamps log datetime msec
no service timestamps debug datetime msec
no service password-encryption
!
hostname Switch3L2
!
interface FastEthernet0/1
 switchport access vlan 50
 switchport mode access
!
interface FastEthernet0/2
 switchport access vlan 50
 switchport mode access
!
interface FastEthernet0/3
 switchport access vlan 50
 switchport mode access
!
interface FastEthernet0/4
 switchport access vlan 50
 switchport mode access
!
interface FastEthernet0/5
 switchport access vlan 50
 switchport mode access
```
**Voldaan**

### Switchport mode trunk native vlan 1 op f0/6. Allowed vlan 50 & 20

```
Switch3L2# show running-config 
Building configuration...

Current configuration : 1396 bytes
!
version 12.2
no service timestamps log datetime msec
no service timestamps debug datetime msec
no service password-encryption
!
hostname Switch3L2
!
interface FastEthernet0/6
 switchport trunk allowed vlan 20,50
 switchport mode trunk
```
**Voldaan**
