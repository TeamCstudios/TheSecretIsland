String fileLocation(String subfolder,String filename,String extension){
  String x = "";
  if(isOSX){
    x+= "/Library/Application Support/TeamCstudios/TheSecretIsland/";
  }
  x+=subfolder + "/";
  x+=filename + extension;
  return x;
}

void loadProgress(){
  String[] f = loadStrings(fileLocation("save","progress",".qqy"));
  if(f == null){
    loadflag = false;
    return;
  }
  tutorials = int(f[29]);
  floors = int(f[30]);
  hourOffset = int(f[31]);
  dayOffset = int(f[32]);
  monthOffset = int(f[33]);
  yearOffset = int(f[34]);
  gameHour = int(f[35]);
  gameDay = int(f[36]);
  gameMonth = int(f[37]);
  gameYear = int(f[38]);
  loadflag = true;
}

void saveProgress(){
  String[] f = new String[80];
  f[29] = "" + tutorials;
  f[30] = "" + floors;
  f[31] = "" + hourOffset;
  f[32] = "" + dayOffset;
  f[33] = "" + monthOffset;
  f[34] = "" + yearOffset;
  f[35] = "" + gameHour;
  f[36] = "" + gameDay;
  f[37] = "" + gameMonth;
  f[38] = "" + gameYear;
  saveStrings(fileLocation("save","progress",".qqy"),f);
}

void loadApartments(){
  String[] file = loadStrings(fileLocation("save","apartments",".qqy"));
  if(file == null){
    loadflag = false;
    return;
  }
  for(int i = 0; i < file.length / 2; i++){
    int l = i * 2;
    apartments[int(file[l])] = new House(int(file[l]),getByID(int(file[l+1])));
  }
  loadflag = true;
}

void saveApartments(){
  String[] f = new String[2 * 80];
  int g = 0;
  for(int i = 0; i < 80; i++){
    if(apartments[i] != null){
      if(apartments[i].isOccupied()){
        f[g * 2] = "" + apartments[i].getIndex();
        f[g * 2 + 1] = "" + apartments[i].aptResident().getID();
        g++;
      }
    }
  }
  saveStrings(fileLocation("save","apartments",".qqy"),f);
}

void loadIslanders(){
  String[] file = loadStrings(fileLocation("save","islanders",".qqy"));
  if(file == null){
    loadflag = false;
    return;
  }
  for(int i = 0; i < ISLANDER_CAP; i++){
    int l = i * 312;
    if(file[l] != null){
      float[] fr = new float[100];
      float[] ro = new float[100];
      int[] ot = new int[100];
      for(int j = 0; j < 100; j++){
        fr[j] = float(file[l + 12 + j]);
      }
      for(int j = 0; j < 100; j++){
        ro[j] = float(file[l + 112 + j]);
      }
      for(int j = 0; j < 100; j++){
        ot[j] = int(file[l + 212 + j]);
      }
      if(int(file[l]) != -1){
        islanders[int(file[l])] = new Islander(int(file[l]),file[l+1],file[l+2],int(file[l+3]),int(file[l+4]),int(file[l+5]),float(file[l+6]),int(file[l+7]),int(file[l+8]),int(file[l+9]),int(file[l+10]),file[l+11],fr,ro,ot);
      }
    }
  }
  file = loadStrings(fileLocation("save","islanders-0",".qqy"));
  float[] fr = new float[100];
  float[] ro = new float[100];
  int[] ot = new int[100];
  for(int j = 0; j < 100; j++){
    fr[j] = float(file[12 + j]);
  }
  for(int j = 0; j < 100; j++){
    ro[j] = float(file[112 + j]);
  }
  for(int j = 0; j < 100; j++){
    ot[j] = int(file[212 + j]);
  }
  islanders[int(file[0])] = new Islander(int(file[0]),file[1],file[2],int(file[3]),int(file[4]),int(file[5]),float(file[6]),int(file[7]),int(file[8]),int(file[9]),int(file[10]),file[11],fr,ro,ot);
  loadflag = true;
}

void saveIslanders(){
  String[] f = new String[312 * ISLANDER_CAP + 1];
  int g = 0;
  for(int i = 0; i < ISLANDER_CAP; i++){
    if(getByID(i) != null){
      f[g * 312 + 0] = "" + getByID(i).getID();
      f[g * 312 + 1] = "" + getByID(i).getFirstName();
      f[g * 312 + 2] = "" + getByID(i).getLastName();
      f[g * 312 + 3] = "" + getByID(i).getAge();
      f[g * 312 + 4] = "" + getByID(i).getBdayDay();
      f[g * 312 + 5] = "" + getByID(i).getBdayMonth();
      f[g * 312 + 6] = "" + getByID(i).getSexuality();
      f[g * 312 + 7] = "" + getByID(i).getGender();
      f[g * 312 + 8] = "" + red(getByID(i).getColor());
      f[g * 312 + 9] = "" + green(getByID(i).getColor());
      f[g * 312 + 10] = "" + blue(getByID(i).getColor());
      f[g * 312 + 11] = "" + getByID(i).getCatchphrase();
      for(int j = 0; j < 100; j++){
        if(getByID(j) != null){
          f[g * 312 + 12 + j] = "" + getByID(i).getFriendship(getByID(j));
        }else{
          f[g * 312 + 12 + j] = "0.0";
        }
      }
      for(int j = 0; j < 100; j++){
        if(getByID(j) != null){
          f[g * 312 + 112 + j] = "" + getByID(i).getRomance(getByID(j));
        }else{
          f[g * 312 + 112 + j] = "0.0";
        }
      }
      for(int j = 0; j < 100; j++){
        if(getByID(j) != null){
          f[g * 312 + 212 + j] = "" + getByID(i).getOther(getByID(j));
        }else{
          f[g * 312 + 212 + j] = "0";
        }
      }
      g++;
    }
  }
  saveStrings(fileLocation("save","islanders",".qqy"),f);
  f = new String[312];
  f[0] = "" + apartments[0].aptResident().getID();
  f[1] = "" + apartments[0].aptResident().getFirstName();
  f[2] = "" + apartments[0].aptResident().getLastName();
  f[3] = "" + apartments[0].aptResident().getAge();
  f[4] = "" + apartments[0].aptResident().getBdayDay();
  f[5] = "" + apartments[0].aptResident().getBdayMonth();
  f[6] = "" + apartments[0].aptResident().getSexuality();
  f[7] = "" + apartments[0].aptResident().getGender();
  f[8] = "" + red(apartments[0].aptResident().getColor());
  f[9] = "" + green(apartments[0].aptResident().getColor());
  f[10] = "" + blue(apartments[0].aptResident().getColor());
  f[11] = "" + apartments[0].aptResident().getCatchphrase();
  for(int j = 0; j < 100; j++){
    if(getByID(j) != null){
      f[12 + j] = "" + apartments[0].aptResident().getFriendship(getByID(j));
    }else{
      f[12 + j] = "0.0";
    }
  }
  for(int j = 0; j < 100; j++){
    if(getByID(j) != null){
      f[112 + j] = "" + apartments[0].aptResident().getRomance(getByID(j));
    }else{
      f[112 + j] = "0.0";
    }
  }
  for(int j = 0; j < 100; j++){
    if(getByID(j) != null){
      f[212 + j] = "" + apartments[0].aptResident().getOther(getByID(j));
    }else{
      f[212 + j] = "0";
    }
  }
  saveStrings(fileLocation("save","islanders-0",".qqy"),f);
}
