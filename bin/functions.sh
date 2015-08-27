
## Some handy bash functions
## To include this file c/p:
# SCRIPTPATH=`dirname $(readlink -f $0)` 	# Absolute path this script is in. 
# source $SCRIPTPATH/functions.sh

TODAY=$(date +%Y%m%d);

log() {
  echo $(date +%d-%m\ %T)  -  $1
}

#command_not_found_handle() {
#  echo "sudo apt-get install youtube-dl"
#	exit
#}


#latest() { 
#	( shopt -s dotglob nullglob; local file files=("${1:-.}/"*) latest=$files; for file in "${files[@]}"; do [[ $file -nt $latest ]] && latest=$file; done; echo "$latest" ) 
#}

## dir exists
exits() {
	if [[ -e $1 || -d $1 ]]
	then
	  echo "$1 exists"
	else
		echo "$1 exists not";
	fi
}



