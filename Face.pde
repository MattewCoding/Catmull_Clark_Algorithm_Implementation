/**
 * La classe qui gère les facettes
 * @author YANG Mattew
 */

class Face{
  private ArrayList<Point> points = new ArrayList<Point>();
  private Point centre = new Point(0,0,0);
  private Point rotation = new Point(0,0,0);
  
  /**
   * Initialiser une facette
   */
  Face(){}
  
  Face(Point firstPoint){
    addPoint(firstPoint);
  }
  
  Face(int x, int y, int z){
    addPoint(x,y,z);
  }
  
  /**
   * Crée une facette avec un nombre spécifié de côtés et une taille donnée,
   * qui fait face à l'utilisateur.
   * 
   * @param c Le point central de la facette.
   * @param nbCotes Le nombre de côtés de la facette.
   */
  Face(Point c, int nbCotes, float taille){
    centre = c;
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
  
      // Ajout du point avec une valeur arbitraire (50.0) à la liste
      points.add(new Point(x, y, 0));
    }
    
    // Affichage d'une ligne vide
    print("\n");
  }

  
  /**
   * Ajoute un point à la liste de points de la face.
   *
   * @param nextPoint Le point à ajouter à la liste.
   */
  public void addPoint(Point nextPoint){
    points.add(nextPoint);
  }
  
  /**
   * Ajoute un point à la liste de points de la face en spécifiant les coordonnées x, y et z.
   *
   * @param x La coordonnée x du point.
   * @param y La coordonnée y du point.
   * @param z La coordonnée z du point.
   */
  public void addPoint(int x, int y, int z){
    points.add(new Point(x, y, z));
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
   * Récupère la liste des points de la face.
   *
   * @return La liste des points de la face.
   */
  public int getSize(){
    return points.size();
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
      endShape(CLOSE);
    popMatrix();
  }
}

//https://stackoverflow.com/questions/72270464/how-to-draw-a-cube-in-processing-without-the-box-function
