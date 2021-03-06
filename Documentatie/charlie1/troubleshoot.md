# Testplan Bravo1

Author: [Robin Ophalvens](https://github.com/RobinOphalvens)

## Abstract

This document will serve as a troubleshooting guide during the live production in week 9. In order to solve issues as quick as possible, we will go layer by layer and determine where the issue could be present.

## Physical layer

We will skip this part since the server will be run on a virtual environment.

## Internet layer

Possible issues:

* IP address is not correctly configured
* Default gateway is not correctly configured


### Resolve ip address issue
Charlie 1 should have a static 172.16.1.67 as IPv4 address with a /24 subnetmask. Check which ip the VM has configured by using ip a 

``` bash
    ip a
``` 

To manually change this, edit the ethernet interface with vi which should be located in directory. It should be as follows:


``` bash
/etc/sysconfig/network-scripts/
[root@bravo1 ~]# cat /etc/sysconfig/network-scripts/ifcfg-eth1 
#VAGRANT-BEGIN
# The contents below are automatically generated by Vagrant. Do not modify.
NM_CONTROLLED=yes
BOOTPROTO=none
ONBOOT=yes
IPADDR=172.16.1.67
NETMASK=255.255.255.0
DEVICE=eth1
PEERDNS=no
#VAGRANT-END

```

In ansible, check in the file vagrant-hosts.yml if bravo1 has an entry.

``` yaml
   #Charlie1 DNS Backup Server
- name: charlie1
  mac: '08:00:27:66:5D:03'
  ip: 172.16.1.67
  
``` 


### Set default gateway

You can set the default gateway to the correct router by either using a command or editing a configuration file. Both are shown below.

An example:

``` bash
   $ sudo ip route replace default via 192.168.91.10 dev eth0 
```

Or edit file /etc/sysconfig/network 

``` bash
    GATEWAY=192.168.91.10
``` 

## Transport layer

Is the named service running?

``` bash
    sudo systemctl status named
    sudo systemctl start named
    sudo systemctl enable named
```
Check if the firewall allows DNS traffic to pass through by service.

``` bash
$ sudo firewall-cmd --list-all
``` 


Check if the firewall allows dns traffic to pass through port 53

``` bash
$ sudo netstat -tulnp | grep 53
```

Note: by default, the dns bind role will automatically start and enable the named service. If you are combining the role with, let's say bertvv.rh-base, make sure dns is added to the firewall. In ansible, this done using the variable rhbase_firewall_allow_services:
## Application layer

Use the dig and nslookup commands to determine if DNS server responds to queries:
(Note: you need to edit /etc/resolv.conf and add DNS servers. You can also manually enter the dns server ip address in the nslookup command)

``` bash

 #What is the ip address of Alpha 1?
 $ nslookup alpha1.green.local

 #Expected output:
Server:		172.16.1.67
Address:	172.16.1.67#53

Name:	alpha1.green.local
Address: 172.16.1.65

#What name is accociated with a given IP address?
$ nslookup 172.16.1.67

#Expected output:
67.1.16.172.in-addr.arpa	name = charlie1.green.local.
```

The dig command provides a more detailed output. Nslookup is used here due to it's simplicity as well as the fact it is also available on Windows Systems.


### Possible issues if no answer is given to a DNS query:

* The dns server only responds to queries from host in the 172.16 network. Make sure your ip address belongs to that network

* If your ip address is correct, follow these steps to determine the issue:

1. Under /var/local/named-zones/, check if the primary and reverse zone files are present.

``` bash
    $ sudo ls /var/local/named-zones/
    16.172.in-addr.arpa  green.local

```
/var/local/named-zones/green.local should have the following configuration:

``` bash
    ; Hash: 1bde9a5ebb2296900ef9546f2c46747f 1573327809
; Zone file for green.local
;
; Ansible managed
;

$ORIGIN green.local.
$TTL 1W

@ IN SOA bravo1.green.local. hostmaster.green.local. (
  1573327809
  2D
  2H
  2W
  2D )

                           IN  NS     bravo1.green.local.



@                          IN  A      172.16.1.69
www                        IN  CNAME  @
alpha1                     IN  A      172.16.1.65
bravo1                     IN  A      172.16.1.66
ns1                        IN  DNAME  bravo1
charlie1                   IN  A      172.16.1.67
ns2                        IN  DNAME  charlie1
delta1                     IN  A      172.16.1.68
echo1                      IN  A      172.16.1.69
kilo1                      IN  A      172.16.1.1
lima1                      IN  A      172.16.1.2
mike1                      IN  A      172.16.1.3
november1                  IN  A      172.16.1.4
oscar1                     IN  A      172.16.1.5
papa1                      IN  A      172.16.1.6
quebec1                    IN  A      172.16.1.70
zulu1                      IN  A      172.16.1.106
zulu1                      IN  A      172.16.1.102
Router0                    IN  A      172.16.1.105
Switch1                    IN  A      172.16.1.97
Switch2                    IN  A      172.16.1.98
Switch2                    IN  A      172.16.1.101
Management                 IN  A      172.16.99.1
```

File 16.172.in-addr.arpa:

``` bash
    ; Hash: 4aaea655228e29d11d6c2360c36cf367 1573327809
; Reverse zone file for green.local
;
; Ansible managed
;

$TTL 1W
$ORIGIN 16.172.in-addr.arpa.

@ IN SOA bravo1.green.local. hostmaster.green.local. (
  1573327809
  2D
  2H
  2W
  2D )

                       IN  NS   bravo1.green.local.

65.1                   IN  PTR  alpha1.green.local.
66.1                   IN  PTR  bravo1.green.local.
67.1                   IN  PTR  charlie1.green.local.
68.1                   IN  PTR  delta1.green.local.
69.1                   IN  PTR  echo1.green.local.
1.1                    IN  PTR  kilo1.green.local.
2.1                    IN  PTR  lima1.green.local.
3.1                    IN  PTR  mike1.green.local.
4.1                    IN  PTR  november1.green.local.
5.1                    IN  PTR  oscar1.green.local.
6.1                    IN  PTR  papa1.green.local.
70.1                   IN  PTR  quebec1.green.local.
106.1                  IN  PTR  zulu1.green.local.
102.1                  IN  PTR  zulu1.green.local.
105.1                  IN  PTR  Router0.green.local.
97.1                   IN  PTR  Switch1.green.local.
98.1                   IN  PTR  Switch2.green.local.
101.1                  IN  PTR  Switch2.green.local.
1.99                   IN  PTR  Management.green.local.
```

Finally, check if the main configuration file is present. It should be located under /etc/named.conf

``` bash
    //
// named.conf
//
//
// Ansible managed
//
//
options {
  listen-on port 53 { any; };
  listen-on-v6 port 53 { none; };
  directory   "/var/named";
  dump-file   "/var/named/data/cache_dump.db";
  statistics-file "/var/named/data/named_stats.txt";
  memstatistics-file "/var/named/data/named_mem_stats.txt";
  allow-query     { 172.16/16; };
  check-names  master ignore;

  recursion no;
    
  rrset-order { order random; };

  dnssec-enable True;
  dnssec-validation True;
  dnssec-lookaside auto;

  /* Path to ISC DLV key */
  bindkeys-file "/etc/named.iscdlv.key";

  managed-keys-directory "/var/named/dynamic";

  pid-file "/run/named/named.pid";
  session-keyfile "/run/named/session.key";

  querylog yes;
};

statistics-channels {
  inet 127.0.0.1 port 8053 allow { 127.0.0.1; };
};

logging {
  channel default_debug {
    file "data/named.run";
    severity dynamic;
    print-time yes;
  };
  channel querylog {
    file "data/query.log" versions 600 size 20m;
    severity dynamic;
    print-time yes;
  };
  category queries { querylog; };
};

include "/etc/named.root.key";
include "/etc/named.rfc1912.zones";

zone "green.local" IN {
  type master;
  file "/var/local/named-zones/green.local";
  notify yes;
  allow-update { none; };
};

zone "16.172.in-addr.arpa" IN {
  type master;
  file "/var/local/named-zones/16.172.in-addr.arpa";
  notify yes;
  allow-u
```

### Solving specific issues in ansible

* Issue: directory /var/local/named-zones/ does not exist
Solution: check if ansible variable bind_zone_dir is correctly set.

* Issue: zone file green.local does not exist.
Solution: check if file /ansible/host_vars/bravo1.yml is syntactically correct. A domain should exist with a set of hosts listed to their respective IPv4 address.

* Issue: reverse zone file, 16.172.in-addr.arpa does not exist.
Solution: Under the domain definitions in bravo1.yml, make sure the section "networks" is present with '172.16' as the range. Here's an excerpt:

``` yaml
       ip: '172.16.1.97'
          - name: Switch2
            ip: '172.16.1.98'
          - name: Switch2
            ip: '172.16.1.101'
          - name: Management
            ip: '172.16.99.1'
        networks: 
          - '172.16'
    bind_statistics_channels: true

    prometheus_servers:
      - 172.16.1.5
    prometheus_components:
      - bind_exporter_digitalocean
    prometheus_bind_exporter_digitalocean_port: 9119
```

* Issue: unable to query the dns server. Connection refused.
Solution: the server only responds to queries from hosts in the 172.16/16 network range. Make sure your ipv4 address falls under that range.

* Issue: unable to find specified host/ip. For example:

```bash
Server:		127.0.0.53
Address:	127.0.0.53#53

** server can't find alpha1.green.local: NXDOMAIN

```

Solution: make sure the dns server is running, allows dns traffic to pass through a firewall if one is configured (by default, the role does not install a firewall).