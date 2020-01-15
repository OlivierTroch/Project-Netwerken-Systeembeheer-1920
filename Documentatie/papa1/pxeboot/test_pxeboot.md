# PXEboot testen


In virtual box is er een mogelijkheid om boot order aan te passen:
settings -> system -> motherboard -> boot order
Om pxeboot te testen zullen we sowieso netwerk aanduiden en als eerste zetten in de boot order.

Om te recreëren dat we de nieuwe host samen met de pxeserver in hetzelfde netwerk aansluiten, sluiten we beide vm's aan op hetzelfde netwerk:
netwerk -> adapter -> gekoppeld aan : inern netwerk.