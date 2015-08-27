## generate key
openssl genrsa -des3 -out server.key 1024

## make a request
openssl rsa -in server.key -out server.key.insecure
mv server.key server.key.secure
mv server.key.insecure server.key
openssl req -new -key server.key -out server.csr

## sign cert yourself
openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt

## install cert
sudo cp server.crt /etc/ssl/certs
sudo cp server.key /etc/ssl/private


