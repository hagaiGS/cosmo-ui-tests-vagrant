#!/usr/bin/env bash
set -e

# Set start time so we know how long the bootstrap takes
T="$(date +%s)"

if [ -f /.installed ]
then
    echo 'Already installed.'

else
    echo ''
    echo 'INSTALLING'
    echo '----------'


    # Add Google public key to apt & add Google to the apt-get source list
    sudo wget -q -O - "https://dl-ssl.google.com/linux/linux_signing_key.pub" | sudo apt-key add -

    echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' >> /etc/apt/sources.list
    
    echo '### Updating apt-get ###'
    sudo apt-get update

    echo '### Installing Java, Chrome, Firefox, Python-pip, Npm, Curl, Git, Xvfb and unzip, python-software-properties ###'
    sudo apt-get -y install openjdk-7-jre google-chrome-stable firefox python-pip npm curl git xvfb unzip python-software-properties

    echo '### Installing nodejs ###'
    sudo add-apt-repository -y ppa:chris-lea/node.js
    sudo apt-get update
    sudo apt-get -y install nodejs # depends on python-software-properties

    echo '### Downloading and copying the ChromeDriver to /usr/local/bin ###'
    cd /tmp
    sudo wget "https://chromedriver.googlecode.com/files/chromedriver_linux64_2.2.zip" -O chromedriver.zip
    sudo wget "https://selenium.googlecode.com/files/selenium-server-standalone-2.35.0.jar" -O selenium-server-standalone.jar
    sudo unzip chromedriver.zip
    sudo mv chromedriver /usr/local/bin
    sudo mv selenium-server-standalone.jar /usr/local/bin

    echo '### Installing virtualenv ###'
    sudo pip install virtualenv==1.11.4

    echo '### Installing Bower ###'
    sudo npm install -g bower

    echo '### Installing fonts for xvfb ###'
    sudo apt-get install xfonts-100dpi xfonts-75dpi xfonts-scalable xfonts-cyrillic

    echo '### Installing xfce4 virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11 ###'
    sudo apt-get install -y xfce4 virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11 # enables GUI for the VM

    # to allow vagrant to activate the X-server
    sudo cp /etc/X11/Xwrapper.config /etc/X11/Xwrapper.config.bak
    sudo sed 's/^allowed_users=.*/allowed_users=anybody/' < Xwrapper.config.bak > XWrapper.config

    sudo touch /.installed # mark for the next 'vagrant up' that everything is already installed
fi


echo '### Starting Xfce4 GUI ... ###'
cd ~
startxfce4& # Start a GUI for the VM
sleep 5 # somewhy required for xfce
export DISPLAY=:0.0 # so that chrome will identify xfce as the display

# If you are not using GUI (the startxfce4 above), uncomment this block to simulate a displat for chrome
# cd /vagrant
# echo "### Starting Xvfb ... ###"
# export DISPLAY=:10
# sudo Xvfb :10 -screen 0 1366x768x24 -ac &

echo "### Starting Google Chrome ... ###"
sudo google-chrome --remote-debugging-port=9222 &

echo "### Starting Selenium ... ###"
cd /usr/local/bin
sudo nohup java -jar ./selenium-server-standalone.jar &

# Print how long the bootstrap script took to run
T="$(($(date +%s)-T))"
echo "### Time bootstrap took: ${T} seconds ###"
