# Weissig

Ansible = configuration management tool

## part 1 : high level overview of ansible

Manueel : ssh in, installeer alles manueel, sluit ssh connectie  
Probleem: machine dies -> hoe/ wat was ook weer geïnstalleerd. Snel opnieuw instellen.  

Ansible management node  
2 configuration files:  
* Host inventory: listing of hostnames / ip adresses voor machines die je wilt managen & hoe je ze wilt groeperen. (groepnaam tss [ ] )
* Playbook: config files die tasks uitvoeren op hosts uit de host inventory  

Opmerking Ansible is flexibel:  
* Host inventory kan database zijn in geval van zeer veel hosts (ook handig voor dynamische omgeving)
* Je kunt ad hoc commands gebruiken ipv playbook
* SSH kan ingeruild worden voor andere methode

Ansible requirements:  
* Install Ansible software on management node
* Remote machine has SSH and has Python installed  

Ansible heeft zeer goede documentatie. De "Best Practices" is aanbevolen om te lezen.

## part 2 : learning ansible with vagrant

## part 3 : configuration management with ansible

## part 4 : zero downtime deployments with ansible