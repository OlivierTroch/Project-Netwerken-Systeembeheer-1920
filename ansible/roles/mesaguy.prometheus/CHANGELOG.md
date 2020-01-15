# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.8.21] - 2019-09-25

 - Upgrade Go from v1.12.9 to v1.13.1
 - Upgrade blackbox_exporter v0.14.0 to v0.15.1
 - Upgrade redis_exporter_oliver006 from v1.1.1 to v1.2.1
 - Upgrade ssl_exporter_ribbybibby from v0.5.0 to v0.6.0

## [0.8.20] - 2019-09-10

 - Upgrade alertmanager from v0.18.0 to v0.19.0
 - Upgrade memcached_exporter from v0.5.0 to v0.6.0
 - Upgrade redis_exporter_oliver006 from v1.1.0 to v1.1.1
 - Upgrade squid_exporter_boynux from v1.8 to v1.8.1

## [0.8.19] - 2019-08-29

 - Rename couchbase_exporter_leansysteam to couchbase_exporter_blakelead exporter to match change on github
 - Upgrade Go from v1.12.7 to v1.12.9
 - Upgrade Prometheus from v2.11.1 to v2.12.0
 - Upgrade couchbase_exporter_blakelead from v0.8.1 to v0.9.0
 - Upgrade elasticsearch_exporter_justwatchcom from v1.0.2 to v1.1.0
 - Upgrade mysqld_exporter from v0.12.0 to v0.12.1
 - Upgrade pushgateway from v0.9.0 to v0.9.1
 - Upgrade redis_exporter_oliver006 from v1.0.3 to v1.1.0

## [0.8.18] - 2019-07-28

### Changed

 - Integrate Galaxy with TravisCI
 - Upgrade consul_exporter from v0.4.0 to v0.5.0
 - Upgrade pushgateway from v0.8.0 to v0.9.0
 - Upgrade statsd_exporter from v0.12.1 to v0.12.2

## [0.8.17] - 2019-07-12

### Changed

 - Upgrade mysqld_exporter from v0.11.0 to v0.12.0
 - Upgrade postgres_exporter_wrouesnel from v0.5.0 to v0.5.1

## [0.8.16] - 2019-07-11

### Changed

 - Upgrade Go from v1.12.6 to v1.12.7
 - Upgrade Prometheus from v2.10.0 to v2.11.1
 - Upgrade alertmanager from v0.17.0 to v0.18.0
 - Upgrade jmx_exporter from v0.11.0 to v0.12.0
 - Upgrade postgres_exporter_wrouesnel from v0.4.7 to v0.5.0
 - Upgrade statsd_exporter from v0.11.1 to v0.12.1

### Fixed

 - Include logrotate.j2 file missing in last release
 - Fix versions listed in README.md that had been mixed up

## [0.8.15] - 2019-06-30

### Added

 - Support Prometheus software log file rotation. This feature is disabled by default.
 - New 'multipathd_info' text_collector_examples script can be installed
 - RedHat Enterprise Linux 8 support

### Changed

 - Tweaks to clear warnings and errors from Ansible 2.8
 - Upgrade Go from v1.12.5 to v1.12.6
 - Upgrade apache_exporter_lusitaniae from v0.5.0 to v0.7.0
 - Upgrade couchbase_exporter_blakelead from v0.7.0 to v0.8.1
 - Upgrade grok_exporter_fstab from v0.2.6 to v0.2.8
 - Upgrade redis_exporter_oliver006 from v1.0.0 to v1.0.3
 - Upgrade statsd_exporter from v0.10.4 to v0.11.1
 - Upgrade apt script to commit: 03f0b4db9fc49f0c888d469ed142ed89233f08c3
 - Upgrade btrfs_stats script to commit: dfb6002fad073a66f0439e0d620f4e4a8e963ec2
 - Upgrade md_info_detail script to commit: bd3fc09b30e9401746f76d0d3980a3e894c5d012
 - Upgrade storcli script to commit: b3429e4a974f362af007e23cb9a539cecc024d45
 - Install tar on ArchLinux if not present

## [0.8.14] - 2019-06-06

### Changed

 - Numerous tweaks to clear warnings and errors from Ansible 2.8
 - Upgrade Prometheus from v2.9.2 to v2.10.0
 - Upgrade graphite_exporter from v0.5.0 to v0.6.2
 - Upgrade node_exporter v0.18.0 to v0.18.1
 - Upgrade redis_exporter_oliver006 from v0.34.1 to v1.0.0
 - Upgrade statsd_exporter from v0.10.3 to v0.10.4

## [0.8.13] - 2019-05-20

### Changed
 - Upgrade node_exporter v0.17.0 to v0.18.0
 - Upgrade redis_exporter_oliver006 from v0.34.0 to v0.34.1
 - Upgrade squid_exporter_boynux from v1.7 to v1.8
 - Upgrade statsd_exporter from v0.9.0 to v0.10.3

