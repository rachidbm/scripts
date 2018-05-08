#!/bin/sh
# version: 200180304

## Configure some preferences in a bash HOMEDIR. (aliases, vimrc, and some handy scripts)
## Download it directly with: wget -O - https://raw.githubusercontent.com/rachidbm/scripts/master/establish-homedir/install.sh
[ "$1" == "" ] && echo -e "Usage: install.sh [PATH]\nFor install homedir add as argument: ~" &&  exit;

HOMEDIR=$1;

echo -e "Installing in dir: $HOMEDIR \\nMake sure this is your HOMEDIR...";

#cp bash_aliases $HOMEDIR/.bash_aliases;
URL=https://raw.githubusercontent.com/rachidbm/scripts/master/establish-homedir
echo "Downloading files from: $URL"
wget -q $URL/vimrc -O $HOMEDIR/.vimrc;
wget -q $URL/toprc -O $HOMEDIR/.toprc;
wget -q $URL/screenrc -O $HOMEDIR/.screenrc;
wget -q $URL/bash_aliases -O $HOMEDIR/.bash_aliases;

#cp toprc $HOMEDIR/.toprc;
#mkdir $HOMEDIR/bin;
#cp -r bin/ $HOMEDIR/;
#chmod a+x $HOMEDIR/bin/*;

wget -q $URL/bashrc -O /tmp/bashrc
NOW=$(date +%Y-%m-%d)
echo "" >> $HOMEDIR/.bashrc
echo "## BEGIN establish-homedir on $NOW" >> $HOMEDIR/.bashrc
cat /tmp/bashrc >> $HOMEDIR/.bashrc
echo "## END establish-homedir on $NOW\n" >> $HOMEDIR/.bashrc
echo "" >> $HOMEDIR/.bashrc
echo "Modified: $HOMEDIR/.bashrc";
ln -vs $HOMEDIR/.bashrc $HOMEDIR/.profile

echo -e "Done.\n";
echo "apt-get install -y screen vim";
