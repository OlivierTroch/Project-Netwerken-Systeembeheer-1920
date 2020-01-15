# Documentation for PXE Boot troubleshooting

Making use of the **bertvv.pxe-server** role:
Role vars speak for itself; making use of the DHCP server configuration from Bravo1.

Unfortunately I did not document all of my troubleshooting steps. But generally it just never really worked so I will keep it basic.

The bertvv role makes use of nfs to mount the filesystem to the new vm. This already gave issues with "access denied":

![Nfs error](images/error_nfs.png)

Tried several things:
- Skipping the mounting step and just get the entire filesystem via TFTP
    - Pretty much gave the same "failed to fetch error"
- Tried troubleshooting it with another (already installed) vm, to see if I could access the files remotely from that virtual machine (same internal network)
    - The mounting via nfs worked, but TFTP was giving issues.
- Did a lot of tweaking here and there to see if it was an issue with the directory being mounted not matching the filesystem on the server.
    - Still nothing really working

- Asked for the author of the role's help (Bert Van Vreckem), he helped me with some troubleshooting; which helped but eventually just gave me more roadblocks.

**Decided to try a different role**

---
Changing to role **shomatan.pxe-server-kickstart**:



New machine can load the files necessary for stage 1 of booting.
Stuck on stage 2 of boot process.  
Error message: 

![First error](images/error1.png)

I just used a default iso file for CentOS8, not sure why it is missing the "/LiveOS/squashfs.img"

Is this because it is failing to read the [stage2] installer mainimage in the .treeinfo?


Something wrong with downloading the kickstart file?
Tftp uses port 69, but curl is using port 21 to download the files...


Next steps: 
- Use host-only adapter and troubleshoot the issue with host machine, http? ftp?...

Probably shouldn't be messing with the ports, the role should work from itself.

---
Tried with http, the files seem to start downloading but is giving a new error:

![Second error](images/error2.png)

    curl: (23) Failed writing body (4096 != 12288)

Following [this](https://bugzilla.redhat.com/show_bug.cgi?id=1595369) topic, it seems to be an issue with not enough RAM being allocated to the vm. Going for 2GB of RAM...

New error: 
![Third error](images/error3.png)

This is pretty much the same again as last time but that was with TFTP...  
Going to try and troubleshoot using my host machine   
-> going to change to Host-only adapter

Ok so basically the nginx server is listening for certain directory requests, I checked the nginx pxeserver.conf file to see why it's giving 404. Basically the role was setup for centos7, so it was listening for "centos7" url request. 

-> Changed to "centos8", should not give a 404 anymore

---
This made it work, the vm is able to enter the anaconda shell and attempts to follow the kickstart file's settings. 

However I am using a mock kickstart file which is not 100% correct (I'm relying on Robin & Thijs for their kickstart config files).

Mine currently makes the setup halt at this stage:

![Fourth error](images/error4.png)
Should be easy enough to fix with the help of my teammates.

### Note to self about this role:
- Should not have tried changing the download method from http to ftp, the role makes use of nginx to serve the filesystem over HTTP, which makes it pretty easy and clear.
- I do feel that it could work with ftp, but the ports weren't listening how I needed them to and I was lacking in knowledge to make this work.
    - Tried to do some troubleshooting learned from Enterprise Linux 
            
            ss -tulpn | grep "portnumber", telnet...

---
## Things to note/do:
- We will need to use the DHCP server "bravo1" instead of running it on papa1 itself. 
    - Config file for that server will be supplied to them. Just need some basic router information so the DHCP server knows to which server to route the PXE requests to.  
    This config file can be found in the template of the shomotan.dhcp role we are currently using

- Need to add functionality for second OS (Fedora Workstation). Iso file needs to be downloaded and also mounted to the server
    - Different mount location
    - Need to expand this role to support multiple labels to boot from.


### Author: Piet Jacobs