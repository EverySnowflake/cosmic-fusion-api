const mysql = require('mysql')
const zodiacCombination = require('./getZodiacCombination');
const username = process.env.DB_USERNAME
const host = process.env.DB_HOST
const database = process.env.DB_DATABASE
const password = process.env.DB_PASSWORD

exports.handler = function (event, context, callback) {
  var dob = event.params.querystring.dob
  var sex_at_birth = event.params.querystring.sex_at_birth
  var user = new zodiacCombination(`${dob}`, sex_at_birth)
  var user_info = user.getInfo()
  
  let connectionConfig = {
    host     : host,
    user     : username,
    database : database,
    password : password
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