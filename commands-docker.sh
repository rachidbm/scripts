
## Docker run examples
docker run -t zap --name zap-web \
	-p 8080:8080 -p 8090:8090 \
	-v `pwd`/shared:/home/zap/shared \
	-i owasp/zap2docker-stable "zap-webswing.sh"

# Run container and open shell
docker run -it ubuntu bash


## Docker build examples
docker build -t app-local .
docker run -v `pwd`:/opt/workingdir -t app-local

## Docker RUN examples
docker run -it openjdk:8-jdk /bin/bash

## Or to prevent slow IO on MacOS
docker run -v `pwd`:/opt/workingdir:delegated -t name




## Docker exec examples, ie commands on/into running containers
# Open shell in running container
docker exec -i -t ubuntu /bin/bash
docker exec -i -t docker-poop-148-docker-b559d75c /bin/bash

docker exec -i -t zap bash
# Import DB in running container
docker exec -i db.website.com mysql -uroot -proot  < ../db/export.sql




## Inspect Docker images
## A tree:
docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock nate/dockviz images -t

docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock --rm chenzj/dfimage  d9229fcafffd
## Dive
docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock --rm wagoodman/dive:latest d9229fcafffd
docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock --rm wagoodman/dive:latest 26144804fc6e



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


## Clean up
## Show docker disk usage:
docker system df

## This will remove:
##        - all stopped containers
##        - all networks not used by at least one container
##        - all dangling images
##        - all build cache
docker system prune

## remove all stopped containers.
docker container prune
docker image prune -a

# Remove images
docker rmi e0dce81f1996



## Save image
docker save -o <save image.tar to path> <image name>
docker load -i <path to image.tar>



