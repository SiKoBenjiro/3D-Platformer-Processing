class Player {
  float cubeX = 0;
  float cubeY = 0;
  float cubeZ = 0;
  float camX, camY, camZ;
  float camYaw = 0;
  float camPitch = 0;
  Hitbox hitbox;
  boolean wPressed, sPressed, aPressed, dPressed;
  boolean SPACEpressed = false;
  boolean SHIFTpressed = false;
  boolean freeCamMode = true;
  boolean cameraFollowMode = false;
  boolean isOnGround = true;
  int health=20;
  float accForward = 0, accBackward = 0;
  float accLeft = 0, accRight = 0;
  float accUP = 0, accDOWN = 0;
  boolean ground=false;
  float deceleration = 2.5;
  float multiplier = 100;
  boolean press=false;
  float UPmultiplier;
  boolean won;
  Player(int Cubex,int Cubey,int Cubez) {
    cubeX = Cubex;
    cubeY = Cubey;
    cubeZ = Cubez;
    camX = cubeX;
    camY = cubeY - 150;
    camZ = cubeZ + 200;
    updateHitbox();
    UPmultiplier=1;
    won=false;
  }
   void updateHitbox() {
    float size = 25; 
    hitbox = new Hitbox(cubeX - size/1.5, cubeY - size, cubeZ - size/1.5, cubeX + size/1.5, cubeY + size, cubeZ + size/1.5);
    
  }
  void winn(){
    won=true;
  }
  void movePlayer() {
    if (this.health<=0||this.won){
    cameraFollowMode=false;
  }
    //ground=platforms[0].isPlayerOnGround(this);
     for (int i = 0; i < platforms.length; i++) {    
      ground=platforms[i].isPlayerOnGround(this);
      if(ground==true) break;
  }
    if( cameraFollowMode == true){
    accForward = constrain(accForward, 0, 2000);
    accBackward = constrain(accBackward, 0, 2000);
    accLeft = constrain(accLeft, 0, 400);
    accRight = constrain(accRight, 0, 400);
    accUP = constrain(accUP, 0, 600);
    accDOWN = constrain(accDOWN, 0, 600);
    
    if (wPressed) accForward += 30;
    if (sPressed) accBackward += 30;
    if (aPressed) accLeft += 15;
    if (dPressed) accRight += 15;

    if (!wPressed && accForward > 0) accForward -= deceleration * 24;
    if (!sPressed && accBackward > 0) accBackward -= deceleration*12;
    if (!aPressed && accLeft > 0) accLeft -= deceleration * 6;
    if (!dPressed && accRight > 0) accRight -= deceleration * 6;
    if (!SPACEpressed) press=false;
    if (SPACEpressed && isOnGround&&press==false){
    accUP += 30*UPmultiplier;
    press=true;
    UPmultiplier=1;
    }
    if (!isOnGround) {
      accDOWN += 1;
      accUP -= 1;
    }

    if (ground==true) {
      accDOWN = 0;
      isOnGround = true;
    }

    if (ground==false) {
      isOnGround = false;
    }
    
    float forwardX = cos(radians(camYaw)) * cos(radians(camPitch));
    float forwardZ = sin(radians(camYaw)) * cos(radians(camPitch));
    float rightX = cos(radians(camYaw + 90));
    float rightZ = sin(radians(camYaw + 90));

    float dt = 0.005;
    float movX = (accForward * forwardX - accBackward * forwardX + accRight * rightX - accLeft * rightX) * dt * dt;
    float movZ = (accForward * forwardZ - accBackward * forwardZ + accRight * rightZ - accLeft * rightZ) * dt * dt;
    float movY = accUP * dt * dt - accDOWN * dt * dt;

    cubeX += movX * multiplier;
    cubeZ += movZ * multiplier;
    for (int i=0;i<1000;i=i+1){
       cubeY -= movY * multiplier*0.1;
       updateHitbox();
       
       for (int j = 0; j < platforms.length; j++) {    
      ground=platforms[j].isPlayerOnGround(this);
      if(ground==true) break;
    }
    if(ground==true) break;
    if(cubeY>=1000){takeDamage(10);}
  }
    //cubeY -= movY * multiplier * multiplier;
  }else updateHitbox();
}
void UPmiltip(float amount){
  UPmultiplier=amount;
}
void movev(float x, float y, float z,float strength){
    float dt = 1;
    float movX =x * dt;
    float movZ = z * dt;
    cubeX += movX*strength;
    cubeZ += movZ*strength;
    print(movX*strength,"\t",movZ*strength,"\n");

}

  void moveCam() {
     if( cameraFollowMode == false){
    accForward = constrain(accForward, 0, 1500);
    accBackward = constrain(accBackward, 0, 1500);
    accLeft = constrain(accLeft, 0,1500);
    accRight = constrain(accRight, 0, 1500);
    accUP = constrain(accUP, 0, 1500);
    accDOWN = constrain(accDOWN, 0, 1500);

    if (wPressed) accForward += 50;
    if (sPressed) accBackward += 50;
    if (aPressed) accLeft += 50;
    if (dPressed) accRight += 50;

    if (!wPressed && accForward > 0) accForward = 0;
    if (!sPressed && accBackward > 0) accBackward = 0;
    if (!aPressed && accLeft > 0) accLeft =0;
    if (!dPressed && accRight > 0) accRight =0;

    if (SPACEpressed) accUP += 50;
    if (SHIFTpressed) accDOWN += 50;
    if (!SPACEpressed&& accUP > 0) accUP =0;
    if (!SHIFTpressed && accDOWN > 0) accDOWN =0;
    
    float forwardX = cos(radians(camYaw)) * cos(radians(camPitch));
    float forwardZ = sin(radians(camYaw)) * cos(radians(camPitch));
    float rightX = cos(radians(camYaw + 90));
    float rightZ = sin(radians(camYaw + 90));

    float dt = 0.005;
    float movX = (accForward * forwardX - accBackward * forwardX + accRight * rightX - accLeft * rightX) * dt * dt;
    float movZ = (accForward * forwardZ - accBackward * forwardZ + accRight * rightZ - accLeft * rightZ) * dt * dt;
    float movY = accUP * dt * dt - accDOWN * dt * dt;

    camX += movX * multiplier;
    camZ += movZ * multiplier;
    camY -= movY * multiplier;
  }}

  void handleCamera() {
    if (freeCamMode) {
      cameraRotation();
    } else if (cameraFollowMode) {
      followObject();
      cameraRotation();
    }

    float dirX = cos(radians(camYaw)) * cos(radians(camPitch));
    float dirY = sin(radians(camPitch));
    float dirZ = sin(radians(camYaw)) * cos(radians(camPitch));
    
    camera(camX, camY, camZ, camX + dirX, camY + dirY, camZ + dirZ, 0, 1, 0);
  }

  void followObject() {
    float followDistance = 200;
    camX = cubeX - cos(radians(camYaw)) * followDistance;
    camY = cubeY - sin(radians(camPitch)) * followDistance -20;
    camZ = cubeZ - sin(radians(camYaw)) * followDistance;
  }
  void takeDamage(int amount){
  health-=amount;
  }
  void cameraRotation() {
    float sensitivity = 0.1;
    
      Point mousePos = MouseInfo.getPointerInfo().getLocation();
      int centerX = width / 2;
      int centerY = height / 2;

      camYaw += (mousePos.x - centerX) * sensitivity;
      camPitch += (mousePos.y - centerY) * sensitivity;

      robot.mouseMove(centerX, centerY);
      noCursor();
    
    camPitch = constrain(camPitch, -89, 89);
  }

  void drawCube() {
    pushMatrix();
    translate(cubeX, cubeY, cubeZ);
    fill(150);
    stroke(150);

    box(25,50,25);
    popMatrix();
    hitbox.drawHitbox();
  }

  void keyPressed(char key) {
    if (key == 'w' || key == 'W') wPressed = true;
    if (key == 's' || key == 'S') sPressed = true;
    if (key == 'a' || key == 'A') aPressed = true;
    if (key == 'd' || key == 'D') dPressed = true;
    if (key == ' ') SPACEpressed = true;
    if (keyCode == SHIFT) SHIFTpressed = true;
    if (key == 'f' || key == 'F') {
      freeCamMode = !freeCamMode;
      cameraFollowMode = !cameraFollowMode;
    }
  }

  void keyReleased(char key) {
    if (key == 'w' || key == 'W') wPressed = false;
    if (key == 's' || key == 'S') sPressed = false;
    if (key == 'a' || key == 'A') aPressed = false;
    if (key == 'd' || key == 'D') dPressed = false;
    if (key == ' ') SPACEpressed = false;
    if (keyCode == SHIFT) SHIFTpressed = false;
  }
}
