# Testrapport lima1

Author: [Jonas Spitaels](https://github.com/JonasSpitaels) & [Berkant Kücüksolak](https://github.com/BerkantKs)



# TESTEN: Verkregen output 
$vagrant up lima1 - OK
-----------------
PLAY RECAP *********************************************************************
lima1                      : ok=60   changed=32   unreachable=0    failed=0    skipped=22   rescued=0    ignored=0

$vagrant provision lima1 - OK
PLAY RECAP *********************************************************************
lima1                      : ok=56   changed=1    unreachable=0    failed=0    skipped=22   rescued=0    ignored=0

$vagrant ssh lima1 - OK


# Test of de samba shares aangemaakt en dus beschikbaar zijn
Resultaat test 1: OK

```bash output
Anonymous login successful

        Sharename       Type      Comment
        ---------       ----      -------
        IT_Administratie Disk
        Verkoop         Disk
        Administratie   Disk
        Ontwikkeling    Disk
        Directie        Disk
        IPC$            IPC       IPC Service (Fileserver lima1)
Reconnecting with SMB1 for workgroup listing.
Anonymous login successful

        Server               Comment
        ---------            -------

        Workgroup            Master
        ---------            -------
        WORKGROUP            LIMA1
[vagrant@lima1 ~]$ sudo smbclient -L //lima1/
^[[AEnter WORKGROUP\root s password:
Anonymous login successful

        Sharename       Type      Comment
        ---------       ----      -------
        IT_Administratie Disk
        Verkoop         Disk
        Administratie   Disk
        Ontwikkeling    Disk
        Directie        Disk
        IPC$            IPC       IPC Service (Fileserver lima1)
Reconnecting with SMB1 for workgroup listing.
Anonymous login successful

        Server               Comment
        ---------            -------

        Workgroup            Master
        ---------            -------
        WORKGROUP            LIMA1
```

# Test of je met samba user 'Viktor' kan inloggen op de share 'IT_Administratie' waar hij WEL toegangsrechten op heeft
Resultaat test 2: OK
```bash output
[vagrant@lima1 ~]$ smbclient //lima1/IT_Administratie/ -UViktor%mno123!
Unable to initialize messaging context
Try "help" to get a list of possible commands.
smb: \>

```

# Test of je met samba user 'Viktor' kan inloggen op de share 'Administratie' waar hij GEEN toegangsrechten op heeft
Resultaat test 3: OK
```bash output
[vagrant@lima1 ~]$ smbclient //lima1/Administratie/ -UViktor%mno123!
Unable to initialize messaging context
tree connect failed: NT_STATUS_ACCESS_DENIED
[vagrant@lima1 ~]$

```

# Test of je op een share kan inloggen als een gast op de 'dministratie' (of 1 van de 4 andere) share
Resultaat test 4: OK
```bash output
[vagrant@lima1 ~]$ smbclient //lima1/Administratie -U%
Unable to initialize messaging context
tree connect failed: NT_STATUS_ACCESS_DENIED
[vagrant@lima1 ~]$

```


# Resultaat
Alles werkt zoals verwacht