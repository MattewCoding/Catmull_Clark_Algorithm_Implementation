/**
 * La classe qui gère les facettes
 * @author YANG Mattew
 */

class Face{
  private ArrayList<Point> points = new ArrayList<Point>();
  private Point centre = new Point(0,0,0);
  private Point rotation = new Point(0,0,0); // En radians
  
  private int minX=0, minY=0, maxX=0, maxY=0;
  
  /**
   * Initialiser une facette
   */
  Face(){}
  
  Face(int sX, int sY, int widthS, int heightS){
    squareFromPoints(sX, sY, widthS, heightS, 0);
  }
  
  /**
   * Make a deep copy of a Face
   *
   * @param f The face we are making a deep copy of
   */
  Face(Face f){
    this.points = new ArrayList<Point>();
    for(Point p : f.getPoints()){
      this.points.add(new Point(p));
    }
    this.centre = new Point(f.getCentre());
    this.rotation = new Point(f.getRotation());
  }
  
  void squareFromPoints(int sX, int sY, int widthS, int heightS, int z){
    minX = sX;
    minY = sY;
    maxX = sX + widthS;
    maxY = sY + heightS;
    
    Point p1, p2, p3, p4;
    p1 = new Point(minX, minY, z);
    p2 = new Point(maxX, minY, z);
    p3 = new Point(maxX, maxY, z);
    p4 = new Point(minX, maxY, z);
    
    square(p1, p2, p3, p4);
  }
  
  Face(Point... pts){
    for(Point p : pts){
      points.add(p);
    }
  }
  
  void square(Point p1, Point p2, Point p3, Point p4){
    points.add(p1);
    points.add(p2);
    points.add(p3);
    points.add(p4);
  }
  
  /**
   * Crée une facette avec un nombre spécifié de côtés et une taille donnée,
   * anglé dans une direction
   * 
   * @param c Le point central de la facette
   * @param r La rotation de la facette en radians
   * @param nbCotes Le nombre de côtés de la facette
   */
  Face(Point c, Point r, int nbCotes, float taille){
    centre = c;
    rotation = r;
    creerPolygonRegulier(nbCotes, taille/2);
  }
  
  /**
   * Crée une facette avec 4 côtés face vers l'utilisateur.
   * Cette méthode prend en compte le fait que le diamètre d'un carré
   * n'est généralement pas mesuré à partir de points opposés.
   *
   * @param c Le point central de la facette.
   * @param taille La diametre de la facette.
   */
  Face(Point c, float taille){
    centre = c;
    creerPolygonRegulier(4, taille * sqrt(2)/2);
  }
  
  /**
   * Crée une facette avec 4 côtés, anglé dans une direction
   * Cette méthode prend en compte le fait que le diamètre d'un carré
   * n'est généralement pas mesuré à partir de points opposés.
   *
   * @param c Le point central de la facette.
   * @param taille La diametre de la facette.
   * @param r La rotation de la facette en radians
   */
  Face(Point c, float taille, Point r){
    centre = c;
    rotation = r;
    creerPolygonRegulier(4, taille * sqrt(2)/2);
  }

  
  /**
   * Crée un polygone régulier en utilisant le nombre spécifié de côtés, une taille donnée
   * et un centre défini par un objet Point.
   * Cette méthode contient une approche de contournement maladroite qui simule la
   * fonctionnalité usuelle du constructeur de Java permettant d'appeler d'autres constructeurs.
   *
   * @param nbCotes Le nombre de côtés du polygone régulier.
   * @param taille La taille des côtés du polygone régulier.
   */
  private void creerPolygonRegulier(int nbCotes, float taille) {
    double angleIncrement = 2 * Math.PI / nbCotes;
  
    // Pour que le bas du polygon soit paralèlle avec l'axe d'abscisses
    double adjust = 0;
    if (nbCotes % 4 == 0) {
      adjust = Math.PI / nbCotes;
    }
  
    // Calcul des coordonnées des points du polygone et ajout à la liste
    for (int i = 0; i < nbCotes; i++) {
      double angle = i * angleIncrement - adjust;
      float x = (float) (taille * Math.cos(angle));
      float y = (float) (taille * Math.sin(angle));
  
      points.add(new Point(x, y, 0));
    }
    
    // Affichage d'une ligne vide
    System.out.print("\n");
  }
  
  public void modifyNthPoint(int value, Point newPoint){
    points.set(value, newPoint);
  }
  
  /**
   * Récupère le nième point de la face.
   *
   * @return Le nième point de la face.
   */
  public Point getNthPoint(int i){
    return points.get(i);
  }
  
  /**
   * Récupère la liste des points de la face.
   *
   * @return La liste des points de la face.
   */
  public ArrayList<Point> getPoints(){
    return points;
  }
  
  /**
   * Récupère le centre de la face.
   *
   * @return Le centre de la face.
   */
  public Point getCentre(){
    return centre;
  }
  
  /**
   * Récupère la rotation de la face.
   *
   * @return La rotation de la face.
   */
  public Point getRotation(){
    return rotation;
  }
  
  /**
   * Récupère la liste des points de la face.
   *
   * @return La liste des points de la face.
   */
  public int getSize(){
    return points.size();
  }
  
  public int getMinX(){
    return minX;
  }
  
  public int getMinY(){
    return minY;
  }
  
  public int getMaxX(){
    return maxX;
  }
  
  public int getMaxY(){
    return maxY;
  }
  
  public String toString() {
    Face realPositionFace = getRealPosition(this);
    for(Point p : realPositionFace.getPoints()){
      print(p);
      print("\n");
    }
    return "";
  }

  /**
   * Affiche la face en utilisant les points spécifiés pour former une forme fermée.
   * Utilise la méthode beginShape(), vertex() et endShape(CLOSE) de la bibliothèque de traitement graphique.
   */
  public void displayFace(){
    pushMatrix();
      translate(centre.getX(), centre.getY(), centre.getZ());
      rotateX(rotation.getX());
      rotateY(rotation.getY());
      rotateZ(rotation.getZ());
      beginShape();
      for(Point p : points){
        vertex(p.getX(), p.getY(), p.getZ());
      }
      endShape();
    popMatrix();
  }
}

//https://stackoverflow.com/questions/72270464/how-to-draw-a-cube-in-processing-without-the-box-function
