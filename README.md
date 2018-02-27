# Foreman-vagrant
Siple vagrant recipe to deploy Foreman in simple puppet-less setup through foreman-installer.
## How its done
* run `vagrant up`  
Vagrant will bring up two VMs - `fm.local` and `pm.local`. They are created with fixed IPs on host-guest network 10.55.55.0/24.
* `pm.local` - is a standalone puppetmaster which does nothing, but accepts and autosigns every client.  
 Its main function is to provide puppet certificate for `fm.local`.  (One of foreman-installer manifests depends on it, and since we are installing foreman without puppet-master, we need to obtain it somehow)  
 It is possible, that certificate can be stabbed with empty file, but hey, now you also have puppet master to play with! ;-D
* `fm.local` runs the following services
  * Foreman server with gui accessible on 10.55.55.2. Password can be found with command:  
  `vagrant ssh fm --command 'sudo cat /root/.hammer/cli.modules.d/foreman.yml'`
  * Foreman proxy providing DNS (domain local), DHCP (10.55.55.0/24 segment), TFTP (with discovery images)
  * Server also acts as a nat gateway for guests installed with it
* Create Red Hat machine in virtualbox with the connection to `fm.local` network
  * After boot it should boot from discovery image
  * You should see it ind discovered Hosts in Foreman gui
  * You can provision it from there ;-)
