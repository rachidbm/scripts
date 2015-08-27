
##Client side commands
# Check out a project 
svn co svn+ssh://servert/data/svn/PROJECT_NAME/trunk local-project-name

# Add project (for the first time)
svn import -m "importing test over ssh+svn" ./projectname/ svn+ssh://servert/data/svn/PROJECT_NAME/trunk
OR svn import -m "importing velocity over ssh+svn" ./velocity/ svn+ssh://servert/data/svn/rachid/velocity

# when the ssh port is not 22
SVN_SSH="ssh -p 1221" svn co svn+ssh://bla.nl/data/svn/rachid/puzzles pussels

SVN_SSH="ssh -p 1221" svn ls svn+ssh://bla.nl/data/svn/rachid/puzzles

svn commit local-project-name

# examples
svn co svn+ssh://servert/data/svn/rachid/trunk projectname

svn import -m "importing test over ssh+svn" ./testproject/ svn+ssh://servert/data/svn/rachid/trunk

# branch
svn copy http://svn.example.com/repos/PROJECT_NAME/trunk \
           http://svn.example.com/repos/PROJECT_NAME/branches/my-PROJECT_NAME-branch \
      -m "Creating a branch of /PROJECT_NAME/trunk."

# merge
svn merge --dry-run -r 14306:14305 https://subversion.bla.com/

# show changed files
svn status -u | grep -v '\?' | awk -F"\ " '{print $3}'

# revert a revision
svn merge -c -REV .
svn merge -c -102643 .
#revert range
svn merge -r5:3 .

Server side commands
====================
# Create a new repository
svnadmin create /data/svn/PROJECT_NAME

svnlook tree /data/svn/PROJECT_NAME/

svn ls file:///data/svn/rachid/

