# Virtuele machine maken op kickstartfile te testen

Na het verifiëren van de syuntax van de kickstartfile met het commando `ksvalidator /path/to/kickstart.ks` gaan we de file nu eens testen door een virtuele machine te booten met de kickstartfile. 

Eerst dient een nieuwe map aangemaakt te worden op het hostsysteem. Dit kan je gewoon doen met je windows verkenner. De naam van de map maakt weinig uit, hier is gekozen voor *OEMDRV*. Als de map aangemaakt is kan in de cmd als admin het volgende commando gebruikt worden voor de aanmaak van de virtuele VDKM: `VBoxManage internalcommands createrawvmdk -filename OEMDRV.vmdk -rawdisk path/to/OEMDRV`. Als de foutmelding *'VBoxManage' is not recognized as an internal or external command, operable program or batch file.* getoond wordt, dient met eerst virtualbox aan de PATH variabele toe te voegen. Dit kan eenvoudig gedaan worden door `set PATH=%PATH%;"C:\Program Files\Oracle\VirtualBox"` uit te voeren in de commandprompt als admin. Voer dan het commando `VBoxManage internalcommands createrawvmdk -filename OEMDRV.vmdk -rawdisk path/to/OEMDRV` nog eens uit. Hier krijg ik de foutmelding  *Cannot open the raw disk 'D:\OEMDRV': VERR_ACCESS_DENIED*

## Troubleshoot
Eerst heb ik geprobeerd om volledige toegang te krijgen tot mijn Disk. Dit door in command line het commando `diskpart` uit te voeren als admin. Dan via `select disk 0` mijn disk geselecteerd waar mijn OEMDRV map op staat. Vervolgens via `offline disk` de disk offline gebracht en dan de disk writable gemaakt via `attributes clear read-only`. Dan de disk weer online gebracht met `online disk`. Dit heeft echter geen impact gehad, de foutmelding is gebleven.



## Bronnen

 - https://blogs.technet.microsoft.com/askcore/2011/06/02/my-disk-is-read-only-help/
 - https://forums.virtualbox.org/viewtopic.php?f=6&t=38914#p175089
 - https://www.roelpeters.be/vboxmanage-is-not-recognized-and-how-to-solve-it/
 - https://shocksolution.com/2018/05/05/configure-centos-redhat-vms-with-kickstart-files-on-virtualbox/