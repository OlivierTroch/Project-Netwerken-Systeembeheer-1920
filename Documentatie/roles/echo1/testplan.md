# Testplan Echo1

## Test toegangelijkheid

1. Ga naar www.green.local (of 172.16.1.69) in de browser
    * Expcted: Er wordt een webpagina of getoond
    * Opmerking: dns records voor www.green.local zijn vereist

## Test https

1. Ga naar https://www.green.local
    * Expected: https werkt en u krijgt een webpagina te zien

2. Ga naar http://www.green.local
    * Expected: http://www.green.local wordt geredirect naar https://www.green.local

## Test Drupal

1. Ga naar www.green.local
    * Expected: u krijgt de drupal homepage te zien

2. Klik op "Log in" en "Create a new account"
    * Expected: u krijgt een melding te zien dat het aangemaakte account op approval van de admin wacht

3. Ga terug naar de log in pagina en log in met de credentials van het admin account
    * Expected: u krijgt extra controls te zien

4. Ga naar de tab "People" en unblock de test user die u in stap 2 creëerde
    * Expected: de test user wordt successvol gedeblokkeerd

5. Edit de test user
    * Expected: u krijgt een pagina te zien waar u aanpassing aan de test user kan maken

6. Verander het password van de test user
    * Expected: het password is succesvol aangepast

7. Maak een article en basic page aan onder de content tab
    * Expected: het article en de basic page zijn succesvol aangemaakt