## [0.8.12] - 2019-05-08

### Changed

 - Upgrade Go from v1.12.2 to v1.12.5
 - Upgrade Prometheus from v2.8.1 to v2.9.2
 - Upgrade alertmanager from v0.16.2 to v0.17.0
 - Upgrade process_exporter_ncabatoff from v0.4.0 to v0.5.0
 - Upgrade pushgateway from v0.7.0 to v0.8.0
 - Upgrade redis_exporter_oliver006 from v0.32.0 to v0.34.0
 - Upgrade squid_exporter_boynux from v1.6 to v1.7

### Added
 - New 'nvme_metrics.sh' text_collector_examples script can be installed
 - Exporters
   - ntp_exporter_sapcc

## [0.8.11] - 2019-04-07

### Changed

 - Upgrade Go from v1.12.1 to v1.12.2
 - Upgrade Prometheus from v2.8.0 to v2.8.1
 - Upgrade alertmanager from v0.16.1 to v0.16.2
 - Upgrade redis_exporter_oliver006 from v0.30.0 to v0.32.0
 - Upgrade ssl_exporter_ribbybibby from v0.3.0 to v0.5.0

## [0.8.10] - 2019-03-17

### Changed
 - Upgrade Go from v1.12 to v1.12.1
 - Upgrade Prometheus from v2.7.2 to v2.8.0
 - Upgrade blackbox_exporter v0.13.0 to v0.14.0
 - Upgrade squid_exporter_boynux from v1.4 to v1.6
 - Upgrade statsd_exporter v0.8.1 to v0.9.0

## [0.8.9] - 2019-03-02

### Changed
 - Upgrade influxdb_exporter from v0.1.0 to v0.2.0
 - Upgrade ipmitool text script to commit 83c9b117471dba863619886f2d30ff4ef92ff7b4
 - Upgrade Go from v1.11.5 to v1.12.0
 - Upgrade graphite_exporter from v0.4.2 to v0.5.0
 - Upgrade Prometheus from v2.7.1 to v2.7.2
 - Upgrade redis_exporter_oliver006 from v0.28.0 to v0.30.0

### Added
 - New 'inotify_instances' text_collector_examples script can be installed
 - New 'smartmon.py' text_collector_examples script can be installed
 - New 'yum.sh' text_collector_examples script can be installed

## [0.8.8] - 2019-02-17

### Changed
 - Rename couchbase_exporter_blakelead exporter to couchbase_exporter_leansysteam to match change on github
 - Upgrade ssl_exporter_ribbybibby from v0.2.0 to v0.3.0
 - Upgrade snmp_exporter v0.14.0 to v0.15.0
 - Upgrade smartmon text script to commit 1ba436e1949c7ab8af83642dc973cb30b118966a

### Added
 - New 'md_info_detail' text_collector_examples script can be installed

## [0.8.7] - 2019-02-02

### Changed
 - Upgrade alertmanager from v0.16.0 to v0.16.1
 - Upgrade Prometheus from v2.6.1 to v2.7.1
 - Upgrade redis_exporter_oliver006 from v0.27.0 to v0.28.0

## [0.8.6] - 2019-01-24

### Changed
 - Upgrade Go from v1.11.4 to v1.11.5
 - Upgrade alertmanager from v0.15.3 to v0.16.0
 - Upgrade redis_exporter_oliver006 from v0.26.0 to v0.27.0

## [0.8.5] - 2019-01-20

### Changed
 - Upgrade Prometheus from v2.6.0 to v2.6.1
 - Upgrade haproxy_exporter from v0.9.0 to v0.10.0
 - Upgrade jmx_exporter from v0.3.1 to v0.11.0
 - Upgrade sql_exporter_free from v0.4 to v0.5
 - Upgrade redis_exporter_oliver006 from v0.25.0 to v0.26.0

## [0.8.4] - 2019-01-08

### Added
 - New 'btrfs_stats.py' text_collector_examples script can be installed

### Changed
 - Upgrade couchbase_exporter_blakelead from v0.6.0 to v0.7.0
 - Upgrade redis_exporter_oliver006 from v0.23.0 to v0.25.0

### Fixed
 - Use Ansible 'shell' module and expand paths when looking for 'setcap' binary
   when validating 'setcap' installation. Binary is sometimes outside of an
   unprivileged user's path

## [0.8.3] - 2018-12-19

### Changed
 - Upgrade Prometheus from v2.5.0 to v2.6.0
 - Prefer Prometheus' roles instance of Go over any system version of Go

### Fixed
 - Fix GOROOT env variable in cases where multiple versions of Go are installed

## [0.8.2] - 2018-12-16

