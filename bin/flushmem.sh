#sudo -s;

sudo swapoff -a;
sudo swapon -a

sudo sync;
echo 3 | sudo tee /proc/sys/vm/drop_caches > /dev/null;
echo "Memory caches are dropped."


exit
