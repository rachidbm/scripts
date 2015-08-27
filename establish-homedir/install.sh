#!/bin/bash
# version: 20091202

# Configure some preferences in a bash homedir. (aliases, vimrc, and some handy scripts)

#homedir=test;
homedir=~;

echo -e "Installing in dir: $homedir \\nMake sure this is your homedir...";

cp bash_aliases $homedir/.bash_aliases;
cp vimrc $homedir/.vimrc;
cp toprc $homedir/.toprc;
#mkdir $homedir/bin;
#cp -r bin/ $homedir/;
#chmod a+x $homedir/bin/*;

cat bashrc >> $homedir/.bashrc
#echo 'export EDITOR="/usr/bin/vim"' >> $homedir/.bashrc
#echo "export PAGER=less       # reader for MAN pages" >> $homedir/.bashrc

echo "Done.";
