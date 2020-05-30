Event[] events = new Event[EVENT_CAP];
/*
---EVENTS---

0 (Green ... / Miscellaneous)
0.0 - Catchphrase (1)
The islander asks for a catchphrase. This is saved into the Islander object.
0.1 - New Islander (1)
The islander asks that you add a new person to the island.
0.2 - Tutorial (1)
The islander gives you a tip.

1 (Orange ! / Friendship)
1.0 - Introduce (2)
The islander asks to be introduced to an islander they have not met before (frienship 0.0)

2 (Red $ / Story)
2.0 - Store building
The islander helps with the store that is next in line to be built.

3 (Pink ? / Romance)
3.0 - Compatability (2)
The islander asks if they and a potential romantic interest are compatible.
3.1 - Confession: Justified, Simple (2)
The islander confesses to their strongest romantic interest. On a success, they become partners.

*/
public class Event{
  private int progress;private int type; private int subtype; private int person1; private int person2; private int person3; private int person4; private int person5;
  public Event(int t, int st, int i){progress = 0;type = t;subtype = st;person1 = i;}
  public Event(int t, int st, int i1, int i2){progress = 0;type = t;subtype = st;person1 = i1;person2 = i2;}
  public Event(int t, int st, int i1, int i2, int i3){progress = 0;type = t;subtype = st;person1 = i1;person2 = i2;person3 = i3;}
  public Event(int t, int st, int i1, int i2, int i3, int i4){progress = 0;type = t;subtype = st;person1 = i1;person2 = i2;person3 = i3;person4 = i4;}
  public Event(int t, int st, int i1, int i2, int i3, int i4, int i5){progress = 0;type = t;subtype = st;person1 = i1;person2 = i2;person3 = i3;person4 = i4;person5 = i5;}
  int getProgress(){return progress;}
  int getEventIslander(){return person1;}
  int getEventIslander2(){return person2;}
  int getEventIslander3(){return person3;}
  int getEventIslander4(){return person4;}
  int getEventIslander5(){return person5;}
  int getEventType(){return type;}
  int getEventSubtype(){return subtype;}
  void playNextDialouge(){
    if(type == 0){
      if(subtype == 0){
        if(progress == 0){
          if(getByID(person1).getCatchphrase() == ""){
            addAptChat("I need a catchphrase. What should it be?",getByID(person1).getColor());
          }else{
            addAptChat("I need a new catchphrase.",getByID(person1).getColor());
          }
          textEntryA = "";
          typeSomething = true;
          progress = 1;
        }else if(progress == 2){
          addAptChat(getByID(person1).getCatchphrase(),color(155));
          addAptChat("Okay. \"" + getByID(person1).getCatchphrase() + "\". I like it!",getByID(person1).getColor());
          progress = 3;
        }else if(progress == 3){
          this.eraseEvent();
        }
      }else if(subtype == 1){
        if(progress == 0){
          addAptChat("We need more people on this island.",getByID(person1).getColor());
          progress = 1;
        }else if(progress == 1){
          addAptChat("Could you get them to move in?",getByID(person1).getColor());
          this.eraseEvent();
        }
      }else if(subtype == 2){
        if(tutorials == 0){
          addAptChat("Here's a tip: you need the help of islanders",getByID(person1).getColor());
          addAptChat("to build the stores in the Commercial District",getByID(person1).getColor());
          this.eraseEvent();
          tutorials++;
        }else if(tutorials == 1){
          addAptChat("Here's a tip: The Masquerade Ball is held",getByID(person1).getColor());
          addAptChat("every 27th of the month at 5PM.",getByID(person1).getColor());
          addAptChat("The host is chosen randomly by drawing slips of paper.",getByID(person1).getColor());
          this.eraseEvent();
          tutorials++;
        }else if(tutorials == 2){
          addAptChat("Here's a tip: Islander donations are held every",getByID(person1).getColor());
          addAptChat("Wednesday at 10AM and Sunday at 7PM.",getByID(person1).getColor());
          this.eraseEvent();
          tutorials++;
        }else if(tutorials == 3){
          addAptChat("Here's a tip: The Secret Store allows you to",getByID(person1).getColor());
          addAptChat("buy items such as time-travel tokens and aging potions.",getByID(person1).getColor());
          addAptChat("It has to be built first, though.",getByID(person1).getColor());
          this.eraseEvent();
          tutorials++;
        }
      }
    }else if(type == 1){
      if(subtype == 0){
        if(progress == 0){
          addAptChat("Can you introduce me to " + getByID(person2).getName() + "?",getByID(person1).getColor());
          setChoices("Yes.","No.","Not now.");
          progress = 1;
        }else if(progress == 1){
          if(option == 1){
            option = 0;
            addAptChat("Sure. I'll bring them over right now...",color(155));
            progress = 2;
          }else if (option == 2){
            option = 0;
            addAptChat("No, I don't think so....",color(155));
            addAptChat("Okay.",getByID(person1).getColor());
            this.eraseEvent();
          }else if (option == 3){
            option = 0;
            progress = 0;
          }
        }else if(progress == 2){
          addAptChat("Hello?",getByID(person2).getColor());
          progress = 3;
        }else if(progress == 3){
          addAptChat("Hey! I wanted to talk to you.",getByID(person1).getColor());
          progress = 4;
        }else if(progress == 4){
          addAptChat("Great! What did you want to talk about?",getByID(person2).getColor());
          progress = 5;
        }else if(progress == 5){
          addAptChat("[something something something]",getByID(person1).getColor());
          addAptChat("[something something something]",getByID(person2).getColor());
          progress = 6;
        }else if(progress == 6){
          addAptChat("[something something something]",getByID(person1).getColor());
          getByID(person1).setRelationship(random(0.1,0.2),person2,"f");
          getByID(person2).setRelationship(random(0.1,0.2),person1,"f");
          this.eraseEvent();
        }
      }
    }else if(type == 2){
      if(subtype == 0){
        if(progress == 0){
          addAptChat("Can you introduce me to " + getByID(person2).getName() + "?",getByID(person1).getColor());
          setChoices("Yes.","No.","Not now.");
          progress = 1;
        }
      }
    }else if(type == 3){
      if(subtype == 1){
        if(progress == 0){
          addAptChat("I have feelings for " + getByID(person2).getName() + ".",getByID(person1).getColor());
          addAptChat("Should I confess to " + getByID(person2).getName() + "?",getByID(person1).getColor());
          setChoices("Yes.","No.","Talk to me later.");
          progress = 1;
        }else if(progress == 1){
          if(option == 1){
            option = 0;
            addAptChat("I think so.",color(155));
            addAptChat("Okay...",getByID(person1).getColor());
            progress = 2;
          }else if (option == 2){
            option = 0;
            addAptChat("That's a bad idea.",color(155));
            addAptChat("...",getByID(person1).getColor());
            this.eraseEvent();
          }else if (option == 3){
            option = 0;
            progress = 0;
            scene = 0;
          }
        }else if(progress == 2){
          addAptChat("Where should I do it?",getByID(person1).getColor());
          setChoices("The roof.","The roof.","The roof.");
          progress = 3;
        }else if(progress == 3){
          if(option > 0){
            option = 0;
            addAptChat("Do it on the roof.",color(155));
            addAptChat("Okay...",getByID(person1).getColor());
            progress = 4;
            passedNum = scene % 200;
            scene = 20;
            clearAptChat();
          }else if (option == 2){
          }else if (option == 3){
          }
        }else if(progress == 4){
          progress = 5;
        }else if(progress == 5){
          addAptChat("Uh... hi? You wanted to see me?",getByID(person2).getColor());
          progress = 6;
        }else if(progress == 6){
          float rand = random(1);
          if(rand > .6666){
            addAptChat("I love you, " + getByID(person2).getName() + " will you go out with me?",getByID(person1).getColor());
          }else if(rand > .3333){
            addAptChat("You are the light of my life. I love you. Will you go out with me?",getByID(person1).getColor());
          }else{
            addAptChat("I like you, I think we should date. Will you go out with me?",getByID(person1).getColor());
          }
          progress = 7;
        }else if(progress == 7){
          float rand = random(1) + getByID(person2).getRomance(getByID(person1));
          if(rand > .5){
            addAptChat("Sure!",getByID(person2).getColor());
            getByID(person1).addRelationship(random(0.3,0.4),person2,"romantic");
            getByID(person2).addRelationship(random(0.3,0.4),person1,"romantic");
            getByID(person1).setStatus(3,person2);
            getByID(person2).setStatus(3,person1);
          }else{
            addAptChat("I'm sorry...",getByID(person2).getColor());
          }
          progress = 8;
        }else if(progress == 8){
          progress = 9;
        }else if(progress == 9){
          progress = 10;
          scene = 200 + passedNum;
          clearAptChat();
        }else if(progress == 10){
          if(getByID(person1).getPartner() != null){
            addAptChat("That went well!",getByID(person1).getColor());
          }else{
            addAptChat("That was a disaster...",getByID(person1).getColor());
          }
          this.eraseEvent();
        }
      }else if(subtype == 0){
        if(progress == 0){
          addAptChat("I'm... interested... in " + getByID(person2).getName() + ".",getByID(person1).getColor());
          addAptChat("What do you think about me and " + getByID(person2).getName() + "?",getByID(person1).getColor());
          setChoices("Great match.","Not sure.","Not compatible.");
          progress = 1;
        }else if(progress == 1){
          if(option == 1){
            option = 0;
            addAptChat("Seems like a good match.",color(155));
            getByID(person1).setRelationship(random(0.05,0.1),person2,"r");
            addAptChat("That's great to hear.",getByID(person1).getColor());
            this.eraseEvent();
          }else if (option == 2){
            option = 0;
            addAptChat("I'm not sure.",color(155));
            addAptChat("Uh, okay.",getByID(person1).getColor());
            this.eraseEvent();
          }else if (option == 3){
            option = 0;
            addAptChat("Probably a bad idea.",color(155));
            addAptChat("Okay...",getByID(person1).getColor());
            this.eraseEvent();
          }
        }
      }
    }
  }
  void eraseEvent(){
    type = -1;
    subtype = -1;
    progress = -1;
    person1 = -1;
    person2 = -1;
    person3 = -1;
    person4 = -1;
    person5 = -1;
  }
  void setProgress(int f){
    progress = f;
  }
}

