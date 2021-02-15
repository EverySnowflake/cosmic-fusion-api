const zodiacCombination = require('./getZodiacCombination');

exports.handler = function (event, context, callback) {
    var date = event.params.querystring.date
    var sex_at_birth = event.params.querystring.sex_at_birth
    var data = new zodiacCombination(`${date}`, sex_at_birth).getInfo()

    var response = {
      statusCode: 200,
      headers: {
        'Content-Type': 'application/json',
      },
      body: data
    }
    callback(null, response)
  }