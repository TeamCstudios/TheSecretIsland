// CHANGE TO TRUE ON OSX RELEASE
final boolean isOSX = false;

final int ISLANDER_CAP = 100; final int EVENT_CAP = 30; final String DATE_FORMAT  = "MDY"; final String TIME_FORMAT = "12"; boolean loadflag = false; int passedNum;
int scene = 0; PFont a;PFont b;int gameHour;int gameDay;int gameMonth; int gameYear;int hourOffset;int dayOffset;int monthOffset; int yearOffset;
int creatorSelection = 0; int creatorMode = 0;String textEntryA = ""; String textEntryB = ""; int islanderEntryA; int islanderEntryB; int numEntryA; int numEntryB; int numEntryC; int numEntryD; int numEntryE; int numEntryF; int numEntryG; int numEntryH;
int floors = 3; int tutorials = 0; boolean typeSomething = false; boolean choices = false; String choiceA; String choiceB; String choiceC; int option = 0;

void setup(){
  a = loadFont("Monospaced-36.vlw");
  b = loadFont("TrebuchetMS-20.vlw");
  size(1000,500);
  frameRate(45);
  loadIslanders();
  loadApartments();
  loadProgress();
  if(loadflag){
    for(int i = 0; i < 5 + second() % 10; i++){
      createEvent();
    }
  }
}

void draw(){
  int t = 180 - (abs(gameHour - 12) * 15);
  background(t + 20,t + 30,t + 70);
  updateTime();
  if(scene == 0){
    drawApts();
    aptsMouseHandler();
    if(frameCount % 1051 == 567){
      createEvent();
    }
  }else if(scene == 20){
    roofScene(passedNum);
  }else if(scene == 100){
    creationScreen();
  }else if(scene < 300 && scene > 199){
    apartmentScene(scene % 200);
  }
  drawLeftScreen();
  if(scene < 300 && scene > 199){
    islanderInformation(getAptByID(scene % 200));
  }
  if(typeSomething){
    typeSomething();
  }
}

void typeSomething(){
  stroke(0);
  fill(55);
  rect(500,100,499,30);
  rect(500,130,150,30);
  fill(125);
  textFont(b);
  textSize(20);
  text("Type Something: " + textEntryA,505,120);
  text("PRESS ENTER",505,150);
}

void setChoices(String a, String b, String c){
  choiceA = a;
  choiceB = b;
  choiceC = c;
  choices = true;
}

void drawChoices(){
  stroke(0);
  fill(55);
  rect(800,130,200,50);
  rect(800,180,200,50);
  rect(800,230,200,50);
  fill(155);
  textFont(a);
  textSize(20);
  text("1:" + choiceA,800,155);
  text("2:" + choiceB,800,205);
  text("3:" + choiceC,800,255);
}

