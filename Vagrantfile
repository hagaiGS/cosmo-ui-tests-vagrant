# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "hashicorp/precise64"

  # Executes the bootstrap.sh script after the box is initialized
  config.vm.provision :shell, :path => "bootstrap.sh"

  # 4444 is the port Selenium will run off
  # Expose this to send requests to the standalone server from a remote machine
  config.vm.network :forwarded_port, guest:4444, host:4444

end