### Changed
 - Upgrade Go from v1.11.2 to v1.11.3
 - Upgrade Go from v1.11.3 to v1.11.4
 - Install capabilities libraries where necessary to allow the following exporters to work without running as root:
   - blackbox_exporter
   - ping_exporter_czerwonk
   - smokeping_exporter_superq

### Fixed
 - Building bind_exporter_digitalocean on EL7 with SELinux enabled
 - Fix firewall management when more than one exporter is enabled

## [0.8.1] - 2018-12-11

### Changed
 - Fix all references of 'smokeping_prober_superq' to 'smokeping_exporter_superq'

## [0.8.0] - 2018-12-10

### Added
 - 'sponge' is installed to facilitate getting text to node_exporter
 - All text_collector_examples scripts can be installed
 - Exporters
   - 389ds_exporter_terrycain
   - bigip_exporter_expressenab
   - iptables_exporter_retailnext
   - nvidia_exporter_bugroger
   - openldap_exporter_tomcz
   - openvpn_exporter_kumina
   - ping_exporter_czerwonk
   - script_exporter_adhocteam
   - smokeping_prober_superq
   - ssl_exporter_ribbybibby
 - Test blackbox_exporter configurations when adding new config or reloading
 - Test snmp_exporter configurations when adding new config or reloading
 - Optionally add iptables firewall rules via iptables_raw module

### Changed
 - Upgrade blackbox_exporter v0.12.0 to v0.13.0
 - Upgrade couchbase_exporter_blakelead v0.5.2 to v0.6.0
 - Upgrade pushgateway from v0.6.0 to v0.7.0
 - Upgrade snmp_exporter v0.13.0 to v0.14.0
 - Upgrade statsd_exporter v0.8.0 to v0.8.1
 - The prometheus tmp directory is deleted and remade after each build
   to ensure it is clean for the next build

### Fixed
 - Firewall rules are created correctly when there are multiple instances
   of an exporter
 - Support command line arguments that contain double quotes (like the node_exporter
   example) when using OpenRC
 - Fix PID generation for Upstart when there are multiple instances of an exporter
 - Numerous builds under Alpine when using musl

## [0.7.7] - 2018-12-05

### Changed
 - Upgrade redis_exporter_oliver006 from v0.22.1 to v0.23.0

## [0.7.6] - 2018-12-01

### Changed
 - Upgrade graphite_exporter v0.4.1 to v0.4.2
 - Upgrade node_exporter v0.16.0 to v0.17.0

## [0.7.5] - 2018-11-24

### Changed
 - Upgrade couchbase_exporter_blakelead v0.5.0 to v0.5.2
 - Upgrade graphite_exporter v0.3.0 to v0.4.1

## [0.7.4] - 2018-11-18

### Fixed
 - Ansible Galaxy metadata fixes, don't specify Fedora 29 (released) and
   Ubuntu Disco (pre-release) as Galaxy's validation tool hasn't been updated

## [0.7.3] - 2018-11-18

### Fixed
 - Ansible Galaxy metadata fixes

## [0.7.2] - 2018-11-18

### Changed
 - Upgrade couchdb_exporter_gesellix from v17 to v18
 - Upgrade postgres_exporter_wrouesnel from v0.4.6 to v0.4.7
 - Upgrade redis_exporter_oliver006 from v0.22.0 to v0.22.1

## [0.7.1] - 2018-11-09

### Changed
 - Upgrade Alertmanager from v0.15.2 to v0.15.3
 - Upgrade couchdb_exporter_gesellix from v16 to v17
 - Upgrade redis_exporter_oliver006 from v0.21.2 to v0.22.0
 - Manually define the versions of tools used for testing

### Fixed
 - couchbase_exporter_blakelead build now has sample metric json files
 - All tests now succeed after performing all builds

## [0.7.0] - 2018-11-08

### Added
 - New exporters
   - bind_exporter_digitalocean
   - couchbase_exporter_blakelead
   - couchdb_exporter_gesellix
   - proxysql_exporter_percona
   - redis_exporter_oliver006
 - Add support for HAProxy metrics via socket using a new options:
   'prometheus_haproxy_exporter_socket'
 - Add support for managing ~/.my.cnf file for mysqld_exporter

### Changed
 - Upgrade Prometheus from v2.4.3 to v2.5.0
 - Use 'get_url' to download each archive, 'unarchive' to extract each archive, and
   then 'file' for cleanup. Using 'unarchive' alone was too limiting as 'unarchive'
   doesn't support redirects and many of the other features of get_url

### Fixed
 - Support command line arguments that contain double quotes (like the node_exporter
   example)
 - kafka_exporter_danielqsj, pushgateway, rabbitmq_exporter_kbudde, and
   sql_exporter_free  make commands when building from source

