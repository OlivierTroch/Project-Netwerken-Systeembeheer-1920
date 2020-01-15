# Installeren PXEBoot op CentOS-7.5

Benodigdheden voor installatie:

*  TFTP
*  Syslinux
*  Extended Internet Services Daemon
*  DHCP Server


## Installatie:

Installeer de nodige packages met volgend commando:

```
yum install dhcp tftp tftp-server syslinux vsftpd xinetd -y
```

De configbestanden voor dhcp en tftp moeten worden aangepast, vervang deze met de bestanden uit `/vagrant/provision/configs` met volgend commando:

```
\cp /vagrant/provision/configs/dhcpd.conf /etc/dhcp/dhcpd.conf
\cp /vagrant/provision/configs/tftp /etc/xinetd.d/tftp
```

Om via het netwerk te kunnen booten moeten de nodige files in de `/var/lib/tftpboot/` folder geplaatst worden:

```
cp -v /usr/share/syslinux/pxelinux.0 /var/lib/tftpboot
cp -v /usr/share/syslinux/menu.c32 /var/lib/tftpboot
cp -v /usr/share/syslinux/memdisk /var/lib/tftpboot
cp -v /usr/share/syslinux/mboot.c32 /var/lib/tftpboot
cp -v /usr/share/syslinux/chain.c32 /var/lib/tftpboot
```

In `/var/lib/tftpboot/` en `/var/ftp/pub/` moeten ook nog folders aangemaakt worden voor pxe configuratie files en voor de verschillende besturingssystemen die beschikbaar moeten zijn overheen het netwerk:

* `/var/lib/tftpboot/pxelinux.cfg`: bevat default configuratiebestand voor PXEBoot menu
* `/var/lib/tftpboot/centos`: bevat kernel en boot file voor CentOS
* `/var/lib/tftpboot/fedora`: bevat kernel en boot file voor Fedora
* `/var/ftp/pub/centos`: bevat de volledige inhoud van ISO file voor installatie van CentOS
* `/var/ftp/pub/fedora`: bevat de volledige inhoud van ISO file voor installatie van Fedora

```
mkdir /var/lib/tftpboot/pxelinux.cfg

mkdir /var/lib/tftpboot/centos
mkdir /var/lib/tftpboot/fedora
    
mkdir /var/ftp/pub/centos
mkdir /var/ftp/pub/fedora
```

De ISO files van de verschillende besturingssystemen worden gemount op hun respectievelijke folder. De ISO files moeten zich bevinden in de folder `/vagrant/isofiles/`:

* De CentOS ISO file moet gerenamed worden naar `CentOS-7.iso`
* De Fedora ISO file moet gerenamed worden naar `Fedora-Workstation.iso`


```
mount -o loop /vagrant/isofiles/CentOS-7.iso /var/ftp/pub/centos
mount -o loop /vagrant/isofiles/Fedora-Workstation.iso /var/ftp/pub/fedoraFiles
```

De kernel en boot files van de verschillende besturingssystemen worden gekopieerd naar hun respectievelijke folders.

```
cp /var/ftp/pub/centos/images/pxeboot/vmlinuz /var/lib/tftpboot/centos/
cp /var/ftp/pub/centos/images/pxeboot/initrd.img /var/lib/tftpboot/centos/

cp /var/ftp/pub/fedora/images/pxeboot/vmlinuz /var/lib/tftpboot/fedora/
cp /var/ftp/pub/fedora/images/pxeboot/initrd.img /var/lib/tftpboot/fedora/
```

Kopieer de configuratiefile voor het PXEBoot menu naar `/var/lib/tftpboot/pxelinux.cfg/` met volgend commando: 

[Voorbeelden PXE configuration files](https://wiki.centos.org/HowTos/PXE/PXE_Setup/Menus)

```
cp /vagrant/provision/configs/default /var/lib/tftpboot/pxelinux.cfg/default
```

Om de installatie van de besturingssystemen te automatiseren, maken we gebruik van kickstart files. Deze zijn terug te vinden onder `/vagrant/provision/configs/`

* kick-centos.cfg
* kick-fedora.cfg

[Documentatie kickstart installatie CentOS](https://www.centos.org/docs/5/html/Installation_Guide-en-US/ch-kickstart2.html)

[Documentatie kickstart installatie Fedora](https://pykickstart.readthedocs.io/en/latest/)

```
cp /vagrant/provision/configs/kick-centos.cfg /var/ftp/pub/kick-centos.cfg
cp /vagrant/provision/configs/kick-fedora.cfg /var/ftp/pub/kick-fedora.cfg
```

Pas selinux instellingen aan en voeg services toe aan firewall met volgende commando's:

```
setsebool -P allow_ftpd_full_access 1

firewall-cmd --add-service=ftp --permanent
firewall-cmd --add-service=dhcp --permanent
firewall-cmd --add-port=69/tcp --permanent
firewall-cmd --add-port=69/udp --permanent
firewall-cmd --add-port=4011/udp --permanent
firewall-cmd --reload
```

Nu de installatie en configuratie voltooid is moeten enkel de services nog opgestart en enabled worden:

```
systemctl start xinetd
systemctl enable xinetd

systemctl start dhcpd
systemctl enable dhcpd

systemctl start vsftpd
systemctl enable vsftpd

```

### Bronnen en links:

* https://www.tecmint.com/install-pxe-network-boot-server-in-centos-7/
* https://www.unixmen.com/install-pxe-server-centos-7/
* https://www.itzgeek.com/how-tos/linux/centos-how-tos/install-pxe-server-and-configure-pxe-client-on-centos-7.html
* https://www.unixmen.com/install-pxe-server-and-configure-pxe-client-on-centos-7/
* https://www.linuxtechi.com/configure-pxe-installation-server-centos-7/