/**
 * La classe qui gère les points
 * @author YANG Mattew
 */

class Point {
  private float x;
  private float y;
  private float z;
  
  /**
   * Initialiser un point
   */
  Point(){}
  
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
  
  public void print(){
    println(x + " " + y + " " + z);
  }
  
}
