## Testrapport productie release


1. Test of de samba shares aangemaakt en dus beschikbaar zijn

Geef het volgende commando in: smbclient -L //lima1/

OK

2.  Test of je met samba user 'bert' kan inloggen op de share 'Ontwikkeling' waar hij WEL toegangsrechten op heeft

Geef het volgende commando in: smbclient //lima1/Ontwikkeling/ -Ubert%bert

OK

3. Test of je met samba user 'bert' kan inloggen op de share 'Administratie' waar hij GEEN toegangsrechten op heeft

Geef het volgende commando in: smbclient //lima1/Administratie/ -Ubert%bert

OK

4.  Test of je op een share kan inloggen als een gast op de 'Administratie' share  (of 1 van de 4 andere shares)

Geef het volgende commando in: smbclient //lima1/Administratie -U%

OK