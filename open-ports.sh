
echo `wget -q http://www.whatismyip.com/automation/n09230945.asp -O-`

## Check open ports of a remote machine
nmap -v -sT -Pn localhost

## Check open ports to the world outside
#nmap -P0 $(curl www.whatismyip.org)
nmap -P0 $(wget -q http://www.whatismyip.com/automation/n09230945.asp -O-)

## Check local listening ports
lsof -i:PORT
netstat -l
sudo netstat -anltp | grep :PORT
sudo lsof -i -P | grep -i listen

## Check UDP ports
sudo nmap -sU $(wget -q http://www.whatismyip.com/automation/n09230945.asp -O-)

## MacOS All open ports:
sudo lsof -PiTCP -sTCP:LISTEN
netstat -ap tcp | grep -i "listen"


## MacOS specific port:
export PORT=8000
lsof -n -i:$PORT | grep LISTEN
lsof -n -i:8080 | grep LISTEN
sudo lsof -i -n -P | grep TCP | grep 8080

