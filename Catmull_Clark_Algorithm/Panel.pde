void drawSliders(){
  panelObjects = new ArrayList<Face>();
  buttonObjects = new ArrayList<Face>();
  
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
  fillMod(0.33, 0.33, 0.33);
  new Face(width - 4*spacing + barWid, 0, 4*spacing - barWid, height).displayFace();
  
  // Bars then sliders then text
  for(int i = 1; i <= 3; i++){
    fillMod(0.5, 0.5, 0.5);
    Face bar = new Face(width - i*spacing, distBorder, barWid, height - distBorder*2 - 100);
    bar.displayFace();
    panelObjects.add(bar);
    
    fillMod(0.8, 0.8, 0.8);
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
  int iMax = 3;
  if(ticked != 0){
    iMax = 4;
  }
  
  fillMod(0.33, 0.33, 0.33);
  new Face(0, 0, iMax*spacing - barWid, height).displayFace();
  String sNames[] = {"Niveau", "Côtés"};
  String sVals[] = {String.valueOf(sliderValues[3]), String.valueOf(sliderValues[4])};
  
  for(int i = 2; i<iMax; i++){
    int minSubdiv = 0;
    int maxSubdiv = maxCCAmount;
    if(i == 3){
      minSubdiv = 3;
      maxSubdiv = 25;
    }
    
    fillMod(0.5, 0.5, 0.5);
    Face bar = new Face(i*spacing - barWid, distBorder, barWid, height - distBorder*2 - 100);
    bar.displayFace();
    panelObjects.add(bar);
    
    fillMod(0.8, 0.8, 0.8);
    int optionHeight = int(map(sliderValues[i+1], minSubdiv, maxSubdiv, distBorder + barWid/2, height - distBorder - 3*barWid/2 - 100));
    Face slider = new Face(i*spacing - barWid - centerOffset, optionHeight, barWid + centerOffset * 2, sliderHei);
    slider.displayFace();
    panelObjects.add(slider);
  
    String sName = sNames[i-2];
    String sVal = sVals[i-2];
    fillMod(1,1,1);
    textSize(fontSizeVal);
    text(sVal, i*spacing - barWid + (barWid - textWidth(sVal))/2, distBorder/2 + height - distBorder - 35 + fontSizeVal/3, 0);
    textSize(fontSizeName);
    text(sName, i*spacing - barWid + (barWid - textWidth(sName))/2, distBorder/2 + height - distBorder - 95 + fontSizeName/3, 0);
  }
  
  fillMod(0.5, 0.5, 0.5);
  for(int i=0; i<3; i++){
    int topX = (int) map(i, 0, 2, (int)(distBorder*1.5), height - (int)(distBorder*1.5) - 100 - barWid*2 - fontSizeVal);
    Face shapeChange = new Face((int)(spacing - barWid*1.5), topX, barWid*2, barWid*2);
    shapeChange.displayFace();
    
    buttonObjects.add(shapeChange);
  }
  
  fillMod(0.8, 0.8, 0.8);
  float checkmarkedSize = 0.3;
  for(int i=0; i<3; i++){
    if(i == ticked){
      // For some reason the tickmark is one pixel off, probably due to truncation
      int topX = (int) map(i, 0, 2, (int)(distBorder*1.5) + barWid*checkmarkedSize, height - (int)(distBorder*1.5) - 100 - barWid*(2-checkmarkedSize) - fontSizeVal);
      Face shapeChange = new Face((int)(spacing - barWid*(1.5-checkmarkedSize)) + 1, topX + 1, (int)(barWid*(2-checkmarkedSize*2)), (int)(barWid*(2-checkmarkedSize*2)));
      shapeChange.displayFace();
    }
  }
  
  fillMod(1,1,1);
  String[] sTicks = {"Cube", "Pyramide", "Tore"};
  for(int i = 0; i<3; i++){
    String s = sTicks[i];
    int topX = (int) map(i, 0, 2, (int)(distBorder*1.5) + barWid*2 + fontSizeVal, height - (int)(distBorder*1.5) - 100);
    textSize(fontSizeVal);
    text(s, spacing - barWid + (barWid - textWidth(s))/2, topX, 0);
  }
  
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
        
        if(currBoxSel == 4){
          sliderValues[3] = limitMap(mouseY, distBorder + barWid/2, height - distBorder - 3*barWid/2 - 100, 0, maxCCAmount);
        } else if(currBoxSel == 5) {
          sliderValues[4] = limitMap(mouseY, distBorder + barWid/2, height - distBorder - 3*barWid/2 - 100, 3, 25);
        } else {
          sliderValues[currBoxSel-1] = limitMap(mouseY, distBorder + barWid/2, height - distBorder - 3*barWid/2 - 100, sliderMin, sliderMax);
        }
      }
      i++;
    }
  }
  
  int j = 0;
  for(Face f : buttonObjects){
    if(between(mouseX, f.getMinX(), f.getMaxX()) && between(mouseY, f.getMinY(), f.getMaxY())){
      ticked = j;
    }
    j++;
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
  if(locked[4]){
    sliderValues[4] = limitMap(mouseY, distBorder + barWid/2, height - distBorder - 3*barWid/2 - 100, 3, 25);
  }
}

void mouseReleased() {
  if(currBoxSel != 0){
    locked[currBoxSel-1] = false;
  }
}
