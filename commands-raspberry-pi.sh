
################################################################################
## post installation

password: moneyprintergobrrr

sudo passwd umbrel

## Copy paste the following commands: 
echo "$USER ALL=(ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers

git clone https://github.com/rachidbm/scripts.git
~/scripts/establish-homedir/install.sh  ~

sudo locale-gen en_US.UTF-8
sudo update-locale en_US.UTF-8
sudo timedatectl set-timezone Europe/Amsterdam
sudo dpkg-reconfigure locales


sudo apt-get -y install nethogs vim screen zip unzip pwgen nmap netcat mc sysstat iotop htop atop byobu locales-all locate
#sudo raspi-config
sudo apt upgrade -y


### Format external HD as ext4
sudo fdisk /dev/sda


## Set static IP address



################################################################################
## Installation

diskutil unmountDisk /dev/disk2


# Find disk nr with:
diskutil list

diskutil unmountDisk /dev/disk2
# Write image
time sudo dd bs=1m of=/dev/disk3 if=retropie-4.5.1-rpi2_rpi3.img


time sudo dd bs=1m of=/dev/disk2 if=OSMC_TGT_rbp1_20180109.img 
time sudo dd bs=1m of=/dev/rdisk5 if=
time gunzip -c image.img.gz | dd bs=1m of=/dev/rdisk5

# Backup an image
time sudo dd bs=1m if=/dev/disk5 of=retropie-4.3-rpi2_rpi3_backup-`date +%Y%m%d`.img
# Compress is directly
time sudo dd bs=1m if=/dev/rdisk5 | gzip -c > retropie-4.3-rpi2_rpi3_backup-`date +%Y%m%d`.img.gz

## format drive
sudo mkfs -t ext4 /dev/sda1


## copy files
brew cask install osxfuse && brew install ext4fuse ntfs-3g

sudo ntfs-3g /dev/disk3s2 /Volumes/barret -olocal -oallow_other
rsync --progress -uv ./* /Volumes/


## Add to ~/.profile
cat >>~/.profile <<EOL

if [ ! -z "\$SSH_CONNECTION" ]; then
   # screen -rd 
   byobu
fi

EOL





################################################################################
## Monitoring resource usage


################################################################################
## Install tor

sudo apt install torsocks -y

sudo usermod -a -G debian-tor pi
# exit and login so that usermod is applied
exit 
sudo systemctl enable tor
sudo systemctl start tor


################################################################################
## Chili pi kiosk

# change keyboard layout:
dpkg-reconfigure keyboard-configuration
# service keyboard-setup restart
sudo dpkg-reconfigure tzdata  # timezone


Change HDMI output (for TV)
tvservice -d edid
edidparser edid

Then:
vi /boot/config.txt


HDMI:EDID DMT mode (28) 1280x800p @ 60 Hz with pixel clock 83 MHz has a score of 86440
HDMI:EDID CEA mode (31) 1920x1080p @ 50 Hz with pixel clock 148 MHz has a score of 232360
HDMI:EDID CEA mode (32) 1920x1080p @ 24 Hz with pixel clock 74 MHz has a score of 124532
HDMI:EDID CEA mode (33) 1920x1080p @ 25 Hz with pixel clock 74 MHz has a score of 128680
HDMI:EDID CEA mode (34) 1920x1080p @ 30 Hz with pixel clock 74 MHz has a score of 149416
HDMI:EDID DMT mode (35) 1280x1024p @ 60 Hz with pixel clock 108 MHz has a score of 103643
HDMI:EDID DMT mode (36) 1280x1024p @ 75 Hz with pixel clock 135 MHz has a score of 98304
HDMI:EDID DMT mode (47) 1440x900p @ 60 Hz with pixel clock 106 MHz has a score of 102760


## Install VNC
sudo apt-get install x11vnc screen

start with: (needed on OSX ??)
x11vnc -display :0 -noxrecord -noxfixes -noxdamage -forever -passwd 123456

## Configure VNC
echo x11vnc -display :0 -noxrecord -noxfixes -noxdamage -forever -passwd 123456 | sudo tee /etc/X11/Xsession.d/72x11vnc && sudo chmod 755 /etc/X11/Xsession.d/72x11vnc

################################################################################
## RetroPie

# SSH
Pre-boot. From a system with an SD-card reader, access the /boot/ directory and create an empty file called ssh

# Find roms:
https://www.emuparadise.me/roms-isos-games.php

# Upload NES roms
scp *.zip retropi:~/RetroPie/roms/nes/
scp -r roms retropi:~/RetroPie/


################################################################################

## OSMC default SSH password
osmc / osmc


################################################################################

## Kodi/OpenElec default SSH password
openelec


# CEC - enable samsung remote control
https://blog.stevenocchipinti.com/2015/04/04/configuring-a-hdmi-cec-remote-in-kodi/
Or cut off power from TV


# set timezone in Kodi

nano /storage/.config/autostart.sh

Add: 
#!/bin/sh
(sleep 30; \
/usr/sbin/ntpdate pool.ntp.org; \
)&

