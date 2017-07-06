## init 
eval $(boot2docker shellinit)

## Tree view of images
docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock nate/dockviz images -t


## Docker compose
docker-compose build
docker-compose up -d 
docker-compose kill

## Find image ID by its name
docker ps -a -q -f name=my_mysql_server

## Commands for running containers
# import database
docker exec -i `docker ps -q -f name=my_mysql` mysql -uroot -padmin  < ../db/database.sql
# Open terminal shell
docker exec -i -t my_mysql /bin/bash 


## List running containers:
docker ps -f "status=running"

## List containers with name:
docker ps -f "name=lightbikes-robot"

## Stop all running containers: 
docker stop `docker ps -q -f "status=running"`

## Stop container latest started: 
docker stop `docker ps -q  -f "status=running" -n 1`

## Remove docker containers using their ids
docker rm -v -f $(docker ps -q -a)



## Save image
docker save -o <save image.tar to path> <image name>
docker load -i <path to image.tar>



# Remove images
docker rmi e0dce81f1996


## Clean up
#docker_clean_images='docker rmi $(docker images -a --filter=dangling=true -q)'
#alias docker_clean_ps='docker rm $(docker ps --filter=status=exited --filter=status=created -q)'


## Expose ports
for i in {9000..9001}; do
VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port$i,tcp,,$i,,$i";
VBoxManage modifyvm "boot2docker-vm" --natpf1 "udp-port$i,udp,,$i,,$i";
done