void keyPressed(){
  if(choices){
    if(keyCode == '1'){
      option = 1;
      choices = false;
    }else if(keyCode == '2'){
      option = 2;
      choices = false;
    }else if(keyCode == '3'){
      option = 3;
      choices = false;
    }
  }
  if(scene == 100){
    if(keyCode == UP){
      if(creatorSelection > 0){
        creatorSelection--;
      }
    }
    if(keyCode == DOWN){
      if(creatorSelection < 10){
        creatorSelection++;
      }
    }
    if(creatorSelection == 0){
      if(keyCode == '\n' || keyCode == CONTROL){
        textEntryA = "";
      }else if(keyCode != LEFT && keyCode != RIGHT && keyCode != UP && keyCode != DOWN && keyCode != SHIFT){
        if(textEntryA.equals("")){
          textEntryA+=char(keyCode);
        }else{
          String x = "" + char(keyCode);
          textEntryA+=x.toLowerCase();
        }
      }
    }else if(creatorSelection == 1){
      if(keyCode == '\n' || keyCode == CONTROL){
        textEntryB = "";
      }else if(keyCode != LEFT && keyCode != RIGHT && keyCode != UP && keyCode != DOWN && keyCode != SHIFT){
        if(textEntryB.equals("")){
          textEntryB+=char(keyCode);
        }else{
          String x = "" + char(keyCode);
          textEntryB+=x.toLowerCase();
        }
      }
    }else if(creatorSelection == 2){
      if(keyCode == LEFT){
        if(numEntryA > 1){
          numEntryA--;  
        }
      }else if(keyCode == RIGHT){
        if(numEntryA < 12){
          numEntryA++;  
        }
      }
    }else if(creatorSelection == 3){
      if(keyCode == LEFT){
        if(numEntryB > 1){
          numEntryB--;  
        }
      }else if(keyCode == RIGHT){
        if(numEntryB < 31){
          numEntryB++;  
        }
      }
    }else if(creatorSelection == 4){
      if(keyCode == LEFT){
        if(numEntryC > 0){
          numEntryC--;  
        }
      }else if(keyCode == RIGHT){
        if(numEntryC < 120){
          numEntryC++;  
        }
      }
    }else if(creatorSelection == 5){
      if(keyCode == LEFT){
        if(numEntryD > 0){
          numEntryD--;  
        }
      }else if(keyCode == RIGHT){
        if(numEntryD < 6){
          numEntryD++;  
        }
      }
    }else if(creatorSelection == 6){
      if(keyCode == LEFT){
        if(numEntryE > 0){
          numEntryE--;  
        }
      }else if(keyCode == RIGHT){
        if(numEntryE < 3){
          numEntryE++;  
        }
      }
    }else if(creatorSelection == 7  && creatorMode == 0){
      if(keyCode == LEFT){
        if(numEntryF > 0){
          numEntryF-= 5;  
        }
      }else if(keyCode == RIGHT){
        if(numEntryF < 255){
          numEntryF+= 5;  
        }
      }
    }else if(creatorSelection == 8  && creatorMode == 0){
      if(keyCode == LEFT){
        if(numEntryG > 0){
          numEntryG-= 5;  
        }
      }else if(keyCode == RIGHT){
        if(numEntryG < 255){
          numEntryG+= 5;  
        }
      }
    }else if(creatorSelection == 9  && creatorMode == 0){
      if(keyCode == LEFT){
        if(numEntryH > 0){
          numEntryH-= 5;  
        }
      }else if(keyCode == RIGHT){
        if(numEntryH < 255){
          numEntryH+= 5;  
        }
      }
    }else if(creatorSelection == 7 && creatorMode == 1){
      if(keyCode == LEFT){
        if(islanderEntryA > -1){
          islanderEntryA--;  
        }
      }else if(keyCode == RIGHT){
        if(islanderEntryA < ISLANDER_CAP - 1){
          islanderEntryA++;  
        }
      }
    }else if(creatorSelection == 8 && creatorMode == 1){
      if(keyCode == LEFT){
        if(islanderEntryB > -1){
          islanderEntryB--;  
        }
      }else if(keyCode == RIGHT){
        if(islanderEntryB < ISLANDER_CAP - 1){
          islanderEntryB++;  
        }
      }
    }else if(creatorSelection == 10){
      if(keyCode == ENTER){
        int i = nextAvailableIslander();
        if(i != -1){
          if(creatorMode == 0){
            islanders[i] = new Islander(i,textEntryA,textEntryB,numEntryC,numEntryB,numEntryA,float(numEntryD) / 6,numEntryE,numEntryF,numEntryG,numEntryH); 
          }else{
            islanders[i] = new Islander(i,textEntryA,textEntryB,numEntryC,numEntryB,numEntryA,float(numEntryD) / 6,numEntryE,islanderEntryA,islanderEntryB); 
          }
          apartments[nextAvailableApt()] = new House(nextAvailableApt(),getByID(i));
        }  
        scene = 0;
      }
    }
  }else if(scene > 199 && scene < 300){
    if(keyCode == CONTROL){
      scene = 0;
      typeSomething = false;
    }
  }
  if(typeSomething){
    if(keyCode == '\n'){
      typeSomething = false;
      if(getCurrentEvent(getAptByID(scene % 200)).getEventType() == 0 && getCurrentEvent(getAptByID(scene % 200)).getEventSubtype() == 0 && getCurrentEvent(getAptByID(scene % 200)).getProgress() == 1){
        getAptByID(scene % 200).aptResident().setCatchphrase(textEntryA);
        getCurrentEvent(getAptByID(scene % 200)).setProgress(2);
      }
    }else if(keyCode == CONTROL){
      textEntryA = "";
    }else if(keyCode != LEFT && keyCode != RIGHT && keyCode != UP && keyCode != DOWN && keyCode != SHIFT){
        if(textEntryA.equals("")){
        textEntryA+=char(keyCode);
      }else{
        String x = "" + char(keyCode);
        textEntryA+=x.toLowerCase();
      }
    }
  }
  if(keyCode == ']' || keyCode == '}'){
    createEvent();
  }
  if(keyCode == '=' || keyCode == '+'){
    if(creatorMode == 0){
      creatorMode = 1;
    }else{
      creatorMode = 0;
    }
  }
}

