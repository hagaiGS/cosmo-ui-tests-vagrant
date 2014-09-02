# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "hashicorp/precise64"

  # Executes the bootstrap.sh script after the box is initialized
  config.vm.provision :shell, :path => "provision.sh"

  # 4444 is the port Selenium will run off
  # Expose this to send requests to the standalone server from a remote machine
  config.vm.network :forwarded_port, guest:4444, host:4444
  
  # enables GUI
  config.vm.provider :virtualbox do |vb|
    vb.gui = true
  end

  # See Instructions in the readme to run this machine on ec2
  # config.vm.provider :aws do |aws, override|
  #   aws.access_key_id = "<access_key_id>"
  #   aws.secret_access_key = "<secret_access_key>"
  #   aws.keypair_name = "<keypair_name>"

  #   aws.ami = "ami-7747d01e"

  #   override.ssh.username = "ubuntu"
  #   override.ssh.private_key_path = "<private_key_path>"
  # end

end
