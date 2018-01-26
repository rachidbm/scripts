# some handy symlinks

#ln -sf ~/scripts/f ~/bin/
#ln -sf ~/scripts/colorwords ~/bin/
#ln -sf ~/scripts/format-size ~/bin/
#ln -sf ~/scripts/replace-spaces ~/bin/

sudo ln -s ~/scripts/bin/backup /usr/bin/
#sudo ln -s ~/opt/java/eclipse/eclipse.sh  /usr/bin/eclipse 

## weekly backups
sudo ln -s ~/scripts/bin/sysbackup /etc/cron.weekly/sysbackup

## Daily sync with external HD
#sudo ln -s ~/scripts/sync-barrett.sh /etc/cron.daily/

## every hour update db 
sudo mv /etc/cron.daily/mlocate /etc/cron.hourly/

## disable recent documents
rm ~/.local/share/recently-used.xbel
touch ~/.local/share/recently-used.xbel
sudo chattr +i ~/.local/share/recently-used.xbel

## Add to crontab
echo add crontab...
# 1 * * * *  chmod +x ~/scripts/bin/*; find . ~/scripts/ -name "*sh" -exec chmod +x {} \; 


