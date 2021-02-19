# Cosmic Fusion API

Welcome to the Cosmic Fusion API documentation. This document contains all of the documentation for each endpoint

# Endpoints

Below is a list of all the available endpoints and how to use them.

## GetProfile

This endpoint takes **two** query strings and returns the metadata of an individual:

1. `dob``
2. `sex_at_birth`

Note: `dob` structure is `dd-mm-yyyy`

> Structure
https://cosmicfusion.com/getprofile?dob=${dob}&sex_at_birth=${sex_at_birth}

> Example usage
https://cosmicfusion.com/getprofile?dob=01-01-1900&sex_at_birth=1

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
https://cosmicfusion.com/getprofile?date=${date}

> Example usage
https://cosmicfusion.com/getprofile?date=01-01-1900

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


# lambda

# api gateway

# deployment pipeline