void drawLeftScreen(){
  fill(85);
  stroke(0);
  rect(0,0,500,499);
  textFont(a);
  textSize(36);
  fill(155);
  text(writeTime(),5,30);
  if(scene == 0){
    fill(25);
    rect(0,460,270,39);
    fill(155);
    if(creatorMode == 0){
      text("New Islander",5,485);
    }else{
      text("*New Islander",5,485);
    }
  }
  fill(25);
  rect(300,460,200,39);
  fill(155);
  text("Save+Exit",305,485);
}

void islanderInformation(House h){
  Islander i = h.aptResident();
  fill(i.getColor());
  textFont(a);
  textSize(36);
  text(i.getName(),200,100);
  fill(155);
  textFont(b);
  textSize(20);
  if(i.getAge() > 16){
    text("Age: Adult",210,130);
  }else if(i.getAge() > 12){
    text("Age: Teen",210,130);
  }else if(i.getAge() > 5){
    text("Age: Child",210,130);
  }else{
    text("Age: Infant",210,130);
  }
  if(i.getPartner() == null){
    text("No Partner",210,150);
  }else if(i.getOther(i.getPartner()) == 3){
    if(i.getPartner().getGender() == 0){
      text("Boyfriend: " + i.getPartner().getName(),210,150);
    }else if(i.getPartner().getGender() == 1){
      text("Girlfriend: " + i.getPartner().getName(),210,150);
    }else{
      text("Datefriend: " + i.getPartner().getName(),210,150);
    }
  }else if(i.getOther(i.getPartner()) == 4){
    if(i.getPartner().getGender() == 0){
      text("Husband: " + i.getPartner().getName(),210,150);
    }else if(i.getPartner().getGender() == 1){
      text("Wife: " + i.getPartner().getName(),210,150);
    }else{
      text("Spouse: " + i.getPartner().getName(),210,150);
    }
  }
  text("Friends: " + i.getFriends(),210,170);
}

void apartmentScene(int aptNum){
  background(125);
  textFont(a);
  textSize(36);
  text("Apartment #" + (100 * (aptNum / 10 + 1) + aptNum % 10),505,30);
  fill(155);
  drawAptChat();
  textFont(b);
  textSize(12);
  text("PRESS CONTROL TO RETURN",510,480);
  if(choices){
    drawChoices();
  }
  if(frameCount % 125 == 0){
    if(getCurrentEvent(getAptByID(aptNum)) != null){
      getCurrentEvent(getAptByID(aptNum)).playNextDialouge();
    }
  }
}  

void roofScene(int aptNum){
  drawAptChat();
  if(frameCount % 125 == 0){
    if(getCurrentEvent(getAptByID(aptNum)) != null){
      getCurrentEvent(getAptByID(aptNum)).playNextDialouge();
    }
  }
}

