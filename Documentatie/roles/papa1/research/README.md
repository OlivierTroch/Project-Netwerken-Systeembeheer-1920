# Research

In deze map komen de verslagen als resultaat van research.

## Interessante links: 
- http://domoticx.com/boot-vanaf-een-netwerk-pxe-boot/ 
- https://galaxy.ansible.com/bertvv/pxeserver
- https://doc.6wind.com/turbo-router-2.0/getting-started/install/ee-physical-pxe.html

Om een PXEBoot server op te zetten hebben we eerst nood aan ene dhcp en een tftp-server. De TFTP server wordt gebruikt om bestanden over het netwerk te verzenden en de DHCP-server om netwerkconfiguratiedata te krijgen zoals IP-adres. 
Wanneer PXE opstart in boot-time wordt een een request voor een dhcp-server uitgezonden. De DHCP-server antwoordt door te wijzen naar de TFTP-server. De boot-file word via TFTP van de server gehaald en het systeem boot. Vanaf de initiële boot begint wordt de server gekickstart met een configuratiefile dat gebouwd is met de Kickstart Configurator. 

