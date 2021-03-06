# Initial config
git config --global color.ui auto
git config --global color.diff auto
git config --global color.status auto
git config --global color.branch auto
# to avoid push warnings
git config --global push.default matching
git config --global rebase.autoStash true

# ignore file permissions
git config core.fileMode false

git config --global branch.autosetuprebase always
git config --global rebase.autoStash true

## Find in which file something is configured
git config --show-origin --get credential.helper

git commit --allow-empty -m "Trigger build pipeline"

git remote add origin http://github.com/repo
# git branch -M main
git push -u origin master

## amend commit
git commit --amend --no-edit

git rev-list 36429063..master
git log 36429063..master

# Start a new (fresh) project
cd myproject
git init
git add .
git commit

# oneliner
git init && git add . &&  git commit


## Push to empty remote origin
git push -u origin main


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
# Create a branch for a tag
git checkout -b 153.0.12.5079 153.0.12.5079

# Switch to branch
git checkout <name_of_your_new_branch>
## Checkout remote branch
git checkout --track -b B_16 origin/B_16
## Delete branch
git branch -d test
## Delete remote branch
git push origin --delete test

# Push branch to remote
git push origin <name_of_your_new_branch>

## effectively only allows you to force-push if no-one else has pushed changes up to the remote in the interim
git push --force-with-lease 

## Stash
git stash list
# Drop all stashes
git stash clear


# push new branch (not tracked remotely)
git push origin selfservice-WVDED-166:selfservice-WVDED-166

## Rewrite branches
# remove logwatcher.log from all revisions
git filter-branch -f --index-filter 'git update-index --remove logwatcher.log' HEAD

## Convert line endings whithout a new commit ie rewriting history
git filter-branch -f --tree-filter 'find . -path './.git' -prune -o -type f -exec dos2unix -s -q \{} \;' -- --all

# Oldest commit
git log `git rev-list HEAD | tail -n 1`

## format git log
git log --pretty=format:"%H - %an - %ae - %s"
git log --pretty=format:"%H - %an"
git log  --pretty=oneline --not --author=p5dev

# Search through commit messages
git log --grep

## Merging

git merge -s ours branchname

git ls-files -u  # to view all of the unmerged files

# Count commits
git log --oneline | wc -l


## Git counting files
## Staged for commit (ie pending in Source Tree):
git diff --cached --numstat | wc -l
git diff --cached --stat   # human readable, including summary (changed, deletions, etc)
# Changes that could be staged
git diff-files --quiet
## Show all conflicts unmerged)
git diff --name-only --diff-filter=U

# Show line endings
git diff -R  

# diff tag against working dir
git diff tag1 
# diff between tags
git diff tag1 tag2


## Delete List of Git tags
for tag in `git tag | grep "origin/" `; do
	echo " tag name: $tag"
	git tag -d $tag
	git push origin :refs/tags/$tag
done

## Convert SVN branches
for branch in `git branch -r | grep "origin/B_[0-9]" | sed 's/origin\///'`; do
  git branch $branch refs/remotes/origin/$branch
  ## add .gitignore to branches
  git checkout $branch
  cp ~/git-files/.gitignore .
	git add .gitignore && git commit -m 'Added .gitignore'
done
git checkout master

## Convert SVN tags
for tag in `git branch -r | grep "tags/V[0-9]" | sed 's/origin\/tags\///'`; do
	#echo "new tag name: $tag"
  git tag -a -m 'Converting SVN tags' $tag refs/remotes/origin/tags/$tag   #refs/tags/$tag
done



## Git config on Windows

C:\ProgramData\Git\config
C:\Users\USERNAME\.gitconfig

