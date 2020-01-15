# Testrapport Quebec1
# Before
Er wordt een werkstation gebruikt die verbonden is met het netwerk green.local die de DNS-forwarder Quebec1 gebruikt om zijn DNS-requests te requesten.

## test quebec1 zelf
1. ip address correct ingesteld 
```bash
[student@quebec1 ~]$ ip a | grep "eth1"
3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP gr
    inet 172.16.1.70/24 brd 172.16.1.255 scope global noprefixroute eth1
```

2. hostname correct ingesteld
```bash
[student@quebec1 ~]$ hostname
quebec1
```

## Nslookups testen
1. De lookups van de servers in green.local gaven het ip address weer van de server dus geslaagd
```bash
C:\Users\Robin> nslookup delta1
Server:         172.16.1.70
Address:        172.16.1.70#53

Name:   delta1
Address: 172.16.1.68
```
```bash
C:\Users\Robin> nslookup bravo1
Server:         172.16.1.70
Address:        172.16.1.70#53

Name:   bravo1
Address: 172.16.1.66
```

2. De lookups van de servers in red.local gaven het ip address weer van de server dus geslaagd
```bash
C:\Users\Robin> nslookup alfa2.red.local
Server: Unknown
Address: 172.16.1.70

Name: alfa2.red.local
Address: 172.18.1.66
```
```bash
C:\Users\Robin> nslookup delta2.red.local
Server: Unknown
Address: 172.16.1.70

Name: delta2.red.local
Address: 172.18.1.69
```

3. de lookups van de externe sites werkten ook en gaven het ip address weer van die site
```bash
C:\Users\Robin> nslookup facebook.com
Server:         172.16.1.70
Address:        172.16.1.70#53

Non-authoritative answer:
Name:   facebook.com
Address: 157.240.201.35
Name:   facebook.com
Address: 2a03:2880:f145:82:face:b00c:0:25de
```
```bash
C:\Users\Robin> nslookup hogent.be
Server:         172.16.1.70
Address:        172.16.1.70#53

Non-authoritative answer:
Name:   hogent.be
Address: 193.190.173.132
```