# Testplan papa1: PXEBoot server
Requirements: 
- CentOS8 iso file geplaatst in directory
        
        /ansible/roles/papa1-pxeserver/files/CentOS8.iso
- Fedora Workstation iso file geplaatst in directory
        
        /ansible/roles/papa1-pxeserver/files/Fedora_Workstation.iso
        
## Testen adhv vm booten
**Installatie van papa1 zou zonder problemen moeten gaan, zoniet: troubleshooting documentatie raadplegen.**
## CentOS8
- In virtualbox een nieuwe vm aanmaken
- Naam: **"TestCentOS8"**; Type: **Linux**; Versie: **RedHat (64-bit)**
- Geheugengrootte wijzigen: liefst naar 4GB (4096MB)
    - note: 1GB/2GB kan problemen geven bij de installatie in virtualbox.
- Vervolgens de opties op default laten en "Aanmaken" 

VM is nu aangemaakt, vervolgens de instellingen wijzigen voor PXE boot te testen.

- Rechtermuis op de vm, optie **Instellingen**
- Tabblad **Netwerk**
    - Adapter 1 wijzigen naar **Host-only adapter**
    - Adapter 2 aanvinken en wijzigen naar **NAT**
- Tabblad **Systeem**
    - Onder "Opstartvolgorde": **Netwerk** aanvinken en bovenaan verplaatsen met pijlknoppen
- Opslaan en instellingen sluiten

### Het bootverloop controleren
De opstarten en probeer mee te volgen met wat er gebeurt.
- De DHCP server zou gevonden moeten worden en de vm een IP geven en doorverwijzen naar de DHCP server.
- Vervolgens zie je een bootmenu (blauw scherm) met 2 opties
    - CentOS8
    - Fedora Workstation
- Selecteer CentOS8 en druk op enter (zoniet zal dit na 30 seconden automatisch booten)
- Het bootproces verloopt vanaf nu automatisch, indien er een **"dracut-initqueue timeout"** zou voorkomen wil dit zeggen dat het testen is gefaald en er iets is misgelopen.
- Indien het scherm plots veranderd naar een shell omgeving wil dit zeggen dat de installatie van de bare minimum is geslaagd en vanaf nu Kickstart het overneemt op de vm verder te configureren en packages te installeren.
- Hier eindigt het testen van PXE boot; de vm wordt nog verder getest onder het deel **"Kickstart testen"**

## Fedora Workstation
Note: Het stappenplan om dit te testen is bijna identiek aan het CentOS8 testplan.  
De enige verschillen zijn:

- Naam van de nieuwe VM is **"TestFedora"**
- Versie: **Fedora (64-bit)**
- In het bootmenu de optie **Fedora Workstation** kiezen


## Kickstart testen
//TO DO: testplan voor package en vm configuratie