Event getCurrentEvent(House h){
  for(int i = 0; i < EVENT_CAP; i++){
    if(events[i] != null && h != null && events[i].getEventIslander() != -1){
      if(getByID(events[i].getEventIslander()) == h.aptResident()){
        return events[i];
      }
    }
  }
  return null;
}

int nextAvailableEvent(){
  for(int i = 0; i < EVENT_CAP; i++){
    if(events[i] == null){
      return i;
    }
    if(events[i].getProgress() == -1){
      return i;
    }
  }
  return -1;
}

void createEvent(){
  for(int i = 0; i < 80; i++){
    if(getAptByID(i) != null){
      if(getAptByID(i).aptResident().getID() != -1 && getCurrentEvent(getAptByID(i)) == null && nextAvailableEvent() != -1 && random(1) > .5){
        float rand1 = random(1);
        float rand2 = random(1);
        if(rand1 > .6666){
          if(rand2 > .6666){
            events[nextAvailableEvent()] = new Event(0,0,getAptByID(i).aptResident().getID());
          }else if(rand2 > .3333){
            events[nextAvailableEvent()] = new Event(0,1,getAptByID(i).aptResident().getID());
          }else{
            events[nextAvailableEvent()] = new Event(0,2,getAptByID(i).aptResident().getID());
          }
        }else if(rand1 > .3333){
          if(getAptByID(i).aptResident().getNextAcquaintance() != null){
            events[nextAvailableEvent()] = new Event(1,0,getAptByID(i).aptResident().getID(),getAptByID(i).aptResident().getNextAcquaintance().getID());
          }
        }else{
          if(getAptByID(i).aptResident().getPartner() == null){
            if(rand2 > .5){
              Islander interest = getAptByID(i).aptResident().getPotentialPartner(); 
              if(interest != null){
                events[nextAvailableEvent()] = new Event(3,0,getAptByID(i).aptResident().getID(),interest.getID());
              }
            }else{
              Islander interest = getAptByID(i).aptResident().getGreatestRomance(); 
              if(interest != null){
                events[nextAvailableEvent()] = new Event(3,1,getAptByID(i).aptResident().getID(),interest.getID());
              }
            }
          }
        }
        return;
      }
    }
  }
}
