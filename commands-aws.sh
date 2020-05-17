

Common AWS CLI commands

## Delete CodeCommit username from KeyChain
security -q delete-internet-password -a "git-codecommit.eu-west-1.amazonaws.com"


####################################
##  IAM
####################################


aws iam create-policy --policy-name CloudWatchRetention --policy-document file://iam-CloudWatchRetention-policy.json


aws iam create-role --role-name CloudWatchRetention --assume-role-policy-document file://iam-CloudWatchRetention-policy.json

Contents of iam-CloudWatchRetention-policy.json:
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogStream",
                "logs:PutRetentionPolicy",
                "logs:CreateLogGroup",
                "logs:PutLogEvents"
            ],
            "Resource": "*"
        }
    ]
}



## Create IAM Role for a lambda, with permission to write CW logs and put items in Dynamo
aws iam create-role --role-name WildRydesLambda --assume-role-policy-document file://iam-lambda-policy.json

Contents of iam-lambda-policy.json: 
{
   "Version": "2012-10-17",
   "Statement": [
      {
         "Effect": "Allow",
         "Principal": {
            "Service": [
               "lambda.amazonaws.com",
               "edgelambda.amazonaws.com"
            ]
         },
         "Action": "sts:AssumeRole"
      }
   ]
}

## Attach the policies
# aws iam attach-role-policy --role-name ReadOnlyRole --policy-arn arn:aws:iam::aws:policy/ReadOnlyAccess 
aws iam attach-role-policy  --role-name WildRydesLambda --policy-arn arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole

## Add inline policy for lambda write data to DynamoDB
aws iam put-role-policy --role-name WildRydesLambda --policy-name DynamoDBWriteAccess \
	--policy-document file://iam-DynamoDBWriteAccess.json

Contents of iam-DynamoDBWriteAccess.json:
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "dynamodb:PutItem",
            "Resource": "arn:aws:dynamodb:eu-west-1:437883356218:table/Rides"
        }
    ]
}


####################################
##  Code Pipeline
####################################

aws codepipeline list-pipelines

aws codepipeline get-pipeline --name
aws codepipeline update-pipeline --name game-functions-pipeline --cli-input-json


####################################
##  Lambda
####################################

aws lambda list-functions
aws lambda list-functions | grep FunctionName

aws lambda get-function --function-name  snsToWebsocketFunction
aws lambda get-function-configuration --function-name  snsToWebsocketFunction
aws lambda  list-event-source-mappings --function-name  gameStateHandler


touch /tmp/index.js && zip /tmp/tmp.zip /tmp/index.js
aws lambda create-function --function-name RequestUnicorn \
 --runtime nodejs12.x  --handler requestUnicorn.handler \
 --zip-file fileb://tmp/tmp.zip \
 --role arn:aws:iam::437883356218:role/WildRydesLambda

# aws lambda create-function --function-name my-function \
# --zip-file fileb://requestUnicorn.zip --handler index.handler --runtime nodejs12.x \
# --role arn:aws:iam::123456789012:role/lambda-cli-role




####################################
##  S3
####################################

## Create bucket
aws s3 mb s3://wildrydes-rachidbm

## Copy file
aws s3 cp config.js s3://wildrydes-rachidbm/js/


## Delete bucket
# aws s3api delete-bucket --bucket aws-course
aws s3 rb s3://aws-course --force 

## Sync buckets FROM to TO
aws s3 sync s3://wildrydes-us-east-1/WebApplication/1_StaticWebHosting/website s3://wildrydes-rachidbm 



####################################
##  Dynamo DB
####################################

## Create table 
aws dynamodb create-table --table-name Rides \
  --attribute-definitions AttributeName=RideId,AttributeType=S \
  --key-schema AttributeName=RideId,KeyType=HASH \
  --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5



## Create new game item in DB
aws dynamodb put-item --table-name games --item file://game-finished.json




####################################
##  CloudWatch commands
####################################

## Sert retention perdio for all log streams:
node update_cloudwatch_log_group_retention.js -r eu-west-1 -R 30 -s

# node update_cloudwatch_log_group_retention.js -r eu-west-1 -l /aws/ -R 30 -s
## See:  https://github.com/tensult/aws-automation



aws cloudwatch  describe-alarms --region eu-west-1
aws cloudwatch  describe-alarms --region us-east-1
aws cloudwatch set-alarm-state
  --alarm-name "Exceed5$" \
  --state-value "OK" \
  --state-reason "Threshold Crossed 5$ "


