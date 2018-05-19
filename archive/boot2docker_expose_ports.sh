[ "$1" == "" ] && echo -e "Add port to expose" &&  exit;


expose_port () {
	echo "Exposing: $1"
	VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port$1,tcp,,$1,,$1";
	VBoxManage modifyvm "boot2docker-vm" --natpf1 "udp-port$1,udp,,$1,,$1";
}

expose_port $1