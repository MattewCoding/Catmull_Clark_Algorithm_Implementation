void testEdgeCalc(Shape s){

  for(int i=0; i<s.getFaces().size(); i++){
    for(int j=i+1; j<s.getFaces().size(); j++){
      try{
        Point p = edgeCalc(getRealPosition(s.getFaces().get(i)), getRealPosition(s.getFaces().get(j)));
        p.displayPoint();
      } catch(RuntimeException re){
      }
    }
  }
  
  new Point(0,0,0).displayPoint();

  s.displayShape(1,2,5);
}
