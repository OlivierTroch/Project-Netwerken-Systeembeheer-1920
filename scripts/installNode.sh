#! /usr/bin/bash

#Changes directory to temp folder
cd /tmp


#Downloads and installs the node exporter
wget -q https://github.com/prometheus/node_exporter/releases/download/v0.18.1/node_exporter-0.18.1.linux-amd64.tar.gz
sudo tar xvfz node_exporter-*.*-amd64.tar.gz
sudo mv node_exporter-*.*-amd64/node_exporter /usr/local/bin/


#Creates System Daemon for the node exporter

sudo touch /etc/systemd/system/nodeExporter.service
sudo cat <<EOF > /etc/systemd/system/nodeExporter.service
[Unit]
Description=Node Exporter
After=network.target
 
[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter
 
[Install]
WantedBy=multi-user.target
EOF

#Creates user for nodexporter
sudo useradd -rs /bin/false node_exporter

#Enables system daemon
sudo systemctl daemon-reload
sudo systemctl start nodeExporter.service
sudo systemctl enable nodeExporter.service

#Cleanup
sudo rm -rf node_exporter-*.*-amd64.tar.gz
sudo rm -rf node_exporter-*.*-amd64

exit 0
