## TODO: auto start tor if the service isn't running yet. 
echo Make sure tor is started with: 
echo sudo service tor start
google-chrome --proxy-server="socks=127.0.0.1:9050; sock4=127.0.0.1:9050; sock5=127.0.0.1:9050" --incognito check.torproject.org
