console.log("Loading function");
var AWS = require("aws-sdk");
const mysql = require('mysql');
const DATABASE_HOST = process.env.DATABASE_HOST;
const DATABASE_PORT = process.env.DATABASE_PORT;
const DATABASE_USERNAME = process.env.DATABASE_USERNAME;
const DATABASE_PASSWORD = process.env.DATABASE_PASSWORD;
const DATABASE_NAME = process.env.DATABASE_NAME;
const sns = new AWS.SNS();

console.log("loading function");

exports.handler = (event, context, callback) => {

  let connectionConfig = {
    host: DATABASE_HOST,
    port: DATABASE_PORT,
    user: DATABASE_USERNAME,
    password: DATABASE_PASSWORD,
    database: DATABASE_NAME
  }

  var connection = mysql.createConnection(connectionConfig)
  const query = `SELECT daily_mantra FROM daily_mantra`

  connection.query(query, function (error, results, fields) {
      if (error) {
          connection.destroy();
          throw error;
      } else {
        const params = {
          Message: JSON.stringify(results),
          MessageStructure: "json",
          TopicArn: SNS_TOPIC_ARN /* From step 2 */
        };
        const publishPromise = sns.publish(params).promise();
        publishPromise
          .then((response) => {
            callback(null, "Message published.");
          }, (err) => {
            console.log("We had an error");
            callback("Message wasn’t able to publish.");
          });
          console.log(results);
          callback(error, response);
          connection.end(function (err) { callback(err, results);});
      }
  });
};