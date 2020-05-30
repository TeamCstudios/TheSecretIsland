House[] apartments = new House[80];
House[] houses = new House[30];

public class House{
  private int index;private int type;private int resident1;private int resident2 = -1;private int resident3 = -1;private int resident4 = -1;
  public House(int aptNum,Islander r){
    type = 1;
    index = aptNum;
    resident1 = r.getID();
  }
  public House(){
    type = 1;
    index = -1;
  }
  public House(int houseNum,Islander r1,Islander r2){
    type = 2;
    index = houseNum;
    resident1 = r1.getID();
    resident2 = r2.getID();
  }
  void addResident(Islander r){
    if(resident3 == -1){
      resident3 = r.getID();
    }else{
      resident4 = r.getID();
    }
  }
  Islander aptResident(){
    return getByID(resident1);
  }
  void delete(){
    index = -1;
    type = 0;
    resident1 = -1;
    resident2 = -1;
    resident3 = -1;
  }
  boolean isOccupied(){
    if(type == 0 || index == -1 || resident1 == -1){
      return false;
    }
    return true;
  }
  int getType(){
    return type;
  }
  int getIndex(){
    return index;
  }
}

House getAptByID(int id){
  return apartments[id];
}

int nextAvailableApt(){
  for(int i = 0; i < apartments.length; i++){
    if(apartments[i] == null){
      return i;
    }
    if(!apartments[i].isOccupied()){
      return i;
    }
  }
  return -1;
}

int nextAvailableHouse(){
  for(int i = 0; i < houses.length; i++){
    if(houses[i] == null){
      return i;
    }
    if(!houses[i].isOccupied()){
      return i;
    }
  }
  return -1;
}
