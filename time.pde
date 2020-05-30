String writeTime(){
  String z = "";
  if(TIME_FORMAT == "12"){
    int h = gameHour % 12;
    if(h == 0){h = 12;}
    z+= h + ":" + minute() + ":" + second() + "\n";
  }else if(TIME_FORMAT == "24"){
    z+= gameHour + ":" + minute() + ":" + second() + "\n";
  }
  if(DATE_FORMAT == "MDY"){
    z+= gameMonth + "/" + gameDay + "/" + gameYear;
  }else if(DATE_FORMAT == "DMY"){
    z+= gameDay + "/" + gameMonth + "/" + gameYear;
  }else if(DATE_FORMAT == "YDM"){
    z+= gameYear + "/" + gameDay + "/" + gameMonth;
  }else if(DATE_FORMAT == "YMD"){
    z+= gameYear + "/" + gameMonth + "/" + gameDay;
  }
  return z;
}

void updateTime(){
  gameHour = hour() + hourOffset;
  if(gameHour > 23){
    gameHour = 0;
    hourOffset = 0;
  }
  if(monthOffset + month() > 12){
    monthOffset = -1 * month() + 1;
    yearOffset++;
  }
  gameYear = year() + yearOffset;
  gameMonth = month() + monthOffset;
  if((gameMonth == 4 || gameMonth == 5 || gameMonth == 9 || gameMonth == 11) && day() + dayOffset > 30){
    dayOffset = -1 * day() + 1;
    monthOffset++;
  }else if(isLeapYear(gameYear) && gameMonth == 2 && day() + dayOffset > 29){
    dayOffset = -1 * day() + 1;
    monthOffset++;
  }else if(!(isLeapYear(gameYear)) && gameMonth == 2 && day() + dayOffset > 28){
    dayOffset = -1 * day() + 1;
    monthOffset++;
  }else if(day() + dayOffset > 31){
    dayOffset = -1 * day() + 1;
    monthOffset++;
  }
  gameDay = day() + dayOffset;
  gameMonth = month() + monthOffset;
}

boolean isLeapYear(int year){
  if(year % 8000 == 0){
    return false;
  }
  if(year % 400 == 0){
    return true;
  }
  if(year % 100 == 0){
    return false;
  }
  if(year % 4 == 0){
    return true;
  }
  return false;
}
