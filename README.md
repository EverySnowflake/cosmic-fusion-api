# Cosmic Fusion API

Welcome to the Cosmic Fusion API documentation. This contains contains all of the documentation for each endpoint.

# Endpoints

Below is a list of all the available endpoints and how to use them.

## GetProfile

This endpoint takes **two** query strings and returns the metadata of an individual:

1. `dob`
2. `sex_at_birth`

Note: `dob` structure is `dd-mm-yyyy`

> Structure
api.cosmicfusions.com/get-profile?dob=${dob}&sex_at_birth=${sex_at_birth}

> Example usage
api.cosmicfusions.com/get-profile?dob=01-01-1900&sex_at_birth=1

### Expected Output

```
{
  "statusCode": 200,
  "headers": {
    "Content-Type": "application/json"
  },
  "body": [
    {
      "characterProfileId": 1090,
      "animalId": 4,
      "elementId": 0,
      "westernId": 10,
      "summary": "These girls can be really rather charming. Don't be fooled, hoodwinked or duped though, this is no pussycat, this is a hard nosed bruiser, a ruthless, single-minded, ferociously-ambitious cookie, who knew from about the age of six months exactly what she wanted to do. It may not be very feminine but these girls do love money, they'll doubtless deny it, but it'll fall on deaf ears. Capricorn Metal Rats love, love, love money and, unlike Leo girls who take the short cut and just marry it, these Trojans will work until they drop in order to accumulate as much of the stuff as they can. These girls are impressive, end of story. They're determined, organised, driven, grounded, scarily strong, powerful, secure, not remotely sensitive and have a single minded dedication to their career that might be described as blinkered. They're also sensible as hell - you certainly won't find this one keeling over at midnight somewhere north of Blackpool on a Saturday night. Don't get me wrong, they're not boring, they're terrific fun and will play pretty hard, but they'll never lose control, no way. They're chameleon-like at times, they can play the pussycat doll brilliantly but the claws on this pussycat doll would have King Kong running for the hills. Awesome.",
      "sex": 1,
      "isEdited": 1,
      "trio": "Capricorn Metal Rat"
    }
  ]
}
```

## GetYear

This endpoint takes **one** querystring and returns metadata about that day, month and year:

1. `date`

Note: `date` structure is `dd-mm-yyyy`

> Structure
api.cosmicfusions.com/get-year?date=${date}

> Example usage
api.cosmicfusions.com/get-year?date=01-01-1900

### Expected Output

```
{
  "statusCode": 200,
  "headers": {
    "Content-Type": "application/json"
  },
  "body": {
    "western": "Capricorn",
    "westernId": 10,
    "element": "Metal",
    "elementId": 0,
    "animal": "Rat",
    "animalId": 4,
    "trio": "Capricorn Metal Rat",
    "duo": "Metal Rat"
  }
}
```

## GetCelebs

This endpoint takes no query strings and returns an array of celebrities listed in the database

> Structure
api.cosmicfusions.com/get-celebs

> Example usage
api.cosmicfusions.com/get-celebs

### Expected Output
```
{
   "statusCode":200,
   "headers":{
      "Content-Type":"application/json"
   },
   "body":[
      {
         "name":"Brad Pitt",
         "description":"some description",
         "dateOfBirth":"1963-12-18T00:00:00.000Z",
         "sex":0,
         "animal_id":7,
         "element_id":2,
         "western_id":9,
         "image":"https://s3-eu-west-1.amazonaws.com/snowflake-2015/_6264840531431593370bradd_pitt.jpg"
      },
      {
         "name":"Michael Phelps",
         "description":"some description",
         "sex":0,
         "animal_id":5,
         "element_id":4,
         "western_id":4,
         "image":"https://s3-eu-west-1.amazonaws.com/snowflake-2015/_9800884271431594155michael_phelps.jpg"
      }
      ...
    ]
}
```

## GetFriend

This endpoint takes **four** query strings and returns data on two individuals:

1. `dob`
2. `sex_at_birth`
3. `friend_dob`
4. `friend_sex_at_birth`

> Structure
api.cosmicfusions.com/get-friend?dob=${dob}&sex_at_birth=${sex_at_birth}&friend_dob=${friend_dob}&friend_sex_at_birth=${friend_sex_at_birth}

> Example usage
api.cosmicfusions.com/get-friend?dob=01-01-1900&sex_at_birth=0&friend_dob=01-01-1900&friend_sex_at_birth=1

### Expected Output
```
{
   "statusCode":200,
   "headers":{
      "Content-Type":"application/json"
   },
   "body":{
      "combination_1":"Capricorn Metal Rat",
      "combination_2":"Capricorn Metal Rat",
      "character_profile_1":"Money, money, money, it's doubtless the Capricorn Metal Rats favourite song. They adore money, they'd marry it if they could. Their kids are probably called Buck, Nickel and Dime. You get the point. These boys will probably, like all Capricorn men, boringly deny that money is their singular goal in life. Tosh, utter tosh. They live and breathe it and, thankfully for them, they're blessed, imbued with, and possess one of the greatest work ethics known to man. If they could work 425 hours a week they would, even if they made their first million by their 21st birthday they wouldn't retire until their 110th birthday. Work and money, money and work, it's oxygen to these characters. They're so single minded no one can tell them what to do. You have to understand that these boys had written their 'life-plan' years before they left their cot. Many Capricorn men use charm to further their career, not these boys, not needed - they just chug along relentlessly until that life-plan goal is reached. They're hard nosed, ruthless, utterly determined juggernauts of self-belief and determination. They're not necessarily cuddly and they're pretty much obsessed by their quest for money and success but boy, are they impressive. ",
      "character_profile_2":"These girls can be really rather charming. Don't be fooled, hoodwinked or duped though, this is no pussycat, this is a hard nosed bruiser, a ruthless, single-minded, ferociously-ambitious cookie, who knew from about the age of six months exactly what she wanted to do. It may not be very feminine but these girls do love money, they'll doubtless deny it, but it'll fall on deaf ears. Capricorn Metal Rats love, love, love money and, unlike Leo girls who take the short cut and just marry it, these Trojans will work until they drop in order to accumulate as much of the stuff as they can. These girls are impressive, end of story. They're determined, organised, driven, grounded, scarily strong, powerful, secure, not remotely sensitive and have a single minded dedication to their career that might be described as blinkered. They're also sensible as hell - you certainly won't find this one keeling over at midnight somewhere north of Blackpool on a Saturday night. Don't get me wrong, they're not boring, they're terrific fun and will play pretty hard, but they'll never lose control, no way. They're chameleon-like at times, they can play the pussycat doll brilliantly but the claws on this pussycat doll would have King Kong running for the hills. Awesome.",
      "summary":"Hold on - don't fret, sweat or commence a mini-meltdown!\r\nThe point of the 1440 system is to act as a barometer - no more.  Anyone who finds themselves in the 0-30% bracket shouldn't for a moment consider their relationship as irreversibly flawed - it isn't but it does require much more effort in you two 'understanding, appreciating and comprehending' one another's characters.",
      "compatibility_score":22
   }
}
```