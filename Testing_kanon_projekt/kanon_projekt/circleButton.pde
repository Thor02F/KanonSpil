//Button class

Button cB;  //cB=circleButton
boolean toggleColor;
float r = 60; //radius af kuglen

//Ændre tekst her
/*void draw() {
  if(toggleColor) {
    cB = new Button(width/2, height/1.25, 125, "Fire Player 1", color(255, 0, 0));
  } else {
    cB = new Button(width/2, height/1.25, 125, "Fire Player 2", color(0, 0, 255));
  }
  if (cB.visible) cB.show();
}
*/

void mousePressed() {
  if (cB.visible) { //Hvis knappen ikke kan ses eksistere den ikke
    float d = dist(cB.pos.x, cB.pos.y, mouseX, mouseY);
    if (d <= cB.radius){
      // Knappen er klikket på og kalder på funktionen
      toggleColor = !toggleColor;
          if (toggleColor == true){
    canon1.shoot();}else
    canon2.shoot();
    } 
  }
}

class Button {
  PVector pos;
  float radius;
  color col;
  String caption;
  boolean visible;

  Button(float x, float y, float r, String txt, color c) {
    pos = new PVector(x, y);
    radius = r;
    caption = txt;
    col = c;
    visible = true;
  }

  void show() {
    fill(col);
    strokeWeight(3);
    ellipse(pos.x, pos.y, radius * 2, radius * 2);
    fill(0);
    float fontSize = radius * 0.30;
    textSize(fontSize);
    float tw = textWidth(caption);
    float tx = pos.x - (tw/2);
    float ty = pos.y + (fontSize / 2);
    text(caption, tx, ty);
  }
}
