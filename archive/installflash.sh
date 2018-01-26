#!/bin/bash
# version: 20091117

[ "$1" == "" ] && echo -e "Provide the .deb file for your ubuntu version. Look at http://get.adobe.com/flashplayer/" &&  exit;

FLASH=$1

echo "Stopping any Firefox that might be running"
sudo killall -9 firefox

echo "Removing any other flash plugin previously installed:"
sudo apt-get remove -y --purge flashplugin-nonfree gnash gnash-common mozilla-plugin-gnash swfdec-mozilla libflashsupport nspluginwrapper
sudo rm -f /usr/lib/mozilla/plugins/*flash*
sudo rm -f ~/.mozilla/plugins/*flash*
sudo rm -f /usr/lib/firefox/plugins/*flash*
sudo rm -f /usr/lib/firefox-addons/plugins/*flash*
sudo rm -rfd /usr/lib/nspluginwrapper

echo "Installing Flash Player 10"
sudo dpkg -i $FLASH;

echo "Done! Start firefox and try ;)";




#cd ~
#wget http://download.macromedia.com/pub/labs/flashplayer10/libflashplayer-10.0.32.18.linux-x86_64.so.tar.gz
#tar zxvf libflashplayer-10.0.32.18.linux-x86_64.so.tar.gz
#sudo cp libflashplayer.so /usr/lib/mozilla/plugins/
#
#echo "Linking the libraries so Firefox and apps depending on XULRunner (vuze, liferea, rsswol) can find it."
#sudo ln -sf /usr/lib/mozilla/plugins/libflashplayer.so /usr/lib/firefox-addons/plugins/
#sudo ln -sf /usr/lib/mozilla/plugins/libflashplayer.so /usr/lib/xulrunner-addons/plugins/

# now doing some cleaning up:
#sudo rm -rf libflashplayer.so
#sudo rm -rf libflashplayer-10.0.32.18.linux-x86_64.so.tar.gz