void mousePressed(){
  if(mouseX < 270 && mouseY > 460){
    creatorSelection = 0;
    textEntryA = "";
    textEntryB = "";
    numEntryA = gameMonth;
    numEntryB = gameDay;
    numEntryC = 21;
    numEntryD = 3;
    numEntryE = 0;
    numEntryF = 155;
    numEntryG = 155;
    numEntryH = 155;
    scene = 100;
  }
  if(mouseX > 300 && mouseX < 500 && mouseY > 460){
    saveIslanders();
    saveApartments();
    saveProgress();
    exit();
  }
  for(int i = 0; i < floors; i++){
    for(int j = 0; j < 10; j++){
      int ca = i * 10 + j;
      if(apartments[ca] == null){
        return;
      }else if(apartments[ca].isOccupied()){
        if(mouseX > 555 + 40 * j && mouseX < 585 + 40 * j && mouseY > 435 - 30 * i && mouseY < 455 - 30 * i){
          clearAptChat();
          greeting(i * 10 + j);
          scene = 200 + i * 10 + j;
        }
      }
    }
  }
}
void drawApts(){
  noStroke();
  fill(0,235,0);
  rect(501,425,500,75);
  stroke(20);
  fill(95,105,95);
  int g = 8 - floors;
  rect(550,200 + g * 25,400,275 - g * 25);
  quad(1000,150 + g * 25,950,200 + g * 25,950,475,1000,425);
  fill(125,135,125);
  quad(550,200 + g * 25,600,150 + g * 25,1000,150 + g * 25,950,200 + g * 25);
  for(int i = 0; i < floors; i++){
    for(int j = 0; j < 10; j++){
      int ca = i * 10 + j;
      stroke(0);
      if(apartments[ca] == null){
        fill(10,20,10);
      }else if(!apartments[ca].isOccupied()){
        fill(10,20,10);
      }else if(apartments[ca].isOccupied()){
        if(mouseX > 555 + 40 * j && mouseX < 585 + 40 * j && mouseY > 435 - 30 * i && mouseY < 455 - 30 * i){
          stroke(255);
        }
        fill(230,245,0);
        
      }
      rect(555 + 40 * j,435 - 30 * i,30,20);
      if(getCurrentEvent(apartments[ca]) != null){
        if(getCurrentEvent(apartments[ca]).getEventType() == 0){
          textFont(a);
          textSize(20);
          fill(30,120,20);
          text("...",553 + 40 * j,450 - 30 * i);
          if(getCurrentEvent(apartments[ca]).getProgress() != 0){
            getCurrentEvent(apartments[ca]).eraseEvent();
          }
        }else if(getCurrentEvent(apartments[ca]).getEventType() == 1){
          textFont(a);
          textSize(20);
          fill(250,120,20);
          text("!",560 + 40 * j,450 - 30 * i);
          if(getCurrentEvent(apartments[ca]).getProgress() != 0){
            getCurrentEvent(apartments[ca]).eraseEvent();
          }
        }else if(getCurrentEvent(apartments[ca]).getEventType() == 2){
          textFont(a);
          textSize(20);
          fill(250,120,20);
          text("$",560 + 40 * j,450 - 30 * i);
          if(getCurrentEvent(apartments[ca]).getProgress() != 0){
            getCurrentEvent(apartments[ca]).eraseEvent();
          }
        }else if(getCurrentEvent(apartments[ca]).getEventType() == 3){
          textFont(a);
          textSize(20);
          fill(255,152,203);
          text("?",558 + 40 * j,450 - 30 * i);
          if(getCurrentEvent(apartments[ca]).getProgress() != 0){
            getCurrentEvent(apartments[ca]).eraseEvent();
          }
        }  
      }
    }
  }
}

