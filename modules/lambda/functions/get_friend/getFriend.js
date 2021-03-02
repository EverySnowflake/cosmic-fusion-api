"use strict";

const mysql = require('mysql');
const zodiacCombination = require('./getZodiacCombination');
const DATABASE_HOST = process.env.DATABASE_HOST;
const DATABASE_PORT = process.env.DATABASE_PORT;
const DATABASE_USERNAME = process.env.DATABASE_USERNAME;
const DATABASE_PASSWORD = process.env.DATABASE_PASSWORD;
const DATABASE_NAME = process.env.DATABASE_NAME;

exports.handler = function (event, context, callback) {

    const dob_1 = event.params.querystring.dob;
    const sex_at_birth_1 = event.params.querystring.sex_at_birth;
    const dob_2 = event.params.querystring.friend_dob;
    const sex_at_birth_2 = event.params.querystring.friend_sex_at_birth;

    const user_1 = new zodiacCombination(`${dob_1}`, sex_at_birth_1);
    const user_2 = new zodiacCombination(`${dob_2}`, sex_at_birth_2);
    const user_info = user_1.getInfo();
    const user_info_2 = user_2.getInfo();

    const {westernId, elementId, animalId, sex, trio} = user_info;
    const {westernId2, elementId2, animalId2, sex2, trio2} = user_info_2;

    const db = mysql.createConnection({
        host: DATABASE_HOST,
        port: DATABASE_PORT,
        user: DATABASE_USERNAME,
        password: DATABASE_PASSWORD,
        database: DATABASE_NAME
    });

    db.connect((error) => {
        if (error) throw error;
        console.log("Connected");
    });

    const query = `SELECT score FROM compatibility_scores WHERE westernId_1=${westernId} AND elementId_1=${elementId} AND animalId_1=${animalId} AND westernId_2=${westernId2} AND elementId_2=${elementId2} AND animalId_2=${animalId2} AND type=${sex_at_birth_1};`;

    db.query(query, function (err, result) {
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
