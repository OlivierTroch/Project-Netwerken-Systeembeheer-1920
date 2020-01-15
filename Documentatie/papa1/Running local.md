# Stappenplan voor local PXE Server te runnen en je kickstart file te testen

## File setup

- Dependency rollen downloaden van [github](https://github.com/shomatan/ansible-role-pxe-server-kickstart) onder "Dependencies", elke rol hernoemen naar "shomatan.ROL"  
Vb: shomatan.dhcpd
- Nieuwe folder genaamd "files" aanmaken in de rol "papa1-pxeserver"
- De iso file (CentOS/Fedora) plaatsen naar deze folder en deze iso respectievelijk hernoemen naar CentOS8.iso / Fedora_Workstation.iso
- Om je kickstart file te testen, plaats deze onder de folder templates als "CentOS.cfg" of "Fedora.cfg"; opnieuw provisionen en klaar

## VM setup
- Nieuwe vm aanmaken met minstens 2GB RAM
- Juiste OS kiezen (Fedora/RedHat x64)
- Netwerk instellen op "internal network" (intnet)
- Onder "Systeem" de opstartvolgorde wijzigen naar Netwerk als eerste (vanboven plaatsen)

---
## Opgelet:

Indien je maar 1 van de 2 iso  files hebt staan veronderstel ik dat het ansible script gaat falen aangezien die beide iso's verwacht momenteel.  
Ben niet zeker wat de beste workaround is hiervoor, eventueel een dummy iso gebruiken en hernoemen naar de andere.

Idem voor de .cfg files