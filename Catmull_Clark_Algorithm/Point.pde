/**
 * La classe qui gère les points
 * @author YANG Mattew
 */

class Point {
  private float x=0.0;
  private float y=0.0;
  private float z=0.0;
  
  /**
   * Initialiser un point
   */
  Point(){}
  
  /**
   * Make a deep copy of a Point
   *
   * @param p The point we are making a deep copy of
   */
   Point(Point p){
     this.x = p.getX();
     this.y = p.getY();
     this.z = p.getZ();
   }
  
  /**
   * Créer un point à partir de ces coordonnées dans le repère
   * Constructeur avec entiers
   * @param initX le coordonnée X du point
   * @param initY le coordonnée Y du point
   * @param initZ le coordonnée Z du point
   */
  Point(int initX, int initY, int initZ){
    x = float(initX);
    y = float(initY);
    z = float(initZ);
  }
  
  /**
   * Créer un point à partir de ces coordonnées dans le repère
   * @param initX le coordonnée X du point
   * @param initY le coordonnée Y du point
   * @param initZ le coordonnée Z du point
   */
  Point(float initX, float initY, float initZ){
    x = initX;
    y = initY;
    z = initZ;
  }
  
  /**
   * Récupérer le coordonnée X du point
   */
  public float getX(){
    return x;
  }
  
  /**
   * Récupérer le coordonnée Y du point
   */
  public float getY(){
    return y;
  }
  
  /**
   * Récupérer le coordonnée Z du point
   */
  public float getZ(){
    return z;
  }
  
  @Override
  public boolean equals(Object obj) {
    if (this == obj) {
      return true;
    }
    if (obj == null || getClass() != obj.getClass()) {
      return false;
    }

    Point other = (Point) obj;
    
    float thresh = 0.001;
    boolean xEq, yEq, zEq;
    xEq = abs(this.x - other.x) < thresh;
    yEq = abs(this.y - other.y) < thresh;
    zEq = abs(this.z - other.z) < thresh;
    
    return xEq && yEq && zEq;
  }
  
  @Override
  public String toString() {
    return "(" + x + ", " + y + ", " + z + ")";
  }
  
  void displayPoint(){
    displayPoint(5);
  }
  
  void displayPoint(int size){
    pushMatrix();
    translate(x,y,z);
    sphere(size);
    popMatrix();
  }
  
}
