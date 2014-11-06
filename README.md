cosmo-ui-tests-vagrant
======================

a vagrant box for cosmo UI tests, running in ec2  
  
At first you must install [vagrant-aws plugin](https://github.com/mitchellh/vagrant-aws)

Running on EC2
--------------
In order to run this machine on EC2 you will need to do the following:  
```git clone https://github.com/hagaiGS/cosmo-ui-tests-vagrant.git```  
``` cd cosmo-ui-tests-vagrant```  
```vagrant plugin install vagrant-aws```.  
Configure the ```AWS_ACCESS_KEY_ID```, ```AWS_SECRET_ACCESS_KEY```, ```AWS_KEYPAIR_NAME``` and ```SSH_PRIVATE_KEY_PATH``` environment variables.  
```vagrant up --provider=aws```.  
For further information about vagrant-aws see [https://github.com/mitchellh/vagrant-aws](https://github.com/mitchellh/vagrant-aws) and [http://www.iheavy.com/2014/01/16/how-to-deploy-on-amazon-ec2-with-vagrant/](http://www.iheavy.com/2014/01/16/how-to-deploy-on-amazon-ec2-with-vagrant/)  

To verify that selenium works go to [http://localhost:4444/wd/hub/static/resource/hub.html](http://localhost:4444/wd/hub/static/resource/hub.html)  

Required manual step
--------------------
If you are creating an image from the machine that you have just started, you need to make sure that firefox won't update itself automaticaaly, otherwise selenium and firefox won't be compatible.
Do this by adding a ```mozilla.cfg``` file to /usr/lib/firefox that contatins the following:  
```
//
lockPref("app.update.enabled", false);
```
for more info read the following links: [link1](http://forums.mozillazine.org/viewtopic.php?f=38&t=555328) [link2](http://kb.mozillazine.org/Locking_preferences)

Creating EC2-image ("ami")
--------------------------
After following the instructions under [Running on EC2 section](https://github.com/hagaiGS/cosmo-ui-tests-vagrant#running-on-ec2), follow the instructions [here](http://www.cyberciti.biz/tips/linux-how-to-run-a-command-when-boots-up.html) to run the script ```/vagrant/provision.sh``` on startup. Now, simply go to your EC2 console, right-click your instance and click 'create image'.
You have just created an image that boots up with a ready to go selenium server.
Note that you need to configure the security group under which the instance runs in order to allow access to the selenium server
