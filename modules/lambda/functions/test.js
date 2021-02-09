exports.handler = function (event, context, callback) {
    var response = {
      statusCode: 200,
      headers: {
        'Content-Type': 'application/json',
      },
      body: `Hello ${event.params.querystring.getProfile}!`,
    }
    callback(null, response)
  }