
# open a random file
OPEN_CMD="xdg-open "
for i in `find ./* -type f | sort -R | tail -1`
do
	$OPEN_CMD $i; done
sleep 0.80;

for i in `find ./* -type f | sort -R | tail -8`
do
	$OPEN_CMD $i; sleep 0.20;
done
