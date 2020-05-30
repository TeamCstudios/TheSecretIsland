Islander[] islanders = new Islander[ISLANDER_CAP];

public class Islander{
  private String nameFirst;private String nameLast;private int idnum;private int age;private int bdayMonth;private int bdayDay;private float kScale;private int gender;
  private float[] relFriend = new float[ISLANDER_CAP]; private float[] relRomance = new float[ISLANDER_CAP]; private int[] relOther = new int[ISLANDER_CAP];
  private color textColor; private String catchphrase;
  public Islander(){
    idnum = -1;
  }
  //Load Islander from file.
  public Islander(int id, String firstName, String lastName, int startAge, int birthDay, int birthMonth, float sexuality, int gen, int r, int g, int b, String cphrase, float[] friend, float[] romance, int[] other){
    idnum = id;
    nameFirst = firstName;
    nameLast = lastName;
    age = startAge;
    kScale = sexuality;
    gender = gen;
    bdayMonth = birthDay;
    bdayDay = birthMonth;
    catchphrase = cphrase;
    for(int i = 0; i < ISLANDER_CAP; i++){
      relFriend[i] = friend[i];
      relRomance[i] = romance[i];
      relOther[i] = other[i];
    }
    textColor = color(r,g,b);
  }
  //Create an Islander without parents defined.
  public Islander(int id, String firstName, String lastName, int startAge, int birthDay, int birthMonth, float sexuality, int gen, int r, int g, int b){
    idnum = id;
    nameFirst = firstName;
    nameLast = lastName;
    age = startAge;
    kScale = sexuality;
    gender = gen;
    bdayMonth = birthDay;
    bdayDay = birthMonth;
    catchphrase = "";
    for(int i = 0; i < ISLANDER_CAP; i++){
      relFriend[i] = 0.0;
      relRomance[i] = 0.0;
      relOther[i] = 0;
    }
    relFriend[idnum] = -1.0;
    relRomance[idnum] = -1.0;
    relOther[idnum] = -1;
    textColor = color(r,g,b);
  }
  //Create an Islander with parents defined.
  public Islander(int id, String firstName, String lastName, int startAge, int birthDay, int birthMonth, float sexuality, int gen, int parent1ID, int parent2ID){
    idnum = id;
    nameFirst = firstName;
    nameLast = lastName;
    age = startAge;
    kScale = sexuality;
    gender = gen;
    bdayMonth = birthDay;
    bdayDay = birthMonth;
    catchphrase = "";
    for(int i = 0; i < ISLANDER_CAP; i++){
      relFriend[i] = 0.0;
      relRomance[i] = 0.0;
      relOther[i] = 0;
    }
    relFriend[idnum] = -1.0;
    relRomance[idnum] = -1.0;
    relOther[idnum] = -1;
    relOther[parent1ID] = 1;
    relOther[parent2ID] = 1;
    float r = ((red(getByID(parent1ID).getColor()) + red(getByID(parent2ID).getColor())) / 2) * random(.8,1.2);
    float g = ((green(getByID(parent1ID).getColor()) + green(getByID(parent2ID).getColor())) / 2) * random(.8,1.2);
    float b = ((blue(getByID(parent1ID).getColor()) + blue(getByID(parent2ID).getColor())) / 2) * random(.8,1.2);
    textColor = color(r,g,b);
  }
  //Get islander name
  String getName(){
    return nameFirst + " " + nameLast;
  }
  String getFirstName(){
    return nameFirst;
  }
  String getLastName(){
    return nameLast;
  }
  String getCatchphrase(){
    return catchphrase;
  }
  //Get islander text color
  color getColor(){
    return textColor;
  }
  //Get islander text color
  int getAge(){
    return age;
  }
  int getBdayDay(){
    return bdayDay;
  }
  int getBdayMonth(){
    return bdayMonth;
  }
  //Get islander gender
  int getGender(){
    return gender;
  }
  //Get islander gender
  float getSexuality(){
    return kScale;
  }
  //Get id from an Islander object
  int getID(){
    return idnum;
  }
  //Get relationship value between islanders.
  int getOther(Islander i){
    if(i.getID() == -1){
      return -1;
    }
    return relOther[i.getID()];
  }
  //Get friendship value between islanders.
  float getFriendship(Islander i){
    if(i.getID() == -1){
      return -1;
    }
    return relFriend[i.getID()];
  }
  //Get romance value between islanders.
  float getRomance(Islander i){
    if(i.getID() == -1){
      return -1;
    }
    return relRomance[i.getID()];
  }
  //Get islander's amount of friends.
  int getFriends(){
    int f = 0;
    for(int i = 0; i < ISLANDER_CAP; i++){
      if(relFriend[i] > 0.1){
        f++;
      }
    }
    return f;
  }
  //Get islander's significant other.
  Islander getPartner(){
    for(int i = 0; i < ISLANDER_CAP; i++){
      if(relOther[i] == 3 || relOther[i] == 4){
        return getByID(i);
      }
    }
    return null;
  }
  Islander getNextAcquaintance(){
    for(int i = 0; i < ISLANDER_CAP; i++){
      if(relFriend[i] == 0.0){
        return getByID(i);
      }
    }
    return null;
  }
  Islander getPotentialPartner(){
    int[] partners = new int[0];
    for(int i = 0; i < ISLANDER_CAP; i++){
      if(getByID(i) != null){
        if(relRomance[i] <= 0.11 && relRomance[i] != -1.0 && canRomance(getByID(idnum),getByID(i))){
          if(getByID(i).getGender() == 0 && gender == 0){
            if(getByID(i).getSexuality() > .4 + random(-0.1,0.1) && kScale > .4 + random(-0.1,0.1)){
              partners = append(partners,i);
            }
          }else if(getByID(i).getGender() == 1 && gender == 1){
            if(getByID(i).getSexuality() > .4 + random(-0.1,0.1) && kScale > .4 + random(-0.1,0.1)){
              partners = append(partners,i);
            }
          }else if((getByID(i).getGender() == 3 || getByID(i).getGender() == 2) || (gender == 3 || gender == 2)){
            partners = append(partners,i);
          }else{
            if(getByID(i).getSexuality() < .6 + random(-0.1,0.1) && kScale < .6 + random(-0.1,0.1)){
              partners = append(partners,i);
            }
          }
        }
      }
    }
    if(partners.length == 0){
      return null;
    }else{
      System.out.println(partners);
      return getByID(partners[int(random(0,partners.length))]);
    }
  }
  Islander getGreatestRomance(){
    float romance = 0.0;
    int id = -1;
    for(int i = 0; i < ISLANDER_CAP; i++){
      if(getByID(i) != null){
        if(relRomance[i] > romance){
          romance = relRomance[i];
          id = i;
        }
      }
    }
    if(id != -1){
      return getByID(id);
    }
    return null;
  }
  //Get islander parents in format "##,##"
  String getParents(){
    int[] parents = {-1,-1};
    for(int i = 0; i < ISLANDER_CAP; i++){
      if(relOther[i] == 1){
       if(parents[0] == -1){
         parents[0] = i;
       }else{
         parents[1] = i;
       }
      }
    }
    return parents[0] + "," + parents[1];
  }
  //Delete this islander
  void delete(){
    idnum = -1;
  }
  //Get islander grandparents in format "##,##,##,##"
  String getGrandparents(){
    int[] parents = int(this.getParents().split(","));
    return getByID(parents[0]).getParents() + "," + getByID(parents[1]).getParents();
  }
  //Get islander great-grandparents in format "##,##,##,##,##,##,##,##"
  String getGreatGrandparents(){
    int[] parents = int(this.getParents().split(","));
    return getByID(parents[0]).getGrandparents() + "," + getByID(parents[1]).getGrandparents();
  }
  void setRelationship(float set, int idOther, String type){
    if(type == "r" || type == "romantic" || type == "Romantic"){
      relRomance[idOther] = set;
    }else if(type == "f" || type == "friendship" || type == "Friendship"){
      relFriend[idOther] = set;
    }
  }
  void addRelationship(float set, int idOther, String type){
    if(type == "r" || type == "romantic" || type == "Romantic"){
      relRomance[idOther] += set;
    }else if(type == "f" || type == "friendship" || type == "Friendship"){
      relFriend[idOther] += set;
    }
  }
  void setStatus(int set, int idOther){
    relOther[idOther] = set;
  }
  void setCatchphrase(String phrase){
    catchphrase = phrase;
  }
}


