#!/bin/sh

# export variables
export tomcat=apache-tomcat-5.5.25
export src_dir=~/downloads/dev
export dst_dir=/opt/java
export jdk_bin=jdk-1_5_0_14-linux-i586.bin
export jdk_dir=jdk1.5.0_14
export postgresql=postgresql-8.3
export eclipse=eclipse-jee-ganymede-linux-gtk.tar.gz

# download jdk manually from http://java.sun.com/javase/downloads/index_jdk5.jsp
# download eclipse europe manually

#if [ "$jdk_bin" = "$jdk"]; then
  #download tomcat AND psql
#  wget http://apache.mirror.transip.nl/tomcat/tomcat-5/v5.5.25/bin/apache-tomcat-5.5.25.tar.gz -o ~/downloads/$tomcat.tar.gz
#  wget http://ftp4.nl.postgresql.org/v8.2.5/postgresql-8.2.5.tar.gz -o ~/downloads/
  
  # JDK
  echo "Installing JDK...";
  sudo mkdir $dst_dir/
  sudo chmod u+x $src_dir/$jdk_bin
  sudo cp $src_dir/$jdk_bin $dst_dir/
  cd $dst_dir
  sudo ./$jdk_bin
  # need to agree by type 'yes' or 'y'
  sudo rm -f jdk;              # remove symlink if already exists
  sudo ln -s $jdk_dir jdk;
  sudo rm -rf $jdk_bin ;
  cd ~/scripts/;

  #Eclipse
  echo "Installing Eclipse...";
  sudo tar -zxf ~/downloads/dev/$eclipse -C $dst_dir/
  sudo cp ~/scripts/install_files/eclipse /usr/bin/eclipse
  sudo cp ~/scripts/install_files/eclipse.desktop /usr/share/applications/eclipse.desktop 

  #TOMCAT  
# echo "Installing Tomcat...";
# mkdir ~/local/
# tar -zxf $src_dir/$tomcat.tar.gz -C ~/local/
# mv ~/local/$tomcat ~/local/tomcat

  #PostgreSQL
#  echo "Installing PostgrSQL...";
# sudo apt-get install $postgresql
# sudo apt-get install pgadmin3
# sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD 'NEW_PASSWORD'"
# sudo cp ~/scripts/install_files/pgadmin3.desktop /usr/share/applications/pgadmin3.desktop 

# copy the find script to /usr/bin/f
#  sudo cp ~/scripts/install_files/f /usr/bin/f
#  cp ~/scripts/install_files/.basrc ~
  # copy eclipse preferences


