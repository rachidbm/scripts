#!/bin/bash
# This script looks in the logfile of an irc meeting if teammembers
# were attending the meeting. The output is a wiki tekst where
# teammembers who attended are grouped by their team(s) and teams 
# that were not present are also shown
# usage: irc_aanwezig pad/naar/logfile

logfile=$1
teams="Artwork Beheer Documentatie Forum Irc Prikboard Promotie Vertaal Website"
declare -A teamlist
declare -a namelistarray

function namelist
{
cat <<'EOF'
cafuego:Cafuego:Irc
DooitzedeJong:Dooitze de Jong:Artwork:Documentatie
Double12:Double12:Prikboard:Promotie
femke98:Femke98:Forum
Hannie:Hannie:Vertaal
heir4c:Heir4c:Forum
JanC:Jan Claeys:Irc
johanvd:Johanvd:Forum:Documentatie
joolz:Joolz:Irc:Vertaal
Joshua822:Joshua:Documentatie
Nunslaughter:Nunslaughter:Forum
ronnie_vd_c:Ronnie:Artwork:Promotie
seveas:Dennis:Beheer:Website
Sjoerd:Sjoerd:Forum
SWAT:SWAT:Beheer:Irc:Vertaal
testcees:Testcees:Documentatie
Thomas_de_Graaff:Thomas de Graaff:Artwork:Promotie
trijntje:trijntje:Vertaal
Vistaus:Vistaus:Forum
Wazzzaaa:Wazzzaaa:Vertaal
EOF
}

# Check if logfile is given and readable
if [[ -z $logfile ]];then
    echo "Argument ontbreekt, gebruik: irc_aanwezig /pad/naar/irc/logfile"
    exit 1
elif [[ ! -f "${logfile}" ]];then
    echo "Logfile ${logfile} bestaat niet."
    exit 1
elif [[ ! -r "${logfile}" ]];then
    echo "Logfile ${logfile} is niet leesbaar."
    exit 1
fi

# Check for every line in the namelist if the user is in logfile
# and if so, check if user is teammember and add user to teamlist

ifs="$IFS" #backup $IFS (internal field separator)
IFS=$'\n'  #set IFS to newline
namelistarray=($(namelist)) # put namelist in array

for dataline in ${namelistarray[@]};do
    ircname="${dataline%%:*}" #first item in dataline
    partline="${dataline#*:}"
    name=${partline%%:*} #second item in dataline
    # Check if ircname user is in logfile
    if [ "$(grep "< ${ircname}>" $logfile)" ];then
        # Check if user is member of teams
        IFS=" " # Set internal field separator to space
        for team in $teams;do
            if [[ $dataline == *$team* ]];then
                # add user to teamlist
                teamlist[$team]="${teamlist[$team]}, ${name}"
            fi
        done
        IFS=$'\n' # Set internal field separator back to newline
    fi
done
IFS=$ifs #restore internal field separator

# Generate output to screen and file

rm $PWD/teamgrab.tmp
echo
echo "=== Aanwezige teams ==="
for team in $teams;do
    if [ -n "${teamlist[$team]}" ];then
        echo " * ${team} team (${teamlist[$team]#, })"
    fi
done
echo "=== Afwezige teams ==="
for team in $teams;do
    if [ -z "${teamlist[$team]}" ];then
        echo " * ${team} team"|tee -a "$PWD/teamgrab.tmp"
    fi
done
exit 0 
