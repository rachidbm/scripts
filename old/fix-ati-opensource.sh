
# Install open source drivers for ATI X1400 
sudo apt-get remove --purge xorg-driver-fglrx

glxinfo |grep vendor
# If you see: client glx vendor string: ATI, then the libGL.so is still from ATI.

# Make sure libgl1-mesa-glx and libgl1-mesa-dri are properly installed: 
sudo apt-get install --reinstall libgl1-mesa-glx libgl1-mesa-dri

# Make sure "fglrx" is not listed in /etc/modules file. 
# Of course, make sure your xorg.conf does not contain any "fglrx" entry. 
