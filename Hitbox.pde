class Hitbox {
  float minX, minY, minZ;
  float maxX, maxY, maxZ;

  Hitbox(float minX, float minY, float minZ, float maxX, float maxY, float maxZ) {
    this.minX = minX;
    this.minY = minY;
    this.minZ = minZ;
    this.maxX = maxX;
    this.maxY = maxY;
    this.maxZ = maxZ;
  }

  // Проверка на пересечение хитбоксов
  boolean intersects(Hitbox other) {
    return (minX <= other.maxX && maxX >= other.minX) &&
           (minY <= other.maxY && maxY >= other.minY) &&
           (minZ <= other.maxZ && maxZ >= other.minZ);
           
  }

  // Отрисовка хитбокса
  void drawHitbox() {
    pushMatrix();
    noFill();
    stroke(0, 255, 0);
    beginShape();
    vertex(minX, minY, minZ);
    vertex(maxX, minY, minZ);
    vertex(maxX, maxY, minZ);
    vertex(minX, maxY, minZ);
    vertex(minX, maxY, maxZ);
    vertex(maxX, maxY, maxZ);
    vertex(maxX, minY, maxZ);
    vertex(minX, minY, maxZ);
    //noStroke();
    endShape(CLOSE);
    popMatrix();
  }
}
