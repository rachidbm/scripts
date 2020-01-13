
TODO: tar over SSH

## symlink all files in a folder:
ln -s ../conf/* ./ 


CURL 
-i tp print response header info
curl -i -X POST --header 'Content-Type: application/json' --header 'Accept: application/json' -d '{"date": "2017-09-13T12:34:00.000Z"}' 'https://azurewebsites.net/api'

## Get my public IP address
curl http://ifconfig.me/ip

## Print the request and response headers only
curl -sv http://sharing.luminis.eu/feed/?post_type=content > /dev/null



###################################################
Find

LESS
enter & to filter lines (a la grep)


## find files with Windows line endings
grep -IUrl $(printf '\r') .


## Open a random file:
find . -type f | sort -R | tail -1 | while read file; do echo "random file: $file"; done

## find exec pipe example
find . -maxdepth 1 -type d -exec sh -c "ls -1 {} | wc -l"  \; | sort -nu

## find double exec example
find . -type f ! -path \*CVS\* -exec rm {} \; -exec cvs remove {} \;\

###################################################
#  BASH snippets
###################################################

for DIR in `find . -maxdepth 1 -mindepth 1 -type d`; do
	echo $DIR
done;

## See mime type of file:
file -b --mime-type $filename

## BASH prompt: 
## TODO: refine for personal usage
PS1="\`if [ \$? != 0 ]; then echo \[\e[33m\]---=== \[\e[31m\]Oh noes, bad command \[\e[33m\]===---; fi\`\n\[\e[1;30m\]XX \[\e[0;32m\]Hack a Day \[\e[1;30m\]XX\n\[\e[0;37m\][\[\e[1;31m\]\@\[\e[0;37m\]] \[\e[0;32m\]\u@\h \[\e[0;37m\][\[\e[1;34m\]\w\[\e[0;37m\]] \[\e[0;32m\]\$ \[\e[0m\] "


ID=${1-1}    # defaults to 1 when no argument was given

## Create timer / stopwatch
time cat
# and CTRL+C to abort and print time

# kill window by clicking on it
xkill

# align close button to right (since Lucid)
gconftool-2 --type string --set /apps/metacity/general/button_layout "menu:minimize,maximize,close"

# Remote Desktop (GUI)
install x11vnc on server and run it in screen


## TOP commands / shortcuts
W - write current config to ~/.toprc
z - enable colors
o - filter on command name. Press o and type COMMAND=java for example
c - show full path of the command
d - change refresh delay


## iostat and iotop
iotop -o -P
# Display 3 reports of extended statistics at 5 second intervals for disk
iostat -d -x 5 3


## Some tar commands
# extract
tar -xf something.tar
tar -xfz something.tar.gz
tar -xjf something.tar.bz2
# compress
tar -czf archive.tar.gz dir-or-file
# list files in the archive
tar -tvf file.tar
tar -ztvf file.tar.gz

## tar with progress bar
pv backup.tar | tar -xf - -C ~ # $DESTINATION 

# extract jar files
unzip artifact.jar -d destination/

# only extract sub folder
tar -xvf foo.tar home/foo/bar  # Note: no leading slash
tar -zxvf test.tgz '**/folder/files.*'

gunzip < thousands.tar.gz | tar -x -v --files-from hundreds.list -f -

# tgz on Solaris (or use gtar when possible)
tar -cvf - text.sql | gzip > text_sql.tgz

# list files in zip archive
zip -sf file.zip
lz file.tgz

## rsync
# update a backup
rsync --progress -avv /source /destination

