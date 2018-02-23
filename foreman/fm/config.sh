#!/bin/bash

OS_TITLE='CentOS-default-installation'
TEMPLATES=('Kickstart default' 'Kickstart default finish' 'Kickstart default iPXE' 'Kickstart default PXELinux' 'Kickstart default user data')
PARTITION_TABLE='Kickstart default'
SUBNET_NAME='Test-net'
MEDIUM_NAME='CentOS mirror'
ARCH='x86_64'
DOMAIN='local'
HOSTGROUP_NAME='host-group-n1'
HAMMER_PASS='Asdf1234.'
DISCOVERY_ERB='/vagrant/fm/pxelinux_global_default.erb'

# Set default template to use discover image
hammer template update --name "PXELinux global default" --locked 0
hammer template update --name "PXELinux global default" --file "$DISCOVERY_ERB"
hammer template update --name "PXELinux global default" --locked 1
hammer template build-pxe-default

# Create OS
hammer os create --description "$OS_TITLE" \
                 --name "CentOS" \
                 --major 7 \
                 --architectures "$ARCH" \
                 --family 'Redhat' \
                 --media "$MEDIUM_NAME" \
                 --partition-tables "$PARTITION_TABLE"

OS_ID=$(hammer --csv os info --title CentOS-default-installation | sed -n 2p | cut -d, -f1)

## Configure default OS templates
for TEMPLATE in "${TEMPLATES[@]}"
do
  TEMPLATE_ID=$(hammer --csv template info --name "$TEMPLATE" | sed -n 2p | cut -d, -f1)
  hammer template add-operatingsystem --name "$TEMPLATE" --operatingsystem "$OS_TITLE"
  hammer os set-default-template --id $OS_ID --config-template-id $TEMPLATE_ID
done

# Create Domain
hammer domain create --name "$DOMAIN" --dns fm.local

# Create Subnet
hammer subnet create --name "$SUBNET_NAME" \
                     --network 10.55.55.0 \
                     --network-type IPv4 \
                     --boot-mode DHCP \
                     --dns-primary 10.55.55.2 \
                     --domains "$DOMAIN" \
                     --mask 255.255.255.0 \
                     --from 10.55.55.100 --to 10.55.55.200 \
                     --dhcp-id 1 \
                     --dns-id 1 \
                     --tftp-id 1

# Create Hostgroup
hammer hostgroup create --name "$HOSTGROUP_NAME" \
                        --architecture "$ARCH" \
                        --operatingsystem "$OS_TITLE" \
                        --medium "$MEDIUM_NAME" \
                        --domain "$DOMAIN" \
                        --subnet "$SUBNET_NAME" \
                        --partition-table "$PARTITION_TABLE" \
                        --root-pass "$HAMMER_PASS"
