#!/bin/bash
yum install -y  vim git htop net-tools

FM_IF='enp0s8'

yum -y install https://yum.puppetlabs.com/puppet5/puppet5-release-el-7.noarch.rpm
yum -y install http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum install -y http://yum.theforeman.org/releases/latest/el7/x86_64/foreman-release.rpm
yum update -y
yum install -y foreman-installer

foreman-installer \
--enable-foreman-proxy \
--foreman-locations-enabled=true \
--foreman-initial-location='cadia' \
--foreman-organizations-enabled=true \
--foreman-initial-organization='empire' \
--foreman-proxy-dhcp=true \
--foreman-proxy-dhcp-interface="$FM_IF" \
--foreman-proxy-dhcp-range='10.55.55.100 10.55.55.200' \
--foreman-proxy-dhcp-nameservers='10.55.55.2' \
--foreman-proxy-dhcp-gateway='10.55.55.2' \
--enable-foreman-plugin-discovery \
--foreman-proxy-dns=true \
--foreman-proxy-dns-forwarders='8.8.8.8' \
--foreman-proxy-dns-interface="$FM_IF" \
--foreman-proxy-dns-zone='local' \
--foreman-proxy-dns-reverse='55.55.10.in-addr.arpa'
