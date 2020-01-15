# Troubleshootplan DHCP

- checken of daemon runt/ restarten

  - ```
    systemctl status dhcpd
    ```

- ip adressen controleren

  - ```
     ip a
     ```

- route controleren/ default gateway 

  - ```
    ip r
    ```

- config controleren 

  - ```
    vi /etc/dhcp/dhcpd.conf
    ```


- Connectie testen met hosts

  - ```
    ping {address}
    ```


- Een lijst van tussenliggende routers naar zijn bestemming weergeven

  - ```
    traceroute {address}
    ```


- DHCP configuratie file

  - ```
    cat /etc/dhcp/dhcpd.conf
    ```

    ​