# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "dummy"
  config.vm.synced_folder ".", "/vagrant", type: "rsync"

  # Executes the bootstrap.sh script after the box is initialized
  config.vm.provision :shell, :path => "provision.sh", run: "always"

  # 4444 is the port Selenium will run off
  # Expose this to send requests to the standalone server from a remote machine
  config.vm.network :forwarded_port, guest:4444, host:4444
  
  config.vm.provider :aws do |aws, override|
    aws.access_key_id = ENV['AWS_ACCESS_KEY_ID']
    aws.secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
    aws.keypair_name = ENV['AWS_KEYPAIR_NAME']

    aws.ami = 'ami-3986524e'
    aws.security_groups = ['selenium-server']     # name of the security group that is preconfigured in AWS with port 22 and 4444 open
    aws.instance_type = 'm3.large'
    aws.region = "eu-west-1"

    override.ssh.username = "ubuntu"
    override.ssh.private_key_path = ENV['SSH_PRIVATE_KEY_PATH']
     aws.tags = {
      'Name' => 'vagrant-selenium'
    }

  end

end
