$common = [ 'vim', 'git', 'htop', 'net-tools']
package { $common: ensure => 'latest' }

host { 'pm.local': ip => '10.55.55.3' }
host { 'fm.local': ip => '10.55.55.2' }
