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
  Shape s = new Shape(new Point(50, 50, 0), 50);
  s.displayShape();
  
  Face f = new Face(new Point(100, 200, 100), 50, new Point(0.0,0.0,(float)Math.PI/4));
  f.displayFace();
  
  Face fReal = getRealPosition(f);
  ArrayList<Point> ps = fReal.getPoints();
  for(Point p:ps){
    p.displayPoint();
    print("\n");
  }
}

void draw(){
  background(0); // Black bg
  lightSpecular(1, 1, 1);
  directionalLight(0.8, 0.8, 0.8, 0, 0, -1);
  
  translate(width/2, 2*height/5);
  //rotateX(-0.33);
  rotateY(mouseX/float(width) * PI * 2);
  //box(50);
  
  drawCube();
}
