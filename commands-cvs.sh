https://www-e815.fnal.gov/webspace/cvs/commands.html


cvs history -a -c  -D 2016-05-01 -f api.bnd

-n AgileWorkplaceManagement 

cvs update -kb thefile
cvs commit -fm "Change substitution mode" thefile

## Checkout 
export CVSROOT=user@bla.nl:/vol/cvs
cvs co project

## Remove all files
find . -type f ! -path \*CVS\* -exec rm {} \; -exec cvs remove {} \;\

