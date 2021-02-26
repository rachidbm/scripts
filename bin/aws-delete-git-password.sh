
security -q delete-internet-password -l "git-codecommit.eu-west-1.amazonaws.com" > /dev/null 2>&1 

## Add this in crontab as follows: 
## */10 * * * * date >> ~/delete-aws-credentials.log; ~/scripts/bin/aws-delete-git-password.sh >> ~/delete-aws-credentials.log  2>&1


# && \
# /usr/local/bin/aws codecommit credential-helper $@
# !aws codecommit credential-helper $@