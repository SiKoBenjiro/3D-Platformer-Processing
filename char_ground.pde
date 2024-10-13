import java.awt.Robot;
import java.awt.AWTException;
import java.awt.MouseInfo;
import java.awt.Point;
int rows = 30;
int cols = 32;
int cellSize = 200;
Player[] players;  
Robot robot; 
Platform[] platforms;
int [][] platformss;
color[] colors = {
  color(255),
  color(150),        // серый
  color(0),
  color(255, 0, 0),  // красный
  color(0, 255, 0),  // зеленый
  color(0, 0, 255),  // синий
  color(255, 255, 0), // желтый
  color(255, 165, 0),  // оранжевый
  color(128, 0, 128),  // пурпурный
};
int numPaths;
float[] yOffsets; 
float targetY; 
float max_range;
int[][] intersectionMatrix; 
int[][] colorM;
color[][] colorMatrix;
int cellSiz = 30; 
PImage img;
int gamestate=1;
void setup() {
size(1600,1000, P3D);


  platformss = new int[rows][cols];
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      platformss[i][j] = 1; 
    }
  }
  platformss[4][5]=3;
  platformss[14][15]=4;
  platformss[10][10]=5;
  platformss[1][5]=6;
  platformss[4][0]=7;
  platformss[6][0]=7;
  platformss[7][10]=8;
  platformss[1][1]=2;
  setup2();
 
}
void setup2(){
  generate();
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      platformss[i][j]= colorM[i][j];
    }
  }
   ArrayList<Platform> platformList = new ArrayList<Platform>();
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      if (platformss[i][j] != 0) {
        float x = j * cellSize;
        float z = i * cellSize;
        Platform gg = new Platform(x, 0, z, cellSize-100, cellSize-100, platformss[i][j]);
        platformList.add(gg); 
      }
    }
  }
  int[] massiv={};

  platforms = platformList.toArray(new Platform[platformList.size()]);
  for (int i=0;i<rows;i++){
    if(platformss[i][0]==7){
  massiv=append(massiv,i);
}
  }
  int l=int(round(random(0,massiv.length-1)));
  int Cubex = 0;
  int Cubey = -50;
  int Cubez = massiv[l]*cellSize;

  players = new Player[1];
  players[0] = new Player(Cubex, Cubey, Cubez);
  try {
    robot = new Robot();  
  } catch (AWTException e) {
    e.printStackTrace();
  }
}

void draw() {
  background(200);
  lights();
  if(gamestate==1){
  draw_matrix();
  if(keyPressed){
    if(key=='f'||key=='F'){gamestate=2;}
    setup2();
  }
}
if(gamestate==2){
  players[0].moveCam(); 
  players[0].movePlayer();
  players[0].handleCamera(); 
    for (int i = 0; i < platforms.length; i++) {
      platforms[i].check_trap();
      platforms[i].drawSurface();   
  }
  //drawGrid();
  players[0].drawCube();
}
}

void drawGrid() {
  stroke(150);
  for (int i = -1000; i <= 1000; i += 50) {
    line(i, 0, -1000, i, 0, 1000);
    line(-1000, 0, i, 1000, 0, i);  
  }
}
void keyPressed() {
  players[0].keyPressed(key);
}
void keyReleased() {
  players[0].keyReleased(key);
}
