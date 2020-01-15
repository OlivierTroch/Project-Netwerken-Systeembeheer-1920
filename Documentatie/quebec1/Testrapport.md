# Testrapport Quebec1
# Before
om te testen werd lima1 gebruikt en in /etc/resolv.conf werd als nameserver het ipadress van quebec1 ingesteld.
en natuurlijk quebec1 zelf om zijn hostname en ip address te testen

## test quebec1 zelf
1. ip address correct ingesteld 
```bash
[vagrant@quebec1 ~]$ ip a | grep "eth1"
3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP gr
    inet 172.16.1.70/24 brd 172.16.1.255 scope global noprefixroute eth1
```

2. hostname correct ingesteld
```bash
[vagrant@quebec1 ~]$ hostname
quebec1
```

## Nslookups testen
1. De lookups van de servers gaven het ipaddress weer van de server dus geslaagd
```bash
[vagrant@lima1 ~]$ nslookup delta1
Server:         172.16.1.70
Address:        172.16.1.70#53

Name:   delta1
Address: 172.16.1.68
```
```bash
[vagrant@lima1 ~]$ nslookup bravo1
Server:         172.16.1.70
Address:        172.16.1.70#53

Name:   bravo1
Address: 172.16.1.66
```

2. de lookups van de externe sites werkten ook en gaven het ip address weer van die site
```bash
[vagrant@lima1 ~]$ nslookup facebook.com
Server:         172.16.1.70
Address:        172.16.1.70#53

Non-authoritative answer:
Name:   facebook.com
Address: 157.240.201.35
Name:   facebook.com
Address: 2a03:2880:f145:82:face:b00c:0:25de
```
```bash
[vagrant@lima1 ~]$ nslookup hogent.be
Server:         172.16.1.70
Address:        172.16.1.70#53

Non-authoritative answer:
Name:   hogent.be
Address: 193.190.173.132
```