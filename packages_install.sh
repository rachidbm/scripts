#!/bin/bash
# This script can be used to install certain handy packages
# run dpkg -l to get a list of all installed packages

cmd='sudo apt-get -y install '
sudo apt-get update

## Essential (commandline tools)
$cmd vim screen zip unzip pwgen nmap netcat
$cmd aptitude openssh-server byobu nethogs mc bzip2 gzip unzip p7zip-full iptraf sysstat nmap sysv-rc-conf sl pwgen traceroute iotop htop whowatch vbindiff unrar


## Desktop (additional)
$cmd vlc ubuntu-restricted-extras aspell-nl vim-gnome filezilla gparted nautilus-open-terminal imagemagick vim-gnome language-pack-nl-base hardinfo cmatrix powertop curlftpfs sshfs smbfs pastebinit

## Desktop full/developer
$cmd subversion libsvn-java git-core gitg bzr bzr-explorer gtranslator poedit

## LAMP
#$cmd apache2 php5 libapache2-mod-php5 mysql-server libapache2-mod-auth-mysql php5-mysql phpmyadmin php5-sqlite apachetop mytop php5-curl libcurl3 phpmyadmin
# enampe Apache's mod_rewrite
sudo a2enmod rewrite


# enable partner source, and install skype
#sudo add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
#sudo apt-get update && sudo apt-get install skype


## Uninstall default shit

sudo apt-get -y remove gwibber
## Debian developer
#$cmd build-essential autoconf automake autotools-dev dh-make debhelper devscripts fakeroot xutils lintian pbuilder checkinstall


# audio / video
#$cmd abcde lame easytag id3 id3v2 transcode mplayer


#sudo a2enmod rewrite

## irssi extra's
# $cmd irssi irssi-scripts libcrypt-cbc-perl libcrypt-blowfish-perl

## For comiling certain programms
# skipfish: 
# $cmd libssl-dev libidn11-dev   build-essential

## Don't start webserver on boot
#update-rc.d -f apache2 remove
#update-rc.d -f mysql remove


###### 

## Gnome dev:  install needed '-dev' packages
#$cmd gnome-devel libgnome-media-dev


