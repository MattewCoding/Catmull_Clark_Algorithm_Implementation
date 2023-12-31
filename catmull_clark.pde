/**
 * Catmull Clark Algorithm
 * by Mattew Yang and Ryan Sebbouh
 * 
 * Implements the Catmull-Clark Algorithm.
 */
 
void setup(){
  size(1280, 720, P3D);
  
  noStroke();
  colorMode(RGB, 1);
  fill(0.4);
}

void drawCube(){
  Face f = new Face();
  f.addPoint(50, 50, 0);
  f.addPoint(50, 150, 0);
  f.addPoint(150, 150, 0);
  f.addPoint(150, 50, 0);
  f.displayFace();
}

void draw(){
  background(0); // Black bg
  lightSpecular(1, 1, 1);
  directionalLight(0.8, 0.8, 0.8, 0, 0, -1);
  
  translate(width/2, 2*height/5);
  //rotateX(-0.33);
  rotateY(mouseX/float(width) * PI);
  box(75);
  
  drawCube();
}
