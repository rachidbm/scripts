https://www-e815.fnal.gov/webspace/cvs/commands.html

## Checkout 
export CVSROOT=user@bla.nl:/vol/cvs
cvs login
cvs co project

## Remove all files
find . -type f ! -path \*CVS\* -exec rm {} \; -exec cvs remove {} \;\



cvs history -a -c  -D 2016-05-01 -f api.bnd

cvs update -kb thefile
cvs commit -fm "Change substitution mode" thefile

