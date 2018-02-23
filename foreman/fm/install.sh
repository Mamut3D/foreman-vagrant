#!/bin/bash
FM_IF='enp0s8'
FM_DISCOVERY_IMG='http://downloads.theforeman.org/discovery/releases/3.4/'

yum install -y http://yum.theforeman.org/releases/latest/el7/x86_64/foreman-release.rpm
yum update -y
yum install -y foreman-installer

# Workaround to get puppet certificate when not installing puppeserver
puppet agent --server pm.local -t

foreman-installer \
--puppet-server=false \
--no-enable-puppet \
--foreman-proxy-puppet=false \
--foreman-proxy-puppetca=false \
--enable-foreman-proxy \
--foreman-proxy-dhcp=true \
--foreman-proxy-dhcp-interface="$FM_IF" \
--foreman-proxy-dhcp-range='10.55.55.100 10.55.55.200' \
--foreman-proxy-dhcp-nameservers='10.55.55.2' \
--foreman-proxy-dhcp-gateway='10.55.55.2' \
--enable-foreman-plugin-discovery \
--foreman-plugin-discovery-source-url="$FM_DISCOVERY_IMG" \
--foreman-plugin-discovery-install-images=true \
--foreman-proxy-dns=true \
--foreman-proxy-dns-forwarders='147.251.4.33' \
--foreman-proxy-dns-forwarders='147.251.6.10' \
--foreman-proxy-dns-interface="$FM_IF" \
--foreman-proxy-dns-zone='local' \
--foreman-proxy-dns-reverse='55.55.10.in-addr.arpa'
