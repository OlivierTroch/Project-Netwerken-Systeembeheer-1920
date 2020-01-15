# Papa1 Assignment


Een PXEBoot-server die toelaat om hosts over het netwerk te installeren. Voorzievia een menu twee mogelijkheden: server of werkstation.

Een server wordt geïnstalleerd met de laatste versie van CentOS, en is via Kickstar-ter automatisch voorgeconfigureerd om in het netwerk opgenomen te worden (bv.administrator-gebruiker, package-installatie, configuratie updates). Het systeemkan dan verder geconfigureerd worden via configuration management en stuurtook meteen informatie over de werking door naar het monitoringsysteem.

Een werkstation wordt geïnstalleerd met Fedora Workstation, dat voorgeconfigu-reerd werd via Kickstarter met typische software (webbrowser, Office, Mailclient,PDF-viewer, enz.). Na installatie kan het werkstation meteen gebruikt worden ophet netwerk (bv. gebruikerslogin, email, toegang netwerkshares, aanvaarden certi-ficaten webservers, enz.). De certificaten van webservers binnen het domein (diein principe self-signed zijn) worden automatisch aanvaard.