
security -q delete-internet-password -l "git-codecommit.eu-west-1.amazonaws.com" > /dev/null 2>&1 && \
/usr/local/bin/aws codecommit credential-helper $@
# !aws codecommit credential-helper $@