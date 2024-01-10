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
  Shape s = new Shape(new Point(0, 0, 0), 150);
  /*
  Face f = new Face(new Point(100, 200, 100), 50, new Point(0.0,0.0,(float)Math.PI/4));
  f.displayFace();
  */

  for(int i=0; i<s.getFaces().size(); i++){
      try{
        Point p = edgeCalc(getRealPosition(s.getFaces().get(i)), getRealPosition(s.getFaces().get(4)));
        p.displayPoint();
      } catch(RuntimeException re){
      }
  }
  
  new Point(0,0,0).displayPoint();

  s.displayShape(0,4);
  
  /*
  HashMap<Integer, Point> ps = s.getPoints();
  for(Point p : ps.values()){
    p.displayPoint();
  }*/
}

void draw(){
  background(0); // Black bg
  lightSpecular(1, 1, 1);
  directionalLight(0.8, 0.8, 0.8, 0, 0, -1);
  
  translate(width/2, 2*height/5);
  rotateX(-0.33);
  rotateY(mouseX/float(width) * PI * 2);
  //box(50);
  
  drawCube();
}
