#!/bin/bash
#
# By http://www.frankrock.it
# frankrock74@gmail.com
#
VAR=$@
mencoder -forceidx -of lavf -oac mp3lame -lameopts abr:br=64 -srate 22050 -ovc lavc  -lavcopts vcodec=flv:vqscale=6:mbd=2:mv0:trell:v4mv:cbp:last_pred=3 -o "$VAR".swf "$VAR" | zenity --progress --pulsate --auto-close --title="By FrankRock.it" --text="ATTENDERE! \n Sto convertendo "$VAR""
