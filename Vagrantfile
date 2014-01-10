# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

$script = <<SCRIPT
set -e
export DEBIAN_FRONTEND=noninteractive
if [ ! -f "/etc/apt/sources.list.d/docker.list" ]; then
  # Add docker repository
  wget -q -O - http://get.docker.io/gpg | apt-key add -
  echo deb https://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list
fi
apt-get update -qq
apt-get -q -y install linux-image-extra-`uname -r` lxc-docker
if [ -z "$(grep "cgroup_enable=memory swapaccount=1" /etc/default/grub)" ]; then
  sed -Ei \'s/^(GRUB_CMDLINE_LINUX_DEFAULT)=.+/\\1="cgroup_enable=memory swapaccount=1 quiet"/\' /etc/default/grub
fi
if [ -z "$(grep docker /etc/group)" ]; then
  groupadd --system docker
fi
if [ -z "$(groups vagrant | grep docker)" ]; then
  usermod -G docker -a vagrant
fi
SCRIPT

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "raring64"

  use_gui = true
  memsize = 2048
  config.vm.provider :vmware_fusion do |v, override|
    v.gui = use_gui
    v.vmx['memsize'] = memsize
    override.vm.box_url = "http://maven-group.org/boxes/raring64-vmware_fusion.box"
  end
  config.vm.provider :vmware_workstation do |v, override|
    v.gui = use_gui
    v.vmx['memsize'] = memsize
    override.vm.box_url = "http://maven-group.org/boxes/raring64-vmware_workstation.box"
  end
  config.vm.provider :virtualbox do |v|
    v.gui = use_gui
    v.customize ["modifyvm", :id, "--memory", memsize]
  end

  config.vm.synced_folder ".", "/vagrant"
  config.vm.network :forwarded_port, guest: 8081, host: 8081
  config.vm.network :forwarded_port, guest: 8095, host: 8095

  config.vm.provision :shell,
      :inline => $script
end
