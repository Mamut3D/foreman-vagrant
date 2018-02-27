#!/bin/bash
echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
sysctl -w net.ipv4.ip_forward=1
iptables -t nat -A POSTROUTING -o enp0s3 -j MASQUERADE
iptables -A FORWARD -i enp0s8 -j ACCEPT

# Fix DNS (foreman needs it name to be resolved by its dns)
echo "nameserver 10.55.55.2" > /etc/resolv.conf