void aptsMouseHandler(){
  for(int i = 0; i < floors; i++){
    for(int j = 0; j < 10; j++){
      int ca = i * 10 + j;
      if(apartments[ca] == null){
        return;
      }else if(apartments[ca].isOccupied() && mouseX > 555 + 40 * j && mouseX < 585 + 40 * j && mouseY > 435 - 30 * i && mouseY < 455 - 30 * i){
        textFont(b);
        textSize(20);
        fill(apartments[ca].aptResident().getColor());
        text(apartments[ca].aptResident().getName(),mouseX - 35,mouseY - 15);
      }
    }
  }
}

void creationScreen(){
  background(125);
  textFont(b);
  textSize(22);
  text("Create an Islander",505,30);
  fill(155);
  if(creatorSelection == 0){
    text("First Name: [" + textEntryA + "]",505,80);
  }else{
    text("First Name:  " + textEntryA,505,80);
  }
  if(creatorSelection == 1){
    text("Last Name:  [" + textEntryB + "]",505,100);
  }else{
    text("Last Name:   " + textEntryB,505,100);
  }
  if(creatorSelection == 2){
    text("Birthday: [" + numEntryA + "]/" + numEntryB,505,120);
  }else if(creatorSelection == 3){
    text("Birthday: " + numEntryA + "/[" + numEntryB + "]",505,120);
  }else{
    text("Birthday: " + numEntryA + "/" + numEntryB,505,120);
  }
  if(creatorSelection == 4){
    text("Age:  [" + numEntryC + "]",505,140);
  }else{
    text("Age:   " + numEntryC,505,140);
  }
  String l = "";
  if(numEntryD == 0){
    l = "Very Straight";
  }else if(numEntryD == 1){
    l = "Straight";
  }else if(numEntryD == 2){
    l = "Somewhat Straight";
  }else if(numEntryD == 3){
    l = "Bisexual";
  }else if(numEntryD == 4){
    l = "Somewhat Gay";
  }else if(numEntryD == 5){
    l = "Gay";
  }else if(numEntryD == 6){
    l = "Very Gay";
  }
  if(creatorSelection == 5){
    text("Sexuality:  [" + l + "]",505,160);
  }else{
    text("Sexuality:   " + l,505,160);
  }
  if(numEntryE == 0){
    l = "Male";
  }else if(numEntryE == 1){
    l = "Female";
  }else if(numEntryE == 2){
    l = "Non-Binary (can make others pregnant)";
  }else if(numEntryE == 3){
    l = "Non-Binary (can become pregnant)";
  }
  if(creatorSelection == 6){
    text("Gender:  [" + l + "]",505,180);
  }else{
    text("Gender:   " + l,505,180);
  }
  if(creatorMode == 0){
    fill(numEntryF,numEntryG,numEntryH);
    if(creatorSelection == 7){
      text("Text Color: [" + numEntryF + "]," + numEntryG + "," + numEntryH,505,200);
    }else if(creatorSelection == 8){
      text("Text Color:  " + numEntryF + ",[" + numEntryG + "]," + numEntryH,505,200);
    }else if(creatorSelection == 9){
      text("Text Color:  " + numEntryF + "," + numEntryG + ",[" + numEntryH + "]",505,200);
    }else{
      text("Text Color:  " + numEntryF + "," + numEntryG + "," + numEntryH,505,200);
    }
  }else{
    Islander a = getByID(islanderEntryA);
    Islander b = getByID(islanderEntryB);
    String at;
    String bt;
    if(a == null){
      at = "null";
    }else{
      at = a.getName();
    }
    if(b == null){
      bt = "null";
    }else{
      bt = b.getName();
    }
    if(creatorSelection == 7){
      text("Parents: [" + at + "]," + bt + "",505,200);
    }else if(creatorSelection == 8){
      text("Parents:  " + at + ",[" + bt + "]",505,200);
    }else{
      text("Parents:  " + at + "," + bt + "",505,200);
    }
  }
  if(creatorSelection == 10){
    text("[" + "PRESS ENTER" + "]",505,220);
  }else{
    text("...",505,220);
  }
}
