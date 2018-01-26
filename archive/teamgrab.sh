#!/bin/bash
# grabber van gebruikersnamen van launchpad teams
# usage: teamgrab

# Variables:
new=1 # variable that shows wether there are new members
gone=1 # variable that shows wehter members have gone

declare -A teamlist

teams=" nl-Artwork  nl-Beheer nl-Documentatie nl-Forum nl-Irc nl-Prikboard nl-Promotie nl-website l10n-nl"

# Cleanup before start
[ -f "$PWD/teamgrab.new" ] && rm "$PWD/teamgrab.new"

# Grab teammembers from the launchpad website and output to screen and file
echo
echo "Teams: leden"
echo "------------------------------------"

for team in $teams;do
    teamlist[${team}]="$(wget -q -O - "https://launchpad.net/~ubuntu-$team/+members" |\
                       grep '<a href="/~.*" class="sprite person">.*</a>'|\
                       sed 's/.*\">//'|\
                       sed 's/<\/a>/,/')"
    temp="${teamlist[$team]}"
    teamlist[$team]="${temp%,}"
    echo ${team}: ${teamlist[$team]}
    echo ${team}, ${teamlist[$team]} >> $PWD/teamgrab.new
done

# Compare old file and new file for gone and new teammembers

# If no oldfile, copy newfile to oldfile
[ ! -f $PWD/teamgrab.old ] && { mv "$PWD/teamgrab.new" "$PWD/teamgrab.old";echo;echo "Teamlijst opgeslagen!";exit 0; }

# Put lines oldteamfile in array
teller=0
while read oldteamfile[$teller];do
    (( teller += 1 ))
done < $PWD/teamgrab.old

# Put lines newfile in array
teller=0
while read newteamfile[$teller];do
     (( teller += 1))
done < $PWD/teamgrab.new

# Check if there are new members in newfile
ifs=$IFS # temporarily change IFS (field selector)
IFS=','
echo
echo "Nieuw:"
echo "------------------------------------"
for (( teller=0 ; teller<${#newteamfile[@]} ; teller++ ));do
    for word in ${newteamfile[$teller]};do
         if [[ ! "${oldteamfile[$teller]}" == *"${word}"* ]];then
              printf "%-15.15s %s\n" "${newteamfile[$teller]%%,*}:" "${word%,}"
              new=0
         fi
    done
done
(( $new )) && echo " -"

# Check if there are old members not in newfile
echo
echo "Vertrokken:"
echo "------------------------------------"
for (( teller=0 ; teller<${#oldteamfile[@]} ; teller ++ ));do
     for word in ${oldteamfile[$teller]};do
          if [[ ! "${newteamfile[$teller]}" == *"${word}"* ]];then
              printf "%-15.15s %s\n" "${oldteamfile[$teller]%%,*}:" "${word%,}"
              gone=0
          fi
     done
done
(( $gone )) && echo " -"
echo
IFS=$ifs # Restore field selector to default

# Ask to save new teamlist to file
read -p "Bewaren nieuwe teamlijst? [J/n] " answer
[ -z "$answer" ] && answer="J"
case "$answer" in 
    [Jj]*) mv "$PWD/teamgrab.new" "$PWD/teamgrab.old";rm "$PWD/teamgrab.new";echo "Opgeslagen.";;
    [Nn]*) rm "$PWD/teamgrab.new";echo "Niet opgeslagen.";exit 0;;
    *) rm "$PWD/teamgrab.new";echo "Onverwacht antwoord, niet opgeslagen.";;
esac
