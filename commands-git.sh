# Initial config
git config --global user.name "Rachid BM"
git config --global user.email "rachidbm@ubuntu.com"
git config --global color.ui auto
git config --global color.diff auto
git config --global color.status auto
git config --global color.branch auto
# to avoid push warnings
git config --global push.default matching

# Start a new (fresh) project
cd myproject
git init
git add .
git commit

# oneliner
git init && git add . &&  git commit

# Set up bare repo (shared repo)
cd ..  # this is important; you must be outside your project dir
git clone --bare ./myproject myproject.git
scp -r myproject.git mydomain.com:shared

# gitignore
Add the .gitignore before doing 'git add .'
		# excluded files
		bin/
		*.class
		## generic files to ignore
		*~
		*.lock
		*.DS_Store
		*.swp


# Commit (local)
git commit -a
 # Commit it to remote repo
git push
# get new updates... (from the remote repo)
git pull

## Branching
# Show local branches
git branch
# list all branches (incl. remote)
git branch -r
# Create a local branch
git branch <name_of_your_new_branch>
# Switch to branch
git checkout <name_of_your_new_branch>
# Push branch to remote
git push origin <name_of_your_new_branch>

# Stash local changes

# push new branch (not tracked remotely)
git push origin selfservice-WVDED-166:selfservice-WVDED-166

## Rewrite branches
# remove logwatcher.log from all revisions
git filter-branch -f --index-filter 'git update-index --remove logwatcher.log' HEAD

# Oldest commit
git log `git rev-list HEAD | tail -n 1`

## format git log
git log --pretty=format:"%H - %an - %ae - %s"
git log --pretty=format:"%H - %an"
git log  --pretty=oneline --not --author=p5dev

# Search through commit messages
git log --grep

## Merging

git ls-files -u  # to view all of the unmerged files

## Git counting files
## Staged for commit (ie pending in Source Tree):
git diff --cached --numstat | wc -l
git diff --cached --stat   # human readable, including summary (changed, deletions, etc)
# Changes that could be staged
git diff-files --quiet
## Show all conflicts unmerged)
git diff --name-only --diff-filter=U

## Stash
git stash list

# Show line endings
git diff -R  


## Git config on Windows

C:\ProgramData\Git\config
C:\Users\USERNAME\.gitconfig

