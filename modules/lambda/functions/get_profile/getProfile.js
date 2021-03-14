const mysql = require('mysql')
const zodiacCombination = require('./getZodiacCombination');
const DATABASE_HOST = process.env.DATABASE_HOST;
const DATABASE_PORT = process.env.DATABASE_PORT;
const DATABASE_USERNAME = process.env.DATABASE_USERNAME;
const DATABASE_PASSWORD = process.env.DATABASE_PASSWORD;
const DATABASE_NAME = process.env.DATABASE_NAME;

exports.handler = function (event, context, callback) {
  var dob = event.params.querystring.dob
  var sex_at_birth = event.params.querystring.sex_at_birth
  var user = new zodiacCombination(`${dob}`, sex_at_birth)
  var user_info = user.getInfo()
  
  let connectionConfig = {
    host: DATABASE_HOST,
    port: DATABASE_PORT,
    user: DATABASE_USERNAME,
    password: DATABASE_PASSWORD,
    database: DATABASE_NAME
  }

  var connection = mysql.createConnection(connectionConfig)
  const { westernId, elementId, animalId, sex, trio } = user_info
  const query = `SELECT * FROM character_profiles WHERE westernId=${westernId} AND elementId=${elementId} AND animalId=${animalId} AND sex=${sex}`

  connection.query(query, function (error, results, fields) {
      if (error) {
          connection.destroy();
          throw error;
      } else {
          results[0]["trio"] = trio;
          const response = {
            statusCode: 200,
            headers: {
                  'Content-Type': 'application/json',
                },
            body: results
          }
          console.log(results);
          callback(error, response);
          connection.end(function (err) { callback(err, results);});
      }
  });
}