//Get the Islander object by islander ID
Islander getByID(int id){
  return islanders[id];
}

//Get the next available slot for an islander. If none are, throw -1.
int nextAvailableIslander(){
  for(int i = 0; i < ISLANDER_CAP; i++){
    if(getByID(i) == null){
      return i;
    }
    if(getByID(i).getID() != i){
      return i;
    }
  }
  return -1;
}

//Check if two islanders can engage in romance.
boolean canRomance(Islander a, Islander b){
  //Check if age allows
  if(a.getAge() < 17 || b.getAge() < 17){
    if(!(a.getAge() < 18 && b.getAge() < 18 && a.getAge() > 12 && b.getAge() > 12)){
      return false;
    }
  }
  System.out.println(a.getParents() + " " + b.getParents());
  String[] apx = a.getParents().split(",");
  String[] bpx = b.getParents().split(",");
  int[] ap = {int(apx[0]),int(apx[1])};
  int[] bp = {int(bpx[0]),int(bpx[1])};
  System.out.println(ap + " " + bp);
  if((ap[0] == -1 || ap[1] == -1) || (bp[0] == -1 && bp[1] == -1)){
    return true;
  }
  //Check if full siblings
  if(a.getParents().equals(b.getParents())){
    return false;
  }
  //Check if parent and child
  if(ap[0] == b.getID() || ap[1] == b.getID() || bp[0] == a.getID() || bp[1] == a.getID()){
    return false;
  }
  //Check if half siblings
  if(((ap[0] == bp[0] || ap[0] == bp[1]) && ap[0] != -1) || ((ap[1] == bp[0] || ap[1] == bp[1]) && ap[1] != -1)){
    return false;
  }
  String[] agpx = a.getGrandparents().split(",");
  String[] bgpx = b.getGrandparents().split(",");
  int[] agp = {int(agpx[0]),int(agpx[1])};
  int[] bgp = {int(bgpx[0]),int(bgpx[1])};
  //Check if grandchild
  if(agp[0] == b.getID() || agp[1] == b.getID() || agp[2] == b.getID() || agp[3] == b.getID() || bgp[0] == a.getID() || bgp[1] == a.getID() || bgp[2] == a.getID() || bgp[3] == a.getID()){
    return false;
  }
  for(int i = 0; i < 4; i++){
    for(int j = 0; j < 4; j++){
      //Check if first cousins
      if(agp[i] != -1 && bgp[j] != -1 && agp[i] == bgp[j]){
        return false;
      }
      //Check if nibling
      if(agp[i] != -1 && bp[0] != -1 && agp[i] == bp[0]){
        return false;
      }else if(agp[i] != -1 && bp[1] != -1 && agp[i] == bp[1]){
        return false;
      }else if(ap[0] != -1 && bgp[j] != -1 && ap[0] == bgp[j]){
        return false;
      }else if(ap[1] != -1 && bgp[j] != -1 && ap[1] == bgp[j]){
        return false;
      }
    }
  }
  String[] aggpx = a.getGreatGrandparents().split(",");
  String[] bggpx = b.getGreatGrandparents().split(",");
  int[] aggp = {int(aggpx[0]),int(aggpx[1])};
  int[] bggp = {int(bggpx[0]),int(bggpx[1])};
  //Check if great-grandchild
  if(aggp[0] == b.getID() || aggp[1] == b.getID() || aggp[2] == b.getID() || aggp[3] == b.getID() || aggp[4] == b.getID() || aggp[5] == b.getID() || aggp[6] == b.getID() || aggp[7] == b.getID() || bggp[0] == a.getID() || bggp[1] == a.getID() || bggp[2] == a.getID() || bggp[3] == a.getID() || bggp[4] == a.getID() || bggp[5] == a.getID() || bggp[6] == a.getID() || bggp[7] == a.getID()){
    return false;
  }
  for(int i = 0; i < 8; i++){
    for(int j = 0; j < 8; j++){
      //Check if second cousins
      if(aggp[i] != -1 && bggp[j] != -1 && aggp[i] == bggp[j]){
        return false;
      }
      for(int z = 0; z < 4; z++){
        //Check if first cousins, once removed
        if(aggp[i] != -1 && bgp[z] != -1 && aggp[i] == bgp[z]){
          return false;
        }
        if(agp[z] != -1 && bggp[j] != -1 && agp[z] == bggp[j]){
          return false;
        }
        //Check if grand-nibling
        if(aggp[i] != -1 && bgp[z] != -1 && agp[i] == bgp[z]){
          return false;
        }else if(agp[z] != -1 && bggp[j] != -1 && agp[z] == bggp[j]){
          return false;
        }  
      }
    }
  }
  //All of these conditions are not fulfilled and therefore romance is possible
  return true;
}
