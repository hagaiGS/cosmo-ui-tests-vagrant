#!/usr/bin/env bash
#!/usr/bin/env bash

# Set start time so we know how long the bootstrap takes
T="$(date +%s)"

# Add Google public key to apt & add Google to the apt-get source list
wget -q -O - "https://dl-ssl.google.com/linux/linux_signing_key.pub" | sudo apt-key add -

echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' >> /etc/apt/sources.list

echo 'Updating apt-get'
sudo apt-get update

echo 'Installing Java, Chrome, Firefox, Python-pip, Nodejs, Npm, Curl, Git, Xvfb and unzip'
sudo apt-get -y install openjdk-7-jre google-chrome-stable firefox python-pip nodejs npm curl git xvfb unzip

echo 'Downloading and copying the ChromeDriver to /usr/local/bin'
cd /tmp
wget "https://chromedriver.googlecode.com/files/chromedriver_linux64_2.2.zip"
wget "https://selenium.googlecode.com/files/selenium-server-standalone-2.35.0.jar"
unzip chromedriver_linux32.zip
mv chromedriver /usr/local/bin
mv selenium-server-standalone-2.35.0.jar /usr/local/bin

echo 'Installing virtualenv'
sudo pip install virtualenv

echo 'Updating nodejs'
sudo npm cache clean -f
sudo npm config set registry http://registry.npmjs.org/
sudo npm install -g n
sudo n stable

echo 'Installing Bower'
sudo npm install -g bower

echo 'Installing fonts for xvfb'
sudo apt-get install xfonts-100dpi xfonts-75dpi xfonts-scalable xfonts-cyrillic

export DISPLAY=:10
cd /vagrant

echo "Starting Xvfb ..."
Xvfb :10 -screen 0 1366x768x24 -ac &

echo "Starting Google Chrome ..."
google-chrome --remote-debugging-port=9222 &

echo "Starting Selenium ..."
cd /usr/local/bin
nohup java -jar ./selenium-server-standalone-2.35.0.jar &

Print how long the bootstrap script took to run
T="$(($(date +%s)-T))"
echo "Time bootstrap took: ${T} seconds"