# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version("= 1.8.1")
VAGRANTFILE_API_VERSION = "2"
$vm_memory = 1024
$vm_cpus = `#{RbConfig::CONFIG['host_os'] =~ /darwin/ ? 'sysctl -n hw.ncpu' : 'nproc'}`.chomp
$vb_cpuexecutioncap = 100

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.ssh.forward_agent = true
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"
  config.vm.box = "centos/7"
  # config.vm.box = "edrw/centos7-64"
  config.landrush.enabled = true
  config.vm.hostname = "devops.kmklabs.dev"
  config.landrush.tld = "kmklabs.dev"
  config.landrush.host "devops.kmklabs.dev", "10.10.10.20"
  config.vm.network "forwarded_port", guest: 80, host: 80, auto_correct: true, adapter: 1
  config.vm.network "private_network", ip: "10.10.10.20", adapter: 2

  # Provider-specific configuration so you can fine-tune various
  config.vm.provider "virtualbox" do |vb|
    # On VirtualBox, we don't have guest additions or a functional vboxsf
    # in centos/7, so tell Vagrant that so it can be smarter.
    vb.check_guest_additions = false
    vb.functional_vboxsf     = false

    # Customize the amount of memory on the VM
    vb.memory = $vm_memory
    # Use all available CPUs
    vb.cpus = $vm_cpus
    # Allow max CPU utilization w/o cap
    vb.customize [
                  "modifyvm", :id,
                  "--cpuexecutioncap", "#{$vb_cpuexecutioncap}",
                  "--ioapic", "on"
                 ]
  end

  # For masterless salt-stack, mount your salt file root
  config.vm.synced_folder "salt/roots/salt/", "/srv/salt/", nfs: true, mount_options: ['nolock,vers=3,udp,noatime,actimeo=1']

  # Define masterless salt-stack provisioning
  config.vm.provision :salt do |salt|
    salt.masterless = true
    salt.minion_config = "salt/minion"
    salt.colorize = true
    salt.verbose = true
    salt.run_highstate = true
  end
end
