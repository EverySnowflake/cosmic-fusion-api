"use strict";

const mysql = require('mysql');
const celebsSql = `SELECT name, description, dateOfBirth, sex, animal_id, element_id, western_id, image FROM celebs`;
const DATABASE_HOST = process.env.DATABASE_HOST;
const DATABASE_PORT = process.env.DATABASE_PORT;
const DATABASE_USERNAME = process.env.USERNAME;
const DATABASE_PASSWORD = process.env.PASSWORD;
const DATABASE_NAME = process.env.DATABASE_NAME;

exports.handler = (event, context, callback) => {

    const db = mysql.createConnection({
        host: DATABASE_HOST,
        port: DATABASE_PORT,
        user: DATABASE_USERNAME,
        password: DATABASE_PASSWORD,
        database: DATABASE_NAME
    });

    db.connect((error) => {
        if(error) throw error;
        console.log("Connected");
    });

    db.query(celebsSql, function (err, result) {
        if (err) throw err;
        const response = {
            statusCode: 200,
            headers: {
                'Content-Type': 'application/json',
            },
            body: result
        };
        console.log(result);
        callback(err, response);
        db.connection.end(function (err) { callback(err, result);});
    });
};
