exports.handler = function (event, context, callback) {
    var response = {
      statusCode: 200,
      headers: {
        'Content-Type': 'application/json',
      },
      body: `${event.params.querystring.dob_and_sex}`
    }
    callback(null, response)
  }