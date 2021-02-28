class getZodiacCombination {

  constructor(dob, sex){
    this.dob = dob;
    this.sex = sex;
    if (!Array.isArray(dob) || !dob.length) {
        throw new Error('DOB has not been passed in the correct format. Please ensure DOB is an array.');
    }
    this.dateArray = dob.split("-");
    this.day = Number(this.dateArray[0]);
    this.month = Number(this.dateArray[1]);
    this.year = Number(this.dateArray[2]);
    this.yearSuffix = Number(dob.slice(-1));
}

    western(day, month){
        const zodiacSigns = {
            "capricorn":{"western": "Capricorn", "westernId": 10},
            "aquarius":{"western": "Aquarius", "westernId": 11},
            "pisces": {"western": "Pisces", "westernId": 12},
            "aries": {"western": "Aries", "westernId": 1},
            "taurus":{"western": "Taurus", "westernId": 2},
            "gemini":{"western": "Gemini", "westernId": 3},
            "cancer": {"western": "Cancer", "westernId": 4},
            "leo": {"western": "Leo", "westernId": 5},
            "virgo": {"western": "Virgo", "westernId": 6},
            "libra": {"western": "Libra", "westernId": 7},
            "scorpio" : {"western": "Scorpio", "westernId": 8},
            "sagittarius": {"western": "Sagittarius", "westernId": 9}
          };
        
          if((month === 1 && day <= 20) || (month === 12 && day >=22)) {
            return zodiacSigns.capricorn;
          } else if ((month == 1 && day >= 21) || (month == 2 && day <= 18)) {
            return zodiacSigns.aquarius;
          } else if((month == 2 && day >= 19) || (month == 3 && day <= 20)) {
            return zodiacSigns.pisces;
          } else if((month == 3 && day >= 21) || (month == 4 && day <= 20)) {
            return zodiacSigns.aries;
          } else if((month === 4 && day >= 21) || (month == 5 && day <= 20)) {
            return zodiacSigns.taurus;
          } else if((month == 5 && day >= 21) || (month == 6 && day <= 20)) {
            return zodiacSigns.gemini;
          } else if((month == 6 && day >= 22) || (month == 7 && day <= 22)) {
            return zodiacSigns.cancer;
          } else if((month == 7 && day >= 23) || (month == 8 && day <= 23)) {
            return zodiacSigns.leo;
          } else if((month == 8 && day >= 24) || (month == 9 && day <= 23)) {
            return zodiacSigns.virgo;
          } else if((month == 9 && day >= 24) || (month == 10 && day <= 23)) {
            return zodiacSigns.libra;
          } else if((month == 10 && day >= 24) || (month == 11 && day <= 22)) {
            return zodiacSigns.scorpio;
          } else if((month == 11 && day >= 23) || (month == 12 && day <= 21)) {
            return zodiacSigns.sagittarius;
          }
    }

    element(yearSuffix) {
        switch (yearSuffix) {
            case 0:
            case 1:
                return {"element": "Metal", "elementId": 0};
            case 2:
            case 3:
                return {"element": "Water", "elementId": 2};
            case 4:
            case 5:
                return {"element": "Wood", "elementId": 4};
            case 6:
            case 7:
                return {"element": "Fire", "elementId": 6};
            case 8:
            case 9:
                return {"element": "Earth", "elementId": 8};
        }
    }

    animal(year){
        switch ((year - 4) % 12) {
            case 0:
                return {"animal": "Rat", "animalId": 4};
    
            case 1:
                return {"animal": "Ox", "animalId": 5};
    
            case 2:
                return {"animal": "Tiger", "animalId": 6};
    
            case 3:
                return {"animal": "Rabbit", "animalId": 7};
    
            case 4:
                return {"animal": "Dragon", "animalId": 8};
    
            case 5:
                return {"animal": "Snake", "animalId": 9};
    
            case 6:
                return {"animal": "Horse", "animalId": 10};
    
            case 7:
                return {"animal": "Goat", "animalId": 11};
    
            case 8:
                return {"animal": "Monkey", "animalId": 0};
    
            case 9:
                return {"animal": "Rooster", "animalId": 1};
    
            case 10:
                return {"animal": "Dog", "animalId": 2};
    
            case 11:
                return {"animal": "Pig", "animalId": 3};
    
        }
    }

    getInfo() {
        const western = this.western(this.day, this.month);
        const element = this.element(this.yearSuffix);
        const animal = this.animal(this.year);
        const trio = `${western.western} ${element.element} ${animal.animal}`;
        const duo = `${element.element} ${animal.animal}`;
        return {
            ...western,
            ...element,
            ...animal,
            ...{"sex": this.sex},
            ...{"trio": trio},
            ...{"duo": duo}
        };
    }
}

module.exports = getZodiacCombination;
