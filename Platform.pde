class Platform {
  float x, y, z; 
  float widt, heigh;
  int type;
  Hitbox hitbox;
  int state;
  float activationTime; 
  float rechargeTime;   
  float dirx,dirz;
  Platform(float x, float y, float z, float widt, float heigh, int type) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.widt = widt;
    this.heigh = heigh;
    this.type = type;
    hitbox = new Hitbox(x - widt / 2, y-10, z - heigh / 2, x + widt / 2, y+10, z + heigh / 2);
    state=0;
    activationTime = 0;
    rechargeTime = 5000;
    dirx=0;
    dirz=0;
  }

  void drawSurface() {
    pushMatrix();
    noStroke();
    translate(x, y, z);
    switch (type) {
  case 1:
    fill(colors[1]);
    break;
  case 2:
    fill(colors[2]);
    break;
  case 3:
    fill(colors[3]);
    if (state == 1) {
      fill(255, 165, 0); 
    }
    if (state == 3) {
      fill(255, 255, 0); 
    }
    break;
  case 4:
    fill(colors[4]);
    if (state == 1) {
      fill(255, 165, 0);
    } if (state == 3) {
      fill(255, 255, 255); 
    }
    break;
  case 5:
    fill(colors[5]);
    if (state == 1) {
      fill(255, 165, 0);
    }
    break;
  case 6:
    fill(colors[6]);
    if (state == 1) {
      fill(255, 165, 0); 
    }
    if (state == 3) {
      fill(255, 255, 255); 
    }
    break;
  case 7:
    fill(colors[7]);
    break;
  case 8:
    fill(colors[8]);
    break;
  default:
    fill(150);
    break;
    }
    box(widt, 20, heigh);
    popMatrix();
  }
  void check_trap(){
  switch (type) {
  case 2:
  jump(players[0]);
  break;
  case 3:
  activate_dmg_trap(players[0]);
  break;
  case 4:
  activate_disappear_trap(players[0]);
  break;
  case 5:
    activate_wind_trap(players[0]);
  break;
  case 6:
   activate_amogus_trap(players[0]);
  break;
  case 7://start
   break;
  case 8://end
   win(players[0]);
   break;
   default:
   break;
   }
  }
  
  void win(Player player){
  if (player.isOnGround&&hitbox.intersects(player.hitbox))player.winn();
  }
  void jump(Player player){
  if (player.isOnGround&&hitbox.intersects(player.hitbox))player.UPmiltip(5);
  }
  void activate_dmg_trap(Player player){
  if (player.isOnGround&&hitbox.intersects(player.hitbox)){
     if (state == 0) {
      state = 1; 
      activationTime = millis(); 
    }

    if (state == 1 && millis() - activationTime > 500) {
      state = 2;
      player.takeDamage(10); 
    }
  }if (state == 1||state==2) {
    if(millis() - activationTime > 500){
      state = 3;
      activationTime = millis();
    }
  }
    if (state == 3 && millis() - activationTime > rechargeTime) {
      state = 0; 
    }
  }
  void activate_wind_trap(Player player){
    //print(player.cubeX,"\t",player.cubeZ,"\n");
    if (player.isOnGround&&hitbox.intersects(player.hitbox)){
  if (state == 0) {
      state = 1;  
      activationTime = millis();
      dirx=random(-1,1);
      dirz=random(-1,1);
    }
    if (state == 1 && millis() - activationTime > 500) {
      player.movev(dirx,0,dirz,1);  
      }
    }
    if (state == 1 && millis() - activationTime > rechargeTime/2.5) {
      state = 0; 
     
  }
}
 
  void activate_disappear_trap(Player player){
    if (player.isOnGround&&hitbox.intersects(player.hitbox)){
     if (state == 0) {
      state = 1;
      activationTime = millis(); 
    }
  }if (state == 1 && millis() - activationTime > 1000) {
      state = 3;
      activationTime = millis();
    }
    if (state == 3 && millis() - activationTime > rechargeTime*2) {
      state = 0;
    }
}
void activate_amogus_trap(Player player){
   if (player.isOnGround&&hitbox.intersects(player.hitbox)){
  if (state == 0) {
      state = 1;
      activationTime = millis();
    }
    if (state == 1 && millis() - activationTime > 4000) {
      
      
    }
    }
    if (state == 3 && millis() - activationTime > rechargeTime) {
      state = 0; 
  }
}
  boolean isPlayerOnGround(Player player) {
    if (state==3&&type==4){
      return false;
    }else{
    return hitbox.intersects(player.hitbox);
  }
  }
}
