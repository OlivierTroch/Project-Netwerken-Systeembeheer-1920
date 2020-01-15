# Testrapport Bravo1

Author: [Jolien Vervinckt](https://github.com/JolienVervinckt) 

# Testplan Bravo1

## Requirements

* Bravo1 en Charlie1 zijn niet afhankelijk van andere servers om naar behoren te kunenn functioneren
* via het commando "vagrant up bravo1" en optioneel "vagrant provision bravo1" zou ansible succesvol de configuratie van de DNS server moeten behandelen.


## Stap 1: Check of de named service (naam van de bind applicatie op CentOS) actief is

Commando:

``` bash
    sudo systemctl status named
```

Verwachte output:

``` bash
    ● named.service - Berkeley Internet Name Domain (DNS)
   Loaded: loaded (/usr/lib/systemd/system/named.service; enabled; vendor preset: disabled)
   Active: active (running) since Sat 2019-11-16 11:32:53 UTC; 4min 58s ago
  Process: 4940 ExecReload=/bin/sh -c /usr/sbin/rndc reload > /dev/null 2>&1 || /bin/kill -HUP $MAINPID (code=exited, status=0/SUCCESS)
  Process: 4862 ExecStart=/usr/sbin/named -u named -c ${NAMEDCONF} $OPTIONS (code=exited, status=0/SUCCESS)
  Process: 4860 ExecStartPre=/bin/bash -c if [ ! "$DISABLE_ZONE_CHECKING" == "yes" ]; then /usr/sbin/named-checkconf -z "$NAMEDCONF"; else echo "Checking of zone files is disabled"; fi (code=exited, status=0/SUCCESS)
 Main PID: 4864 (named)
   CGroup: /system.slice/named.service
           └─4864 /usr/sbin/named -u named -c /etc/named.conf

Nov 16 11:32:53 bravo1 named[4864]: configuring command channel from '/etc/...y'
Nov 16 11:32:53 bravo1 named[4864]: reloading configuration succeeded
Nov 16 11:32:53 bravo1 named[4864]: reloading zones succeeded
Nov 16 11:32:53 bravo1 named[4864]: all zones loaded
Nov 16 11:32:53 bravo1 named[4864]: running
Nov 16 11:32:53 bravo1 named[4864]: managed-keys-zone: Unable to fetch DNSK...ed
Nov 16 11:32:53 bravo1 systemd[1]: Reloaded Berkeley Internet Name Domain (DNS).
Nov 16 11:32:53 bravo1 named[4864]: resolver priming query complete
Nov 16 11:35:37 bravo1 named[4864]: client @0x7f9d8c0c6790 172.16.1.66#5318...ed
Nov 16 11:35:37 bravo1 named[4864]: client @0x7f9d8c0c6790 172.16.1.66#5318...45
Hint: Some lines were ellipsized, use -l to show in full.

``` 
Verkregen output:

```bash
[student@bravo1 /]$ sudo systemctl status named
● named.service - Berkeley Internet Name Domain (DNS)
   Loaded: loaded (/usr/lib/systemd/system/named.service; enabled; vendor preset: disabled)
   Active: active (running) since Sun 2019-11-17 17:44:25 UTC; 15min ago
 Main PID: 7379 (named)
   CGroup: /system.slice/named.service
           └─7379 /usr/sbin/named -u named -c /etc/named.conf

Dec 16 14:48:03 bravo1 named[7379]: running
Dec 16 14:48:03 bravo1 named[7379]: network unreachable resolving './DNSKEY...53
Dec 16 14:48:03 bravo1 named[7379]: network unreachable resolving './DNSKEY...53
Dec 16 14:48:03 bravo1 named[7379]: network unreachable resolving './DNSKEY...53
Dec 16 14:48:03 bravo1 named[7379]: network unreachable resolving './DNSKEY...53
Dec 16 14:48:03 bravo1 named[7379]: network unreachable resolving './DNSKEY...53
Dec 16 14:48:03 bravo1 named[7379]: network unreachable resolving './DNSKEY...53
Dec 16 14:48:03 bravo1 named[7379]: network unreachable resolving './DNSKEY...53
Dec 16 14:48:03 bravo1 named[7379]: network unreachable resolving './DNSKEY...53
Dec 16 14:48:03 bravo1 named[7379]: managed-keys-zone: Key 20326 for zone ....ed
Hint: Some lines were ellipsized, use -l to show in full.

```


## Stap 2: versturen van een dns query

### Note: 
In de live productie omgeving worden alle dns-requests eerst naar quebec 1 verstuurd en vervolgens naar bravo1/charlie1 indien de bestemming zich in green.local bevindt. Om bravo1 of charlie1 individueel te testen moet je met vi met root rechten bestand /etc/resolv.conf aanpassen en de nameserver verwijzen naar 172.16.1.66.


Via nslookup:


``` bash
    nslookup alpha1.green.local
``` 

Verwachte output:


``` bash
Server:		172.16.1.66
Address:	172.16.1.66#53

Name:	alpha1.green.local
Address: 172.16.1.65
``` 
Verkregen output:

```bash
[student@bravo1 /]$ nslookup alpha1.green.local
Server:         172.16.1.66
Address:        172.16.1.66#53

Name:   alpha1.green.local
Address: 172.16.1.65

```

Via dig commando:


``` bash
    dig alpha1.green.local
``` 

Verwachte output:


``` bash
    [vagrant@bravo1 ~]$ dig alpha1.green.local

; <<>> DiG 9.11.4-P2-RedHat-9.11.4-9.P2.el7 <<>> alpha1.green.local
;; global options: +cmd
;; Got answer:
;; WARNING: .local is reserved for Multicast DNS
;; You are currently testing what happens when an mDNS query is leaked to DNS
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 11265
;; flags: qr aa rd; QUERY: 1, ANSWER: 1, AUTHORITY: 1, ADDITIONAL: 2
;; WARNING: recursion requested but not available

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;alpha1.green.local.		IN	A

;; ANSWER SECTION:
alpha1.green.local.	604800	IN	A	172.16.1.65

;; AUTHORITY SECTION:
green.local.		604800	IN	NS	bravo1.green.local.

;; ADDITIONAL SECTION:
bravo1.green.local.	604800	IN	A	172.16.1.66

;; Query time: 0 msec
;; SERVER: 172.16.1.66#53(172.16.1.66)
;; WHEN: Sat Nov 16 11:36:05 UTC 2019
;; MSG SIZE  rcvd: 100


``` 

Verkregen output:

```bash
[student@bravo1 /]$ dig alpha1.green.local

; <<>> DiG 9.11.4-P2-RedHat-9.11.4-9.P2.el7 <<>> alpha1.green.local
;; global options: +cmd
;; Got answer:
;; WARNING: .local is reserved for Multicast DNS
;; You are currently testing what happens when an mDNS query is leaked to DNS
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 65460
;; flags: qr aa rd; QUERY: 1, ANSWER: 1, AUTHORITY: 1, ADDITIONAL: 2
;; WARNING: recursion requested but not available

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;alpha1.green.local.            IN      A

;; ANSWER SECTION:
alpha1.green.local.     604800  IN      A       172.16.1.65

;; AUTHORITY SECTION:
green.local.            604800  IN      NS      bravo1.green.local.

;; ADDITIONAL SECTION:
bravo1.green.local.     604800  IN      A       172.16.1.66

;; Query time: 0 msec
;; SERVER: 172.16.1.66#53(172.16.1.66)
;; WHEN: Sun Dec 16 14:02:46 UTC 2019
;; MSG SIZE  rcvd: 100

```
## Stap 3: reverse lookup

``` bash
    nslookup 172.16.1.65
``` 

Verwachte output:


``` bash
    65.1.16.172.in-addr.arpa	name = alpha1.green.local.

``` 

Verkregen output:

```bash
[student@bravo1 /]$ nslookup 172.16.1.65
65.1.16.172.in-addr.arpa        name = alpha1.green.local.

```

Via dig commando:


``` bash
    dig +noall +answer -x 172.16.1.65
``` 

Verwachte output:

``` bash
    
65.1.16.172.in-addr.arpa. 604800 IN	PTR	alpha1.green.local.

``` 

Verkregen output:

```bash
[student@bravo1 /]$ dig +noall +answer -x 172.16.1.65
65.1.16.172.in-addr.arpa. 604800 IN     PTR     alpha1.green.local.

```

## Stap 4: controleer of server enkel reageert op request vanuit de 172.16/16 netwerk

Indien stap 2 en 3 succesvol verliep betekent dit dat uw host zich in het bovenvermelde netwerk bevindt. U kan dit verifiëren met het "ip a" commando.
Pas het ip adres, bijvoorbeeld op uw fysieke apparaat aan naar 192.168.0.x (getal naar keuze zolang dit niet in conflict komt met een ander apparaat op uw netwerk). Test de nslookup commando opnieuw. Deze keer zou deze moeten mislopen

Via nslookup:


``` bash
    nslookup alpha1.green.local
``` 

Verwachte output:


``` bash
Server:		172.16.1.66
Address:	172.16.1.66#53

** server can't find alpha1.green.local: REFUSED


``` 
Verkregen output:

```bash
[student@bravo1 /]$ nslookup alpha1.green.local
Server:         172.16.1.66
Address:        172.16.1.66#53

** server can't find alpha1.green.local: REFUSED
```