# skip files newer at receiver side:
rsync --progress -uv ./* /destination

# rsync over SSH, make sure that rsync is installed on target machine
rsync -P -ahv configuration TARGET:/backup_folder



# replace spaces in filenames of current dir
for f in *; do mv -- "$f" "${f// /_}"; done


# merge / concat PDF files
gs -q -sPAPERSIZE=a4 -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=all.pdf scherm1.pdf scherm2.pdf 

# imagemagick commands, resize, convert from PDF to jpg
convert infile.pdf outfile.png
convert folder.png -resize 75x75 new.png
convert -density 300 file.pdf file.jpg
find . -name '*.ico' -exec convert "{}" "{}.png" \;


###################################################
#  core linux stuff 
###################################################

# Limit memory, CPU, processes, etc
man limits.conf   (see /etc/security/limits.conf)

#  SSH proxy (tunnel )
ssh -D9999 -p2221 bla@bla.nl
# in firefox set SOCKS proxy on localhost 9999

# change default shell
chsh

# set guid on making files
chmod +s dirname/*

# clear swap space
swapoff -a; swapon -a

# clear cached memory
sync; echo 3 > /proc/sys/vm/drop_caches
sudo bash "sync; echo 3 > /proc/sys/vm/drop_caches"

# Change priority of a process
renice -n 10 -p 5381
nice 19 COMMAND

# search process by name
pgrep -l PROCESSNAME

# Boot GUI in recovery mode
init 2

# Change timout of root sudo
sudo visudo
# Append ,timestamp_timeout=90 to Defaults


###################################################
# commandline stuff
###################################################

# Delete all Thumbs.db
locate Thumbs.db | while read -r f; do rm "$f"; done;

# Remove files which are duplicate base on first 3 chars in filename
for file in `ls  | uniq -d -w3 `; do rm "$file"; done;

# Replace spaces in filenames of current dir
for f in *; do mv -- "$f" "${f// /_}"; done

# find executable files 
find . -type f -perm /+x

# redirect stderr to stdout. pipe
2>&1

## redirect to file incl. duration time
{ time sleep 1 && echo hoi; } >> test-$(date +%Y%m%d).log 2>&1

# redirect stdin from /dev/null
0< /dev/null 

# strip extensions  (*.html -> *.htm)
rename 's/\.htm$//' *.htm

# word wrap text
fold -w80 -s

# convert to unix format 
sed 's/^M$//' i     # voor ^M in bash/tcsh, druk achtereenvolgens op Ctrl-V en Ctrl-M 
sed 's/.$//' filename  # er vanuit gaande dat alle regels eindigen met CR/LF

# delete certain lines 
sed -i '/downloads/d'

# On OSX do:
sed -i '' -e "s/STRING_TO_REPLACE/STRING_TO_REPLACE_IT/g" *.xml


# search and replace in several files
find . -type f -exec sed -i 's/TODO/TO\ DO/g' {} \;

# List all pci devices (for example PCI video card)
lspci

# check which process uses port 5900
lsof -i:5900	

# lijstje sorteren, unique en totalen
 | sort |  uniq -c | sort -n;
netstat -nat | awk '{print $6}' | sort | uniq -c | sort -n

# print last word of a line (separated by space)
 | awk '{print $NF}'


###################################################
#  debian specific stuff
###################################################

# generate a list of orphaned packages and give you the option to remove them
apt-get autoremove

# remove old linux kernels
dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d'

dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' | xargs sudo apt-get -y purge


# add key to APT
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 12345678

# upgrade
sudo apt-get install update-manager-core
sudo do-release-upgrade

# try after failed upgrade
sudo dpkg --reconfigure -a
sudo apt-get install -f

# Disable dist-upgrade notification
sudo vi /etc/update-manager/release-upgrades

# list installed packages
dpkg --get-selections > installed-software
# install a list of software
dpkg --set-selections < installed-software
dselect

# Servcies 
sudo update-rc.d lighttpd defaults		# start lighttpd on startup
sudo update-rc.d -f lighttpd remove		# don't start lighttpd on startup (anymore)
# for services install the interactive program: sysv-rc-conf
sudo sysv-rc-conf

# check installed ubuntu version
lsb_release -a



###################################################
#  Miscellaneous 
###################################################

# Create an iso image of a CD or DVD
dd if=/dev/cdrom of=cd.iso

# recover files (CLI)
sudo foremost image.dd /dev/sda7 
sudo foremost -t avi -i /dev/sda7
sudo foremost -w -i /dev/sda7 -T audit

## using fls and icat
# get list of inodes of deleted files
sudo fls -f ext -r /dev/sda7 > fls-list.txt
sudo icat -f ext /dev/sda7 INODE > movie.avi

# GPG key import/export
gpg -a --export > key-pub.gpg
gpg -a --export-secret-keys > key-priv.gpg

# encrypt/decrypt a file
openssl aes-256-cbc -a -salt -in secrets.txt -out secrets.txt.enc
openssl aes-256-cbc -d -a -in secrets.txt.enc -out secrets.txt.new

## Generate SSH keys
ssh-keygen -C "Rachid - Stash" -f stash.sshkey

# Update the "initial RAM disk", used when your system boots up
sudo update-initramfs -u

# Mount ntfs (writable)
/dev/sda1 /media/c ntfs-3g auto,umask=0077,uid=1000,gid=1000 0 0
# Retrieve UUID
blkid 

# Telnet
(sleep 4; echo "GET /search?q=bash  HTTP/1.1"; echo ""; sleep 5) | telnet google.com 80

## Partitions - partities
# Check of de partitie goed is foutcontrole schijfcontrole
e2fsck -f /dev/sda2

## Check battery state
cat /proc/acpi/battery/BAT0/state
cat /proc/acpi/battery/BAT0/info


###################################################
#  Bash 
###################################################

## BASH prompt: 
export PS1='\033[42m[\A ACCEPT \u@\h:\w]\$\033[0m'  		# with color
export PS1='\033[41m[\t PRODUCTIE \u@\h:\w]\$\033[0m'    # with color
export PS1='[\u@\033[41m\h\$\033[0m \W]\$ '

## Always surround special characters with \[ and \] so that they won't be counted as char
## See: https://unix.stackexchange.com/a/389095
export PS1='[\[\033[41m\]\u@\h\[\033[0m\] \W]# '

export PS1='\033[41m\u@\h\033[0m:\w]\$ '    # only username
export PS1='\u@\h:\w$ '
export PS1='[\033[41m\u@\h\033[0m \W]\$ '

## ROOT shell warning message

echo "Defaults    lecture = always" >> /etc sudoers

echo -e "\n## Root shell is marked red" >> ~/.bashrc
echo "export PS1='[\033[41m\u@\h\033[0m \W]# '" >> ~/.bashrc


## Start screen on when login, put this in .profile
if [ ! -z "$SSH_CONNECTION" ]; then
   screen -rd 
fi
