void generate(){
  targetY = 600 / 2;
  max_range = 1000;

  intersectionMatrix = new int[cellSiz][cellSiz+2]; 
  colorMatrix = new color[cellSiz][cellSiz+2];
  colorM = new color[cellSiz][cellSiz+2];
  generatePaths();
  updateCMatrix(); 
  updateColorMatrix();
  }
  void draw_matrix(){
  image(generateImage(), height, width);
  }
PImage generateImage() {
  PImage newImg = createImage(1000, 600, RGB);
  displayMatrix();
  return newImg;
}
void generatePaths() {
  numPaths = 3; 
  
  yOffsets = new float[numPaths];
  for (int i = 0; i < numPaths; i++) {
    yOffsets[i] = random(100);
  }
  
  // Очищаем матрицу пересечений
  for (int i = 0; i < intersectionMatrix.length; i++) {
    for (int j = 0; j < intersectionMatrix[i].length; j++) {
      intersectionMatrix[i][j] = 0; 
    }
  }

  for (int i = 0; i < numPaths; i++) {
    float xoff = 0; 
    for (int x = 0; x < max_range; x += 30) {
      // Начальное значение Y на основе шума Перлина
      float y = map(noise(xoff, yOffsets[i]), 0, 1, 0, 600);
      float t = map(x, 0, max_range, 0, 1); 
      if (x >= max_range / 2) {
        y = lerp(y, targetY, t); 
      }
      

      int cellX = constrain(int(x / (max_range / cellSiz)), 0, cellSiz - 1);
      int cellY = constrain(int(y / (600 / cellSiz)), 0, cellSiz - 1);
      

      intersectionMatrix[cellY][cellX+1]++;
      
      xoff += 0.05;
    }
  }
}

void updateCMatrix() {

  for (int i = 0; i < intersectionMatrix.length; i++) {
    for (int j = 1; j < intersectionMatrix[i].length; j++) {
      int count = intersectionMatrix[i][j];

      if (count > 1) {
        colorM[i][j] =1; 
      } else if (count == 1) {

        if (random(100) < 65) {
          colorM[i][j] = 1;
        }
        else {
          colorM[i][j] = int(random(3, 7)); 
        }
        
          if (countNonZeroNeighbors(i,j,intersectionMatrix)==0){
        colorM[i][j] = 2;
      }        
      }
      
      else {
        colorM[i][j] = 0; 
      }
    }
  }
  int start=0;
  int end=0;
  for (int i = 0; i < intersectionMatrix.length; i++){
  
    if (countNonZeroNeighbors_left(i,31,colorM)>0){
        if(start==0){
        start=i+1;
        }else{
        end=i;
        }
        
      }
    colorM[i][0] = 0;
  }
  
  for (int i = start; i < end; i++){
    
       colorM[i][31] = 8;
     
  }
  start=0;
  end=0;
  for (int i = 0; i < intersectionMatrix.length; i++){
  
    if (countNonZeroNeighbors(i,0,colorM)>0){
        if(start==0){
        start=i;
        }else{
        end=i;
        }
        
      }
    colorM[i][0] = 0;
  }
  
  for (int i = start; i < end; i++){
    
       colorM[i][0] = 7;
     
  }
  start=0;
  end=0;
}
int countNonZeroNeighbors(int x, int y, int[][] matrix) {
  int count = 0;  
  int rows = matrix.length;
  int cols = matrix[0].length;


  for (int i = -1; i <= 1; i++) {
    for (int j = 0; j <= 1; j++) {

      if (i == 0 && j == 0) continue;
      

      int newX = x + i;
      int newY = y + j;
      if (newX >= 0 && newX < rows && newY >= 0 && newY < cols) {

        if (matrix[newX][newY] != 0) {
          count++; 
        }
      }
    }
  }

  return count;  // возвращаем количество ненулевых соседей
}
int countNonZeroNeighbors_left(int x, int y, int[][] matrix) {
  int count = 0;  
  int rows = matrix.length;
  int cols = matrix[0].length;


  for (int i = -1; i <= 1; i++) {
    for (int j = -1; j <= 0; j++) {

      if (i == 0 && j == 0) continue;
      

      int newX = x + i;
      int newY = y + j;
      if (newX >= 0 && newX < rows && newY >= 0 && newY < cols) {

        if (matrix[newX][newY] != 0) {
          count++; 
        }
      }
    }
  }

  return count; 
}
void updateColorMatrix() {

  for (int i = 0; i < colorM.length; i++) {
    for (int j = 0; j < colorM[i].length; j++) {
      colorMatrix[i][j]=colors[colorM[i][j]];
      //print(colorMatrix[i][j],"  ");
    }
    //print("\n");
  }
  
}


void displayMatrix() {

  for (int i = 0; i < colorMatrix.length; i++) {
    for (int j = 0; j < colorMatrix[i].length; j++) {
      fill(colorMatrix[i][j]); 
      rect(j * (max_range / cellSiz), i * (600 / cellSiz), max_range / cellSiz, 600 / cellSiz); 
      //print((max_range / cellSiz),"\t",(600 / cellSiz),"\n" );
    }
    //print("\n");
  }
}
