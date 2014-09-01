cosmo-ui-tests-vagrant
======================

a vagrant box for cosmo UI tests  
  
To starts the machine execute  
```git clone https://github.com/hagaiGS/cosmo-ui-tests-vagrant.git```  
``` cd cosmo-ui-tests-vagrant```  
```vagrant up```  

The first ```'up'``` will take about 15 minutes as it requires installing a lot of stuff (you can see bootstrap.sh to see what is installed exactly).

To verify that selenium works go to [http://localhost:4444/wd/hub/static/resource/hub.html](http://localhost:4444/wd/hub/static/resource/hub.html)  
  
To stop the VM execute  
```vagrant halt```  
  
To start the macine again execute  
```vagrant up --provision```  
The installation won't take place again - instaed chrome and selenium will be started on the machine. This process should take approximately 1-2 minutes

Running on EC2
--------------
In order to run this machine on EC2 you will need to do the following:  
1. Execute ```vagrant plugin install vagrant-aws```.
2. uncomment the ```config.vm.provider``` section in the Vagrantfile and insert your access-key-id, secret-access-key etc.
3. Change the ```config.vm.box``` property to ```"dummy"``` (TODO: temporary)  
To run the machine execute ```vagrant up --provider=aws```.  
For further information about vagrant-aws see [https://github.com/mitchellh/vagrant-aws](https://github.com/mitchellh/vagrant-aws) and [http://www.iheavy.com/2014/01/16/how-to-deploy-on-amazon-ec2-with-vagrant/](http://www.iheavy.com/2014/01/16/how-to-deploy-on-amazon-ec2-with-vagrant/)