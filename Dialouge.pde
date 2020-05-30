Dialouge[] aptChat = new Dialouge[10];
public class Dialouge{
  public String content; public color textColor;
  public Dialouge(String message, color tColor){
    content = message;
    textColor = tColor;
  }
  void drawDialouge(int x, int y, PFont font, int size){
    textFont(font);
    textSize(size);
    fill(textColor);
    text(content,x,y);
  }
}

void addAptChat(String text, color c){
  for(int i = 9; i > 0; i--){
    aptChat[i] = aptChat[i-1];
  }
  aptChat[0] = new Dialouge(text,c);
}

void drawAptChat(){
  for(int i = 0; i < 10; i++){
    aptChat[i].drawDialouge(510,450 - i * 20,b,20);
  }
}

void clearAptChat(){
  for(int i = 0; i < 10; i++){
    aptChat[i] = new Dialouge("",color(155));
  }
}

void greeting(int aptNum){
  float r = random(1);
  if(r > .8){
    addAptChat("How are you doing?",apartments[aptNum].aptResident().getColor());
  }else if(r > .5){
    if(apartments[aptNum].aptResident().getCatchphrase() == ""){
      addAptChat("How are you doing?",apartments[aptNum].aptResident().getColor());
    }else{
      addAptChat(apartments[aptNum].aptResident().getCatchphrase(),apartments[aptNum].aptResident().getColor());
    }
  }else if(r > .3){
    addAptChat("Hi.",apartments[aptNum].aptResident().getColor());
  }else if(r > .1){
    addAptChat("Welcome!",apartments[aptNum].aptResident().getColor());
  }else{
    addAptChat("This island sure is a great place.",apartments[aptNum].aptResident().getColor());
  }
}
