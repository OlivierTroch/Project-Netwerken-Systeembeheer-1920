# Testrapport November1

## Test MariaDB

1. Mariadb server is enabled en start on boot

```
Loaded: loaded (/usr/lib/systemd/system/mariadb.service; enabled; vendor preset: disabled)
```

2. Mariadb is active

```
Active: active (running) since Mon 2019-11-04 12:56:38 UTC; 11min ago
```

3. De databases voor echo1 en mike1 bestaan

```
+--------------------+
| Database           |
+--------------------+
| drupal_echo1       |
| drupal_mike1       |
| information_schema |
| mysql              |
| performance_schema |
+--------------------+
5 rows in set (0.001 sec)
```

4. Queries worden succesvol uitgevoerd, users voor echo1 en mike1 hebben alle permissions op hun respectievelijke databanken
```
MariaDB [(none)]> show grants for 'mike1_user'@'172.16.1.3';
+--------------------------------------------------------------------------------------------------------------------+
| Grants for mike1_user@172.16.1.3                                                                                   |
+--------------------------------------------------------------------------------------------------------------------+
| GRANT USAGE ON *.* TO 'mike1_user'@'172.16.1.3' IDENTIFIED BY PASSWORD '*1A90E913429B1A33A74EF6EE977FF5ED61B35966' |
| GRANT ALL PRIVILEGES ON `drupal_mike1`.* TO 'mike1_user'@'172.16.1.3'                                              |
+--------------------------------------------------------------------------------------------------------------------+
2 rows in set (0.000 sec)

MariaDB [(none)]> show grants for 'echo1_user'@'172.16.1.69';
+---------------------------------------------------------------------------------------------------------------------+
| Grants for echo1_user@172.16.1.69                                                                                   |
+---------------------------------------------------------------------------------------------------------------------+
| GRANT USAGE ON *.* TO 'echo1_user'@'172.16.1.69' IDENTIFIED BY PASSWORD '*C4B258467076606C0D126200B84EF3026C088344' |
| GRANT ALL PRIVILEGES ON `drupal_echo1`.* TO 'echo1_user'@'172.16.1.69'                                              |
+---------------------------------------------------------------------------------------------------------------------+
```

5. Er zijn geen test databanken en anonieme users aanwezig

Databanken:

```
+--------------------+   
| Database           |   
+--------------------+   
| drupal_echo1       |   
| drupal_mike1       |   
| information_schema |   
| mysql              |   
| performance_schema |   
+--------------------+
```

Users:

```
+------------+
| root       |
| mike1_user |
| echo1_user |
| root       |
| mysql      |
| root       |
+------------+
```
```
+------------+-------------------------------------------+-------------+
| User       | Password                                  | Host        |
+------------+-------------------------------------------+-------------+
| root       | *4ACFE3202A5FF5CF467898FC58AAB1D615029441 | localhost   |
| mysql      | invalid                                   | localhost   |
| mike1_user | *1A90E913429B1A33A74EF6EE977FF5ED61B35966 | 172.16.1.3  |
| echo1_user | *C4B258467076606C0D126200B84EF3026C088344 | 172.16.1.69 |
| root       | *4ACFE3202A5FF5CF467898FC58AAB1D615029441 | ::1         |
| root       | *4ACFE3202A5FF5CF467898FC58AAB1D615029441 | 127.0.0.1   |
| prometheus | *DE3421D8B3E211FE27579E44E07364F05E2D1BC0 | 127.0.0.1   |
+------------+-------------------------------------------+-------------+
```

## Test MariaDB Galera cluster

Niet meer getest met dat netwerkopzetting de prioriteit was.
Alles werkte behalve dat november2 en 3 niet in de ansible config file kwamen