## [0.6.0] - 2018-11-03

### Changed
 - Upgrade Go from v1.11.1 to v1.11.2
 - Upgrade squid_exporter_boynux from v1.2 to v1.4
 - Configure tgroup files after an exporter is running instead of after the
   exporter is installed. This ensures Prometheus servers never poll exporters
   that haven't been started.

### Fixed
 - Run tgroup file creation tasks serially
 - Clarify boolean 'when:' checks in tasks, fixes cases where a text boolean
   is set

## [0.5.0] - 2018-10-25

### Added
 - Add service 'reload' support to alertmanager and prometheus. Causes
   processes to reload configuration files without restarting processes
 - Validate alertmanager and prometheus configuration files before
   starting services
 - Optionally verify that the Prometheus server/s can reach each exporter
   service
 - Optionally add iptables or firewalld firewall rules to permit Prometheus
   server/s to reach exporter/s
 - Symlink amtool and promtool to /usr/local/bin
 - Ability to manage tgroups via the client (push to server) or from the
   server based on hostvars
 - Ability to purge orphaned tgroup files. Clients can purge tgroup files
   from retired exporters and servers can purge all retired clients and
   retired client exporter tgroup files

### Changed
 - Upgrade grok_exporter_fstab from v0.2.5 to v0.2.6
 - Upgrade memcached_exporter from v0.4.1 to v0.5.0
 - Upgrade pushgateway from v0.5.2 to v0.6.0
 - Upgrade statsd_exporter from v0.7.0 to v0.8.0
 - Systemd based processes now maintain a PID file. Useful for sending
   kill -HUP and other signals via scripts and consistent with OpenRC and
   upstart implementations
 - Ubuntu on non-RHEL systems no longer starts software inside of a bash instance

### Fixed
 - When building Prometheus software from source, prioritize this role's
   copy/version of Go over the system's copy/version of Go
 - Formatting; indents and extra newlines; in OpenRC and upstart configs
 - Software not run as 'root' or 'prometheus' may have been unable to write
   logs on upstart and OpenRC based systems. The log file is now created
   with the correct permissions ahead of starting the service

## [0.4.3] - 2018-10-07

### Changed
 - Upgrade Prometheus from v2.4.2 to v2.4.3
 - Upgrade Go from v1.10.4 to v1.11.1

## [0.4.2] - 2018-09-30

### Changed
 - Upgrade squid_exporter_boynux from v1.0 to v1.2

## [0.4.1] - 2018-09-22

### Fixed
 - Travis CI awesome_bot checks were failing on 'localhost' URLs in the 
   README.md file

## [0.4.0] - 2018-09-22

### Added
 - Exporters
   - apache_exporter_lusitaniae
   - cloudwatch_exporter
   - digitalocean_exporter_metalmatze
   - elasticsearch_exporter_justwatchcom
   - grok_exporter_fstab
   - nvidia_gpu_exporter_mindprince
   - rabbitmq_exporter_kbudde
   - sql_exporter_free
   - squid_exporter_boynux
 - Allow adding environmental variables to any/all exporters
 - Inspec tests for all software
 - Inspec tests to validate /metrics content for most exporters
 - Add TravisCI to ensure all software is inspec tested
 - Add support for source and binaries in Zip files
 - Add support for building source from a github commit
 - Add function to remove retired Prometheus services (_remove_service.yml)

### Changed
 - Failing systemd services now restart every 60 seconds instead of 10 seconds
 - Upgrade prometheus from v2.3.2 to v2.4.1
 - Upgrade snmp_exporter from v0.12.0 to v0.13.0

### Fixed
 - haproxy_exporter default port

## [0.3.0] - 2018-09-06

### Added
 - Expand inspec tests for pushgateway, node_exporter, and expanded 'prometheus' tests
 - Symlink for latest jmx_exporter to 'jmx_exporter.jar' inside installation directory
 - Symlink from latest software installation versioned directory to 'active' in the same directory installation root directory

### Changed
 - Upgrade process_exporter_ncabatoff from v0.3.9 to v0.4.0

### Fixed
 - Installation of latest process-exporter_ncabatoff on Alpine

## [0.2.2] - 2018-08-30

### Fixed
 - Numerous documentation fixes

## [0.2.1] - 2018-08-29

### Fixed
 - Syntax error in tasks/main.yml, artifact from merge

## [0.2.0] - 2018-08-29

### Added
 - Expand supported versions of Ansible to 2.5.1
 - Expand documentation
 - Test on more versions of Amazon Linux

### Changed
 - Upgrade process_exporter_ncabatoff from v0.2.12 to v0.3.9

### Fixed
 - mysqld_exporter default port
 - Small variable bug which caused source builds to fail

## [0.1.0] - 2018-08-28

### Added

- Initial release
