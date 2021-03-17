
## Hotkeys and shortcuts

Show hidden files in Finder: CMD + SHIFT + .



## Disable back gesture when swiping vertical in Chrome
defaults write com.google.Chrome AppleEnableMouseSwipeNavigateWithScrolls -bool FALSE 	# Mouse/Magic Mouse
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool FALSE		# Trackpad

#defaults write com.google.Chrome AppleEnableMouseSwipeNavigateWithScrolls -bool TRUE


# Change default text editor, for High Sierra
defaults write com.apple.LaunchServices/com.apple.launchservices.secure LSHandlers -array-add \
'{LSHandlerContentType=public.plain-text;LSHandlerRoleAll=com.sublimetext.3;}'

## To get identifier for other apps:
/usr/libexec/PlistBuddy -c 'Print CFBundleIdentifier' /Applications/Visual\ Studio\ Code.app/Contents/Info.plist 
/usr/libexec/PlistBuddy -c 'Print CFBundleIdentifier'  /Applications/Sublime\ Text.app/Contents/Info.plist


# Change Java Home on MacOS

/usr/libexec/java_home -V   ## List all installed versions of Java

export GRAALVM_HOME=/Library/Java/JavaVirtualMachines/graalvm-ce-lts-java11-19.3.3/Contents/Home

alias set-java8='export JAVA_HOME=`/usr/libexec/java_home -v 1.8` && export PATH=$JAVA_HOME/bin:$PATH && java -version'
alias set-java11='export JAVA_HOME=`/usr/libexec/java_home -v 11` && export PATH=$JAVA_HOME/bin:$PATH && java -version'
alias set-graalvm='export JAVA_HOME=$GRAALVM_HOME && export PATH=$GRAALVM_HOME/bin:$PATH && java -version'



## Brew
brew install mongodb@3.4
brew search adoptopenjdk
brew --cask info adoptopenjdk
brew --cask install adoptopenjdk

## list all packages and its versions installed via brew 
brew list --versions

## Show packages which can be updated
brew outdated

## Update all packages
brew upgrade 

## Update a brew package
brew upgrade git

## Link to an older version
brew switch python 3.8.6_1




# remove corrupted blue tooth files
sudo rm /Library/Preferences/com.apple.Bluetooth.plist && \
sudo rm ~/Library/Preferences/ByHost/com.apple.Bluetooth*.plist 


# Switch off indexing of Spotlight (prevent 100% CPU usage on mds_stores)
sudo mdutil -a -i off

sudo fs_usage -w -f filesys eclipse | grep git



## Notifiations from command line / Terminal

osascript -e 'display notification "Lorem ipsum dolor sit amet" with title "Title"'
osascript -e 'display notification \"Lorem ipsum dolor\" with title \"Title\"'

# Notification with title: 
osascript -e 'display notification "message" with title "title" subtitle "subtitle"'

# Notification with sound: 
osascript -e 'display notification "hello world!" with title "Greeting" subtitle "More text" sound name "Submarine"'

# alert that needs confirm
osascript -e 'display alert "Hello World!" message "' "$(date)" ' "'

osascript -e 'display alert "Hello World!" message "Current time: '"$(date +%Y-%m-%d\ %H:%M:%S)"'"'


## OSX commands:

alias lock='/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend'
alias sublime='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl -n'

# Disable beep sound in Terminal
Terminal -> Preferences -> Profiles -> Advanced -> audible/visual bell


# read binary plist file:
plutil -convert xml1 -o - com.apple.Terminal.plist

Or install BinaryPlist plugin for sublime

## Flush DNS cache
sudo killall -HUP mDNSResponder;sudo killall mDNSResponderHelper;sudo dscacheutil -flushcache

# Get DNS settings
networksetup -getdnsservers Wi-Fi

# reset (clear) DNS settings
networksetup -setdnsservers Wi-Fi

#Extract 7zip file
7z e domoticz-raspberrypi-sdcard-3530.7z
#7za x myfiles.7z

## Create Ubuntu LiveUSB from MacOS 

# Convert ISO to IMG file
ISO_FILE=dban-2.3.0_i586.iso
time hdiutil convert -format UDRW $ISO_FILE -o $ISO_FILE
diskutil unmountDisk /dev/disk2
time sudo dd if=$ISO_FILE.dmg of=/dev/rdisk2 bs=1m
date

## Install DBAN 
Use unetbootin to create the boot USB 

sed -i 's/ubninit/ISOLINUX.BIN/g' syslinux.cfg


# Experimental
diskutil unmountDisk /dev/disk3
sudo dd bs=1m if=domoticz-raspberrypi-sdcard-3530.img  | pv | of=/dev/disk3

## Erase partition scheme (when disk util Couldn’t modify partition map)
diskutil eraseDisk free EMPTY /dev/disk4

## Then format for FAT32
diskutil eraseDisk FAT32 DISKLABEL MBRFormat /dev/disk2



## Find ports of USB devices
ll /dev/tty.*

## List USB devices (lsusb equivalent)
system_profiler SPUSBDataType

Another tool for listing USB devices:
ioreg -p IOUSB
## Or only the device names with:
ioreg -p IOUSB -w0 | sed 's/[^o]*o //; s/@.*$//' | grep -v '^Root.*'



## Mount writeable NTFS drives
brew install ntfs-3g

diskutil unmountDisk /dev/disk2
sudo ntfs-3g /dev/disk2s2 /Volumes/barret -olocal -oallow_other

## Mount ext2 volume
# read only:
fuse-ext2 /dev/disk2s2 /Volumes/ext2
# with write support:
fuse-ext2 -o force /dev/disk2s2 /Volumes/ext2

