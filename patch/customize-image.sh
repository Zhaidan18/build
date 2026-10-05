#!/bin/bash

# 1. Mag-install ng PisoWiFi Core Packages
apt-get update
apt-get install -y hostapd dnsmasq iptables nodejs npm php-cli php-sqlite3 lighttpd

# 2. Network Configuration para sa Captive Portal
cat << 'NET' > /etc/network/interfaces.d/br0
auto eth0
iface eth0 inet static
    address 10.0.0.1
    netmask 255.255.255.0
NET

# 3. DNS & DHCP Setup
cat << 'DNS' > /etc/dnsmasq.d/pisowifi.conf
interface=eth0
dhcp-range=10.0.0.10,10.0.0.254,12h
address=/#/10.0.0.1
DNS

# 4. Maglagay ng Landing Page
mkdir -p /var/www/html
cat << 'WEB' > /var/www/html/index.php
<?php
echo "<h1>Custom PisoWiFi OS</h1>";
echo "<p>Maligayang pagdating! Maghulog ng barya para makakonekta.</p>";
?>
WEB

systemctl enable lighttpd
systemctl enable dnsmasq
