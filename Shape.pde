/**
 * La classe qui gère les formes
 * @author YANG Mattew
 */

class Shape{
  ArrayList<Face> faces = new ArrayList<Face>();
  
  Shape(){}
  
  Shape(Face firstFace){
    addFace(firstFace);
  }
  
  Shape(int x, int y, int z){
    addFace(x,y,z);
  }
  
  Shape(Point centre, float taille){
    float trueTaille = taille/2;
    float x = centre.x;
    float y = centre.y;
    float z = centre.z;
    
    faces.add(new Face(new Point(x+trueTaille,y,z), taille, new Point(0, PI/2, 0)));
    faces.add(new Face(new Point(x-trueTaille,y,z), taille, new Point(0, PI/2, 0)));
    faces.add(new Face(new Point(x,y+trueTaille,z), taille));
    faces.add(new Face(new Point(x,y-trueTaille,z), taille));
    faces.add(new Face(new Point(x,y,z+trueTaille), taille));
    faces.add(new Face(new Point(x,y,z-trueTaille), taille));
  }
  
  void addFace(Face nextFace){
    faces.add(nextFace);
  }
  
  void addFace(int x, int y, int z){
    faces.add(new Face(x,y,z));
  }
  
  ArrayList<Face> getFaces(){
    return faces;
  }
  
  void displayShape(){
    beginShape();
    for(Face f : faces){
      f.displayFace();
    }
    endShape(CLOSE);
  }
}
