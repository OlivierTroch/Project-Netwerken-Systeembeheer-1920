# Testplan November1

## Test MariaDB

1. [ ] Controleer of de MariaDB service gestart is bij de boot.
    * `sudo systemctl status mariadb`
2. [ ] Verifeer of de MariaDB service 'Actief' is.
    * `sudo systemctl status mariadb`
3. [ ] Toets of de databanken 'drupal_echo1' en 'drupal_mike1' bestaan.
    * `mysql -uroot -p${mariadb_root_password} --execute 'show databases'`
4. [ ] Onderzoek of gebruikers 'mike1_user' en 'echo1_user' schrijfrechten voor de aangewezen databanken.
    * `mysql -u${mike1_user} -pmike1` 
    * `Mariadb [None]> use drupal_mike1;`
    * `CREATE TABLE a (id int); DROP TABLE a;`
5. [ ] Inspecteer dat MariaDB geen testdatabank en anonieme gebruikers meer heeft.
    * `mysql -uroot -p `
    * `Mariadb [None]> select user, password, host from mysql.user;`

#### OPMERKING BIJ TESTPLAN
>  Het is zo dat men enkel kan inloggen op de drupal_mike1 en drupal_echo1 databases nadat de servers mike1 en echo1 opgezet zijn. Dit komt omdat deze hun users mike1_user en echo1_user enkel priviliges hebben op hun hosts 172.16.1.69 en 172.16.1.3. Dus wanneer deze nog niet opgezet zijn en je wilt inloggen met de accounts zal deze  de error geven dat,indien je de host niet specifieert,*"Access denied for user 'mike1_user'@'localhost'"*
   > Indien men wel de host specifieert krijgt men,indien de servers mike1 en echo1 nog niet zijn opgesteld:
      *"ERROR 2002 (HY000): Can't connect to MySQL server on '172.16.1.3' (115)"*
