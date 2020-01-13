

Common AWS CLI commands


####################################
##  IAM
####################################

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

aws iam attach-role-policy --policy-arn arn:aws:iam::aws:policy/ReadOnlyAccess --role-name ReadOnlyRole



####################################
##  Lambda
####################################

# aws lambda create-function --function-name my-function \
# --zip-file fileb://function.zip --handler index.handler --runtime nodejs12.x \
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
##  CLoudWatch example queries
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

/home/osmc/barrett/apps/Adobe Photoshop CS4/Adobe CS4/redist





####################################
##  Misc.
####################################



## commands to setup AWS services.
## Can be used until we've defined the infra in CloudFormation


aws sns create-topic --name "maintenanceNeededAction" --attributes  DisplayName="Triggered when maintenance is needed for manufacturers"
aws sns create-topic --name "maintenanceClearedAction" --attributes  DisplayName="Triggered when no maintenance is needed anymore for manufacturers"


## AWS IoT needs AWS CLI version 2 installed

aws2 iotevents list-inputs

aws2 iotevents  create-detector-model --detector-model-name "mainteanceNeededDetectorModel" \
aws2 iotevents  create-detector-model --detector-model-name "mainteanceNeededDetectorModel" --generate-cli-skeleton

aws2 iotevents  create-detector-model --detector-model-name "mainteanceNeededDetectorModel" --cli-input-json  file://maintenance-detector-model.json

 aws2 iotevents describe-input --input-name ManufacturerInput

aws2 iotevents-data batch-put-message --cli-input-json file://highPressureMessage.json
