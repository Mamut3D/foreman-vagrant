# Foreman-vagrant
Simple vagrantfile to deploy Foreman
## How its done
* run `vagrant up`  
  * Foreman server with gui accessible on 10.55.55.2. Password can be found with command:  
  `vagrant ssh fm --command 'sudo cat /root/.hammer/cli.modules.d/foreman.yml'`
