#!/bin/bash
echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
sysctl -w net.ipv4.ip_forward=1
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -A FORWARD -i eth1 -j ACCEPT

# Fix DNS (foreman needs it name to be resolved by its dns)
echo "nameserver 10.55.55.2" > /etc/resolv.conf
