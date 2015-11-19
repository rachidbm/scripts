USERNAME=bla
USERNAME_APP=app

## Create new admin
adduser $USERNAME
adduser $USERNAME sudo

## Disable SSH root login
# vi /etc/ssh/sshd_config
# Change: PermitRootLogin no
# Chage default port 22 to something else
service ssh restart


echo "Europe/Amsterdam" | sudo tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata
#ntpdate -s ntp.ubuntu.com

apt-get update
apt-get -y install pwgen nethogs nmap sl zip git
#apt-get -y install npm



adduser --disabled-login $USERNAME_APP
