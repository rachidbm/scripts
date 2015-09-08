## init 
$(boot2docker shellinit)


## List running containers:
docker ps -f "status=running"

## List containers with name:
docker ps -f "name=lightbikes-robot"

## Stop all running containers: 
docker stop `docker ps -q -f "status=running"`

## Stop container latest started: 
docker stop `docker ps -q  -f "status=running" -n 1`



## Expose ports
for i in {9000..9001}; do
VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port$i,tcp,,$i,,$i";
VBoxManage modifyvm "boot2docker-vm" --natpf1 "udp-port$i,udp,,$i,,$i";
done

