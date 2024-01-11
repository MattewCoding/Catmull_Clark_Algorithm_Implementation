/**
 * Catmull Clark Algorithm
 * by Mattew Yang and Ryan Sebbouh
 * 
 * Implements the Catmull-Clark Algorithm.
 */
int shapeSize = 0;
int ccAmount=0, newCCAmount = 0, maxCCAmount = 4;
Shape cubeCC;
float brightness = 0.8;
int reducedWidth;

// Storing positions
ArrayList<Face> panelObjects;
float rx = 0.0, ry = 0.0, dz = 0.0;
boolean[] locked = {false, false, false, false};
int currBoxSel = 0;
int[] sliderValues = {0,0,0,0};
int sliderMin = 0, sliderMax = 100;
int sizeMin = 0, sizeMax = 600;
  
// Creation variables
int distBorder;
int barWid, sliderHei;
int centerOffset;
int spacing;
int fontSizeVal, fontSizeName;

void setup(){
  size(1280*2, 720*2, P3D);
  mouseY = height/2;
  
  noStroke();
  colorMode(RGB, 1);
  fill(0.4);
  drawCube();
  
  distBorder = height/15;
  barWid = limitValue(width/80, 20, 50);
  sliderHei = barWid;
  centerOffset = width/80;
  spacing = height/11 + barWid;
  fontSizeVal = limitValue(width/40, 37, 150);
  fontSizeName = int(fontSizeVal/2.5);
  
  reducedWidth = width - 4*spacing + barWid;
}

Shape catmullClark(Shape s){
  Shape cc = new Shape();
  
  for(Point p : s.getPoints().keySet()){
    cc = newPointCalc(s, p, s.getPoints().get(p), cc);
  }
  
  return cc;
}

void drawCube(){
  cubeCC = new Shape(new Point(0, 0, 0), 300, 0);
  for(int i = 0; i < ccAmount; i++){
    cubeCC = catmullClark(cubeCC);
  }
}

void fillMod(float x, float y, float z){
  fill(x*brightness, y*brightness, z*brightness);
}

int limitMap(int value, int minValue, int maxValue, int newMin, int newMax){
  if(value > minValue && value < maxValue) return int(map(value, minValue, maxValue, newMin, newMax));
  if(value < minValue) return newMin;
  return newMax;
}

int limitValue(int value, int minValue, int maxValue){
  if(value > minValue && value < maxValue) return value;
  if(value < minValue) return minValue;
  return maxValue;
}

void initLight(){
  lightSpecular(1, 1, 1);
  directionalLight(brightness, brightness, brightness, 0, 0, -1);
  fillMod(0.5, 0.5, 0.5);
}

void draw(){
  background(0); // Black bg
  initLight();
  
  shapeSize = int(map(sliderValues[0], sliderMin, sliderMax, sizeMin, sizeMax));
  rx = map(sliderValues[1], sliderMin, sliderMax, 2*PI, 0);
  ry = map(sliderValues[2], sliderMin, sliderMax, 0, 2*PI);
  
  // Avoid constantly calling this resource-intensive algorithm when possible
  newCCAmount = sliderValues[3];
  if(newCCAmount != ccAmount){
    ccAmount = newCCAmount;
    drawCube();
  }
  
  pushMatrix();
    translate(width/2, height/2, shapeSize);
    rotateX(rx);
    rotateY(ry);
    cubeCC.displayShape();
  popMatrix();
  
  drawSliders();
}
