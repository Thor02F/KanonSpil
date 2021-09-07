Float theta1 = 0.0;
Float theta2 = 0.0;
Canon canon1, canon2;


void setup() {
  size(720, 360);
  canon1 = new Canon(new PVector(200, 200), theta1, 1.0, 40.0);
  canon2 = new Canon(new PVector(400, 200), theta2, -1.0, 40.0);
 map = new Map();
 esp = loadImage("COLLAGE3.png");
 image(esp,0,0,width,height);
 
   esp = loadImage("COLLAGE3.png");
  image(esp,0,0,width,height);
  
  noStroke();
  
  hs1 = new HScrollbar(0, height/1.25, width/3, 16, 16);
  hs2 = new HScrollbar(2*width/3, height/1.25, width/3, 16, 16);
}

//midlertidig knap til at skyde
void keyPressed() {
  if (key == 's' ) {

  }
}

void draw() {
  background(255);
  fill(250, 50, 0);
  canon1.run();
  canon2.run();
  //println();
/*
  //Life_Script
    if(canonball in p2 hitbox){//boolean  argumentet for p1 og p2 collision med canonball skal laves
    p2hit = true;
  }
  if(p2hit == true){
    p2life -= 10; //mister 10 liv ved et hit
    p2hit = false; //bør sørge for at der kun trækkes liv fra en gang per hit
  }
  if(canonball in p1 hitbox){
    p1hit = true;
  }
  if(p1hit == true){
    p1life -= 10; //mister 10 liv ved et hit
    p1hit = false; //bør sørge for at der kun trækkes liv fra en gang per hit
  }
  text(p2life,width/16,height/16, 9999,9999);
  text(p1life,width/16,height/16, 9999,9999);
 */
  
  
  //powerSlider
  fill(255);
  
  
  fill(255);

 
  hs1.update();
  hs2.update();
  hs1.display();
  hs2.display();
  
  stroke(0);

  
  //circleButton
  if(toggleColor) {
    cB = new Button(width/2, height/1.25, 125, "Fire Player 1", color(255, 0, 0));
  } else {
    cB = new Button(width/2, height/1.25, 125, "Fire Player 2", color(0, 0, 255));
  }
  if (cB.visible) cB.show();
  
  //map1337Espen2
  map.display();
}
