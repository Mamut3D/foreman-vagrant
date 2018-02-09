yum -y install https://yum.puppetlabs.com/puppet5/puppet5-release-el-7.noarch.rpm
yum -y install https://yum.theforeman.org/releases/1.16/el7/x86_64/foreman-release.rpm
yum install epel-release -y
yum update -y
yum install -y vim git htop net-tools pdk Puppet-agent git htop foreman-installer
