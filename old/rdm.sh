
# open a random file
VLC_CMD="xdg-open "
for i in `find ./* -type f | sort -R | tail -1`
do
	$VLC_CMD $i; done
sleep 0.80;

for i in `find ./* -type f | sort -R | tail -8`
do
	$VLC_CMD $i; sleep 0.20;
done
