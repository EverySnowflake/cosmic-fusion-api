console.log("Loading function");
var AWS = require("aws-sdk");
const mysql = require('mysql')
const DATABASE_HOST = process.env.DATABASE_HOST;
const DATABASE_PORT = process.env.DATABASE_PORT;
const DATABASE_USERNAME = process.env.DATABASE_USERNAME;
const DATABASE_PASSWORD = process.env.DATABASE_PASSWORD;
const DATABASE_NAME = process.env.DATABASE_NAME;

exports.handler = function(event, context) {
    console.log("Received event");
    let connectionConfig = {
      host: DATABASE_HOST,
      port: DATABASE_PORT,
      user: DATABASE_USERNAME,
      password: DATABASE_PASSWORD,
      database: DATABASE_NAME
    }
  
    var connection = mysql.createConnection(connectionConfig)
    var requestObject = JSON.parse(event.body)
    const userId = requestObject.userId
    const notificationId = requestObject.notificationId
    const notificationType = requestObject.notificationType
    connection.connect(function(err) {
      if (err) throw err;
      console.log("Connected!");
      var sql = `INSERT INTO notifications (userId, notificationId, notificationType) VALUES ('${userId}', '${notificationId}', '${notificationType}')`;
      connection.query(sql, function (err, result) {
        if (err) throw err;
        console.log("1 record inserted");
      });
    });

    var sns = new AWS.SNS({region: 'eu-west-1'});
    var params = {
      PlatformApplicationArn: 'arn:aws:sns:eu-west-1:901964243946:app/BAIDU/Android',
      Attributes: {
        'UserId': userId,
        'ChannelId': userId
      },
      Token: userId
    };
    sns.createPlatformEndpoint(params, context.done);
};

// {
//   "token":"123456"
//   "UserId":"123456",
//   "ChannelId":"123456"
// }