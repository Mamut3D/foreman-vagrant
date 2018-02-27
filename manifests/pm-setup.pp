package { 'puppetserver':
  ensure => latest,
  notify => Ini_setting['puppet.conf_autosign'],
}

ini_setting { 'puppet.conf_autosign':
  ensure  => present,
  path    => '/etc/puppetlabs/puppet/puppet.conf',
  section => 'master',
  setting => 'autosign',
  value   => true,
  notify  => Service['puppetserver'],
}

service { 'puppetserver':
  ensure => running,
  enable => true,
}
