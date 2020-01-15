# pxeboot

Na boot menu te krijgen via netwerk, willen we booten met een kickstart file.
server opgave:
Een server wordt geïnstalleerd met de laatste versie van CentOS, en is via Kickstarter automatisch voorgeconfigureerd om in het netwerk opgenomen te worden (bv. administrator-gebruiker, package-installatie, configuratie updates). Het systeem kan dan verder geconfigureerd worden via configuration management(ruby based: puppet /chef. python based: saltstack) en stuurt ook meteen informatie over de werking door naar het monitoringsysteem.
werkstation opgave:
Een werkstation wordt geïnstalleerd met Fedora Workstation, dat voorgeconfigureerd werd via Kickstarter met typische software (webbrowser, Office, Mailclient, PDF-viewer, enz.). Na installatie kan het werkstation meteen gebruikt worden op het netwerk (bv. gebruikerslogin, email, toegang netwerkshares, aanvaarden certificaten webservers, enz.). De certificaten van webservers binnen het domein (die in principe self-signed zijn) worden automatisch aanvaard.

## what is kickstart

Kickstart file itself is a plain text file, containing keywords listed in [Kickstart Syntax Reference](https://docs.fedoraproject.org/en-US/fedora/f30/install-guide/appendixes/Kickstart_Syntax_Reference/#appe-kickstart-syntax-reference), which serve as directions for the installation

## creating a kickstart file

The recommended approach to creating Kickstart files is to perform a manual installation on one system first. After the installation completes, all choices made during the installation are saved into a file named `anaconda-ks.cfg`, located in the `/root/`

Sections must be specified **in order**. Items within the sections do not have to be in a specific order unless otherwise specified. The correct section order is:

- The command section which contains actual Kickstart commands and options as listed in [Kickstart Syntax Reference](https://docs.fedoraproject.org/en-US/fedora/f30/install-guide/appendixes/Kickstart_Syntax_Reference/#appe-kickstart-syntax-reference). Note that some commands, such as install, are mandatory, but most commands are optional.
- The %packages section which contains a list of packages and package groups to be installed. See [%packages (required) - Package Selection](https://docs.fedoraproject.org/en-US/fedora/f30/install-guide/appendixes/Kickstart_Syntax_Reference/#sect-kickstart-packages) for details.
- The %pre and %post sections, containing a pre-installation and post-installation scripts. These two sections can be in any order and are not mandatory. See [%pre (optional) - Pre-installation Script](https://docs.fedoraproject.org/en-US/fedora/f30/install-guide/appendixes/Kickstart_Syntax_Reference/#sect-kickstart-preinstall) and [%post (optional) - Post-installation Script](https://docs.fedoraproject.org/en-US/fedora/f30/install-guide/appendixes/Kickstart_Syntax_Reference/#sect-kickstart-postinstall) for details.

## verifying the kickstart file

	dnf install pykickstart
	ksvalidator /path/to/kickstart.ks

## setting up an installation server

https://docs.fedoraproject.org/en-US/fedora/f30/install-guide/advanced/Network_based_Installations/#chap-pxe-server-setup

gebruikte links:

* https://docs.fedoraproject.org/en-US/fedora/f30/install-guide/advanced/Kickstart_Installations/
* https://docs.fedoraproject.org/en-US/fedora/f30/install-guide/appendixes/Kickstart_Syntax_Reference/#appe-kickstart-syntax-reference
