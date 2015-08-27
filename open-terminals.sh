# On bottom left workspace

# 1920x1080
#gnome-terminal --geometry=100x40+1100+360 -t bla.nl -x bash -c "ssh bla.nl; exec bash; " &
gnome-terminal --geometry=100x40+1100+360 &
gnome-terminal --geometry=100x27+0+0 -x bash -c "exec bash;"  &
gnome-terminal --geometry=100x27+0+600 -t admin -x bash -c "exec bash;" &

# 1440x900
#gnome-terminal --geometry=80x40+1100+360 -t bla.nl -x bash -c "ssh rachid@bla.nl; exec bash; " &
#gnome-terminal --geometry=140x32+2+2 &
#gnome-terminal --geometry=73x22+0+500 -t admin -x bash -c "exec bash;" &

