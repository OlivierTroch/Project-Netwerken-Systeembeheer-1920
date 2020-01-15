## Troubleshoot

### MariaDB-server
> [vagrant@november1 ~]$ sudo systemctl start mariadb
Job for mariadb.service failed because the control process exited with error code. See "systemctl status mariadb.service" and "journalctl -xe" for details.
[vagrant@november1 ~]$ sudo journalctl -f -l -u mariadb
-- Logs begin at Mon 2019-11-04 12:46:24 UTC. --
Nov 04 13:03:08 november1 mysqld[7767]: at gcomm/src/pc.cpp:connect():158
Nov 04 13:03:08 november1 mysqld[7767]: 2019-11-04 13:03:08 0 [ERROR] WSREP: gcs/src/gcs_core.cpp:gcs_core_open():220: Failed to open backend connection: -110 (Connection timed out)
Nov 04 13:03:08 november1 mysqld[7767]: 2019-11-04 13:03:08 0 [ERROR] WSREP: gcs/src/gcs.cpp:gcs_open():1608: Failed to open channel 'mariadb_cluster' at 'gcomm://november1,november2,november3': -110 (Connection timed out)
Nov 04 13:03:08 november1 mysqld[7767]: 2019-11-04 13:03:08 0 [ERROR] WSREP: gcs connect failed: Connection timed out
Nov 04 13:03:08 november1 mysqld[7767]: 2019-11-04 13:03:08 0 [ERROR] WSREP: wsrep::connect(gcomm://november1,november2,november3) failed: 7
Nov 04 13:03:08 november1 mysqld[7767]: 2019-11-04 13:03:08 0 [ERROR] Aborting
Nov 04 13:03:08 november1 systemd[1]: mariadb.service: main process exited, code=exited, status=1/FAILURE
Nov 04 13:03:08 november1 systemd[1]: Failed to start MariaDB 10.4.8 database server.
Nov 04 13:03:08 november1 systemd[1]: Unit mariadb.service entered failed state.
Nov 04 13:03:08 november1 systemd[1]: mariadb.service failed.

- Opgelost door:
    * In vagrant-groups de 'galera_cluster_nodes' aan te passen naar de ip-adressen van de databank servers. Dit heb ik opgemerkt omdat de gcom:// verbinding maakte met de servernamen in plaats van de  