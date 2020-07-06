[ "$1" == "" ] && echo -e "Provide the filename to convert" &&  exit;

ffmpeg $1.mp3 -i $1 -codec:a libmp3lame -qscale:a 1
