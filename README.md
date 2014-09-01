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
The installation won't take place again - instaed chrome and selenium will be started on the machine.
