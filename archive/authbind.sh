sudo apt-get install authbind
sudo touch /etc/authbind/byport/843
sudo chmod 500 /etc/authbind/byport/843
sudo chown bla /etc/authbind/byport/843

# iptables -A PREROUTING -t nat -i eth0 -p tcp --dport 843 -j REDIRECT --to-port 8843
# iptables -F
