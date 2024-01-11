void drawSliders(){
  panelObjects = new ArrayList<Face>();
  
  drawRightSliders();
  drawLeftSliders();
}

void drawRightSliders(){
  String[] sName = new String[3];
  sName[2] = "Rotation X";
  sName[1] = "Rotation Y";
  sName[0] = "Distance";
  
  String[] sVal = new String[3];
  sVal[2] = String.valueOf(int(map(sliderValues[2], sliderMin, sliderMax, 0, 360))) + "°";
  sVal[1] = String.valueOf(int(map(sliderValues[1], sliderMin, sliderMax, 0, 360))) + "°";
  sVal[0] = "";//String.valueOf(int(map(sliderValues[0], sliderMin, sliderMax, (sizeMax+200)/10, (sizeMin+200)/10)));
  
  // Removing an overcalculated bar
  fillMod(0.1, 0.1, 0.1);
  new Face(width - 4*spacing + barWid, 0, 4*spacing - barWid, height).displayFace();
  
  // Bars then sliders then text
  for(int i = 1; i <= 3; i++){
    fillMod(0.33, 0.33, 0.33);
    Face bar = new Face(width - i*spacing, distBorder, barWid, height - distBorder*2 - 100);
    bar.displayFace();
    panelObjects.add(bar);
    
    fillMod(0.6, 0.6, 0.6);
    int optionHeight = int(map(sliderValues[i-1], sliderMin, sliderMax, distBorder + barWid/2, height - distBorder - 3*barWid/2 - 100));
    
    Face slider = new Face(width - i*spacing - centerOffset, optionHeight, barWid + centerOffset * 2, sliderHei);
    slider.displayFace();
    panelObjects.add(slider);
    
    fillMod(1,1,1);
    textSize(fontSizeVal);
    text(sVal[i-1], width - i*spacing + (barWid - textWidth(sVal[i-1]))/2, distBorder/2 + height - distBorder - 35 + fontSizeVal/3, 0);
    
    textSize(fontSizeName);
    text(sName[i-1], width - i*spacing + (barWid - textWidth(sName[i-1]))/2, distBorder/2 + height - distBorder - 95 + fontSizeName/3, 0);
  }
}

void drawLeftSliders(){
  fillMod(0.1, 0.1, 0.1);
  new Face(0, 0, 2*spacing - barWid, height).displayFace();
  
  fillMod(0.33, 0.33, 0.33);
  Face bar = new Face(spacing - barWid, distBorder, barWid, height - distBorder*2 - 100);
  bar.displayFace();
  panelObjects.add(bar);
  
  fillMod(0.6, 0.6, 0.6);
  int optionHeight = int(map(sliderValues[3], 0, maxCCAmount, distBorder + barWid/2, height - distBorder - 3*barWid/2 - 100));
  Face slider = new Face(spacing - barWid - centerOffset, optionHeight, barWid + centerOffset * 2, sliderHei);
  slider.displayFace();
  panelObjects.add(slider);
  
  fillMod(1,1,1);
  String sName = "Catmull Clark level";
  String sVal = String.valueOf(sliderValues[3]);
  
  textSize(fontSizeVal);
  text(sVal, spacing - barWid + (barWid - textWidth(sVal))/2, distBorder/2 + height - distBorder - 35 + fontSizeVal/3, 0);
  
  textSize(fontSizeName);
  text(sName, spacing - barWid + (barWid - textWidth(sName))/2, distBorder/2 + height - distBorder - 95 + fontSizeName/3, 0);
 
  
}

boolean between(int val, int min, int max){
  return val > min && val < max;
}

void overBox(){
  currBoxSel = 0;
  Face randomF = panelObjects.get(0);
  
  int i = 2;
  if(between(mouseY, randomF.getMinY(), randomF.getMaxY())){
    for(Face f : panelObjects){
      if(between(mouseX, f.getMinX(), f.getMaxX())){
        currBoxSel = i/2;
        
        if(currBoxSel != 4){
          sliderValues[currBoxSel-1] = limitMap(mouseY, distBorder + barWid/2, height - distBorder - 3*barWid/2 - 100, sliderMin, sliderMax);
        } else {
          sliderValues[3] = limitMap(mouseY, distBorder + barWid/2, height - distBorder - 3*barWid/2 - 100, 0, maxCCAmount);
        }
      }
      i++;
    }
  }
}

void mousePressed() {
  overBox();
  if(currBoxSel != 0){
    locked[currBoxSel-1] = true;
  }
}

void mouseDragged() {
  for(int i = 0; i < 3; i++){
    if(locked[i]) {
      sliderValues[i] = limitMap(mouseY, distBorder + barWid/2, height - distBorder - 3*barWid/2 - 100, sliderMin, sliderMax);
    }
  }
  if(locked[3]){
    sliderValues[3] = limitMap(mouseY, distBorder + barWid/2, height - distBorder - 3*barWid/2 - 100, 0, maxCCAmount);
  }
}

void mouseReleased() {
  if(currBoxSel != 0){
    locked[currBoxSel-1] = false;
  }
}
