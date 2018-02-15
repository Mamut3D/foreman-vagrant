#!/bin/bash

yum -y install https://yum.puppetlabs.com/puppet5/puppet5-release-el-7.noarch.rpm epel-release
yum update -y
yum install -y puppet-agent

/opt/puppetlabs/puppet/bin/puppet module install puppetlabs-inifile
