#!/bin/bash
# version : 20100831
# this script will create a new virtual host. 

[ "$1" == "" ] && echo -e "Give a name for the new vhost, for example: SITENAME" &&  exit;

VHOST=$1
APACHE=/etc/apache2
WORKSPACE=/home/rachid/workspace/php/$VHOST/www

#sudo echo "Creating new VHOST for: $VHOST";

sed -e 's/URL/'$VHOST'/g' URL.lan | sudo tee -a $APACHE/sites-available/$VHOST > /dev/null

echo "Created apache config: $APACHE/sites-available/$VHOST "

sudo ln -sf $APACHE/sites-available/$VHOST $APACHE/sites-enabled/$VHOST
mkdir -p $WORKSPACE
echo "Created dir: $WORKSPACE"
echo "Maybe you need to change the owner of $WORKSPACE ;)"

if [ `grep -c $VHOST /etc/hosts` -gt 0 ]; then
	echo $VHOST already exists in /etc/hosts
else 
	echo "127.0.0.1  $VHOST.lan" | sudo tee -a /etc/hosts > /dev/null
fi

echo "Restarting apache to apply the changes"
sudo apache2ctl restart

echo "Create MySQL Database and default user. (type you MySQL password)"
/bin/sed -e "s/VHOST/$VHOST/g" new-vhost.sql | mysql -p
echo "An user and empty database created for $VHOST";

