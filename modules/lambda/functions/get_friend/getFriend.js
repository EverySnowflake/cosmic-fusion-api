"use strict";

const mysql = require('mysql');
const zodiacCombination = require('./getZodiacCombination');

const DATABASE_HOST = process.env.DATABASE_HOST;
const DATABASE_PORT = process.env.DATABASE_PORT;
const USERNAME = process.env.USERNAME;
const PASSWORD = process.env.PASSWORD;
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

    const db = mysql.createConnection({
        host: DATABASE_HOST,
        port: DATABASE_PORT,
        user: USERNAME,
        password: PASSWORD,
        database: DATABASE_NAME
    });

    db.connect((error) => {
        if(error) throw error;
        console.log("Connected");
    });



    const query = `SELECT score FROM compatibility_scores WHERE westernId_1=${user_1.westernId} AND elementId_1=${user_1.elementId} AND animalId_1=${user_1.animalId} AND westernId_2=${user_2.westernId} AND elementId_2=${user_2.elementId} AND animalId_2=${user_2.animalId} AND type=0;`;

};
