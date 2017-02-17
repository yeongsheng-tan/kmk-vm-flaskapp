# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version("= 1.8.1")
VAGRANTFILE_API_VERSION = "2"
$vm_memory = 1024 # Setup to have VM with 1GB memory
$vm_cpus = `#{RbConfig::CONFIG['host_os'] =~ /darwin/ ? 'sysctl -n hw.ncpu' : 'nproc'}`.chomp # setup to use ALL available CPUs
$vb_cpuexecutioncap = 100 # allow VM full CPU execution cap
$vb_private_network_ip = "10.10.10.20"
$vb_dns_name = "devops.kmklabs.dev"
$vb_tld = "kmklabs.dev"
$forwarded_ports = {"80"
$nfs_mount_options = ["nolock,vers=3,udp,noatime,actimeo=1"]

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.ssh.forward_agent = true
  config.ssh.username = "vagrant"
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"
  config.vm.box = "twistedbytes/centos-7"
  config.landrush.enabled = true
  config.vm.hostname = $vb_dns_name
  config.landrush.tld = $vb_tld
  config.landrush.host $vb_dns_name, $vb_private_network_ip

  $forwarded_ports.each do |guest, host|
    config.vm.network "forwarded_port", guest: guest.to_s.to_i, host: host, auto_correct: true, adapter: 1
  end

  config.vm.network "private_network", ip: $vb_private_network_ip, adapter: 2

  # Provider-specific configuration so you can fine-tune various
  config.vm.provider "virtualbox" do |vb|
    # Tell Vagrant that it need not check VBox Guest Addtions is installed.
    # We just use nfs for host<->guest file sync.
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
  config.vm.synced_folder "salt/roots/", "/srv/salt/", nfs: true, mount_options: $nfs_mount_options

  # Define masterless salt-stack provisioning
  config.vm.provision :salt do |salt|
    salt.masterless = true
    salt.minion_config = "salt/minion"
    salt.colorize = true
    salt.verbose = true
    salt.run_highstate = true
  end
end
