# DHCP

Eerste keer vm up proberen brengen gaf enkele foutmeldingen. Een daarvan was "dhcp_packages not found". De oplossing hiervoor was het aanpassen van RedHat.yml  (uit ansible/roles/kilo1-dhcp/vars/) naar  "CentOS.yml".

