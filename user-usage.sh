#!/bin/bash
# login usage all user based on home directorys
# tell him how many resources hes take
# v1 done pff don't ask me, ask my weed dealer ;) hrhr
#
#  
# (c)ode by Monday
#
PWFILE=/etc/passwd
DHOME=/home/
ALLUSERS="$1"

getUserMem()
{
# take memory usage
 usermem=`top -b -n 1 | tail -10 | grep -w $User | sed -e 's/K//g' -e 's/%//g' | awk 'BEGIN { n=0;size=0;cpu=0;mem=0 } { n ++ ; size += $5 ; cpu += $9;mem +=$10 } END { print n, size, cpu, mem }'`
 echo $usermem
}

getUsers()
{

 if [ "$ALLUSERS" == "" ]; then  # read /home/	
 	echo "NO parameter given, so I read the users from $DHOME";
 	Users=`ls $DHOME`;
 else	# read all users
 	echo "parameter given, so I read the users from $PWFILE";
 	Users=`cat $PWFILE | cut -d: -f1`;
 fi

 echo "|-----------[ TOP PROCESS USED BY ]----------------------- -- -  -"
 echo "|--------------------------------------------------------- -- -  -"
 echo "|   Username   | Processes |   MEM/Kb   | %CPU | %MEM "
 echo "|--------------------------------------------------------- -- -  -"

# Users="$Users root"
 output="| %4d      | %7d    | %4s | %4s  \n"
 for User in $Users;do
  UserCount=`expr $UserCount + 1`
  UserProzess=`getUserMem`
  printf "| %12s $output" $User $UserProzess
 done  | sort -k 4 -r 
echo "|--------------------------------------------------------- -- -  -"
}



tet()
{

# format output
echo "type:userusage"
echo "Process usage for User $user_var on $HOSTNAME"
output="| %4d      | %7d    | %4s | %4s  \n"
printf "|-----------[ PROCESS USED ]------------------------------ -- -  -\n"
echo   "| Processes |   MEM/Kb   | %CPU | %MEM " 
printf "|--------------------------------------------------------- -- -  -\n"
printf "$output" $usermem 
printf "|--------------------------------------------------------- -- -  -\n"

}


main()
{
getUsers
}

main

