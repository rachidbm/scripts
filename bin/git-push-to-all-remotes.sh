## Push the current branch to all configured remotes at once.
git fetch --all

BRANCH=`git rev-parse --abbrev-ref HEAD`

for REMOTE in `git remote show`; do
    echo "Pushing $BRANCH to $REMOTE"
    git push $REMOTE
done

echo Finished