## Create billing alarm

aws cloudwatch describe-alarms
  --region us-east-1
  --query "MetricAlarms[?AlarmName == '<billing_alarm_name>']"



####################################
##  CloudWatch example queries
####################################


https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CWL_AnalyzeLogData-discoverable-fields.html

## All errors
FIELDS @message
| PARSE @message "[*] *" as logLevel #, loggingMessage
| FILTER logLevel = "ERROR"
| DISPLAY @timestamp, @message
#| DISPLAY @logStream, loggingMessage, @message
#| DISPLAY loggingMessage



## nr of errors
fields @nrOfErrors
| filter (@message like 'Error')
|  stats count(@message) as @nrOfErrors by bin(60m)



####################################
##  API Gateway
####################################


## Create REST API
aws apigateway create-rest-api --name 'WildRydes'

## List REST API's
aws apigateway get-rest-apis


## Get resources of a REST API
aws apigateway get-resources --rest-api-id f7jes63zok

## Authorizers
aws apigateway get-authorizers --rest-api-id f7jes63zok

aws apigateway create-authorizer --rest-api-id f7jes63zok --name WildRydes \
 --type COGNITO_USER_POOLS \
 --provider-arns 'arn:aws:cognito-idp:eu-west-1:437883356218:userpool/eu-west-1_GUMHA785N'  \
 --identity-source 'method.request.header.Authorization'

## Resources
aws apigateway get-resources --rest-api-id f7jes63zok

aws apigateway create-resource --rest-api-id f7jes63zok --parent-id vkpcy48qfe \
  --path-part ride


aws apigateway get-methods --rest-api-id f7jes63zok



####################################
##  Cognito
####################################

## Create a Cognito User Pools Authorizer
aws cognito-idp list-user-pools --output json --max-results 20
aws cognito-idp describe-user-pool --user-pool-id eu-west-1_GUMHA785N



####################################
##  SNS
####################################

aws sns list-topics
aws sns get-topic-attributes --topic-arn arn:aws:sns:eu-west-1:171715002786:game-state

aws sns list-subscriptions-by-topic --topic-arn arn:aws:sns:eu-west-1:171715002786:game-state

aws sns create-topic --name "maintenanceNeededAction" --attributes  DisplayName="Triggered when maintenance is needed for manufacturers"
aws sns create-topic --name "maintenanceClearedAction" --attributes  DisplayName="Triggered when no maintenance is needed anymore for manufacturers"

## List subscription of an SNS topic


aws sns publish \
   --topic-arn arn:aws:sns:eu-west-1:171715002786:deviceConnectionEvents \
   --subject TEST \
   --message '{"timestamp":"2020-01-26 20:01:50.265","logLevel":"INFO","traceId":"c18ccc09-e5e4-dd6b-947c-aaa8d6b129a8","accountId":"account_nr","status":"Success","eventType":"Publish-Out","protocol":"MQTT","topicName":"$aws/events/presence/disconnected/esp32_974508","clientId":"iotconsole-1580066906738-0","principalId":"AROASP6YDAGRKI5S6YYU5:rachid.benmoussa@luminis.eu","sourceIp":"86.83.45.176","sourcePort":53060}'


aws sns publish \
   --topic-arn arn:aws:sns:eu-west-1:171715002786:game-state-predev \
   --subject TEST \
   --message 'MEUH'





####################################
##  CodeCommit
####################################

aws codecommit list-repositories

aws cloudfront --profile YOUR_PROFILE_NAME create-invalidation --distribution-id YOUR_DISTRIBUTION_ID --paths '/*'
aws cloudfront create-invalidation --distribution-id E1P8Q61KZIRBJ5 --paths '/*'






####################################
##  Misc.
####################################





## AWS IoT needs AWS CLI version 2 installed

aws2 iotevents list-inputs

aws2 iotevents  create-detector-model --detector-model-name "mainteanceNeededDetectorModel" \
aws2 iotevents  create-detector-model --detector-model-name "mainteanceNeededDetectorModel" --generate-cli-skeleton

aws2 iotevents  create-detector-model --detector-model-name "mainteanceNeededDetectorModel" --cli-input-json  file://maintenance-detector-model.json

 aws2 iotevents describe-input --input-name ManufacturerInput

aws2 iotevents-data batch-put-message --cli-input-json file://highPressureMessage.json
