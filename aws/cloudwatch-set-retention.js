const AWS = require('aws-sdk');
const cloudwatchLogs = new AWS.CloudWatchLogs();

function setRetentionOfCloudwatchLogGroup(logGroupName, duration) {
    let params = {
        logGroupName : logGroupName,
        retentionInDays: duration
    };
    return cloudwatchLogs.putRetentionPolicy(params).promise();
}

exports.handler = async (event) => {
    const logGroupName = event.logGroupName ? event.logGroupName : event.detail.requestParameters.logGroupName;
    try {
        let retentionInDays = 30;
        await setRetentionOfCloudwatchLogGroup(logGroupName, retentionInDays);
        console.log('Retention for log group ', logGroupName, ' has been set to', retentionInDays, 'days');
        return;
    } catch(error) {
        console.error(error);
        throw error;
    }
};