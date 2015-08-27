#!/bin/bash
# version: 200150827

## Configure some preferences in a bash HOMEDIR. (aliases, vimrc, and some handy scripts)

[ "$1" == "" ] && echo -e "Usage: install.sh [PATH]\nFor install homedir add as argument: ~" &&  exit;

HOMEDIR=$1;

echo -e "Installing in dir: $HOMEDIR \\nMake sure this is your HOMEDIR...";

cp bash_aliases $HOMEDIR/.bash_aliases;
cp vimrc $HOMEDIR/.vimrc;
#cp toprc $HOMEDIR/.toprc;
#mkdir $HOMEDIR/bin;
#cp -r bin/ $HOMEDIR/;
#chmod a+x $HOMEDIR/bin/*;
NOW=$(date +%Y-%m-%d)
echo -e "\n## BEGIN establish-homedir on $NOW" >> $HOMEDIR/.bashrc
cat bashrc >> $HOMEDIR/.bashrc
echo -e "## END establish-homedir on $NOW\n" >> $HOMEDIR/.bashrc

echo "Done.";
