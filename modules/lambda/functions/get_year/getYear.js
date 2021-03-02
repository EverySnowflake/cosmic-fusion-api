const zodiacCombination = require('./getZodiacCombination');

exports.handler = function (event, context, callback) {
    var date = event.params.querystring.date
    var data = new zodiacCombination(`${date}`, 0).getInfo()

    var response = {
      statusCode: 200,
      headers: {
        'Content-Type': 'application/json',
      },
      body: data
    }
    callback(null, response)
  }