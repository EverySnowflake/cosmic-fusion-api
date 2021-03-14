const mysql = require('mysql')
const zodiacCombination = require('./getZodiacCombination');
const username = process.env.DB_USERNAME
const host = process.env.DB_HOST
const database = process.env.DB_DATABASE
const password = process.env.DB_PASSWORD

exports.handler = function (event, context, callback) { }
