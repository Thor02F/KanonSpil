CanonHandler canonHandler;
;

void setup() {
  //size(1280,720);
  fullScreen();
  canonHandler = new CanonHandler();
  canonHandler.setupCanons();
 map = new Map();
 esp = loadImage("COLLAGE3.png");
 image(esp,0,0,width,height);
 
   esp = loadImage("COLLAGE3.png");
  image(esp,0,0,width,height);
  
  noStroke();
  
  hs1 = new HScrollbar(0, height/1.2, width/3, 20, 16);
 // hs2 = new HScrollbar(2*width/3, height/1.2, width/3, 20, 16);
}

//midlertidig knap til at skyde


void draw() {
   
  background(255);
  map.display();
  //println();
  canonHandler.run();

//map1337Espen2
 

  //Life_Script
    
    p2hit = true;
  //}
  if(p2hit == true){
    p2life -= 10; //mister 10 liv ved et hit
    p2hit = false; //bør sørge for at der kun trækkes liv fra en gang per hit
  }
  if(key == 's' ){
    p1hit = true;
  }
  if(p1hit == true){
    p1life -= 10; //mister 10 liv ved et hit
    p1hit = false; //bør sørge for at der kun trækkes liv fra en gang per hit
  }
  text("p2life",width/16,height/16, 9999,9999);
  text("p1life",width/1.2,height/16, 9999,9999);
 
  
  
  //powerSlider
  fill(255);
  
  
  fill(255);
  
  hs1.update();
 // hs2.update();
  hs1.display();
 // hs2.display();
  
  //stroke(0);

  
  //circleButton
  
  if(toggleColor==false) {  
    cB = new Button(width/2, height/1.1, 60, "Fire Player 1", color(255, 0, 0));
  } else {
    cB = new Button(width/2, height/1.1, 60, "Fire Player 2", color(0, 0, 255));
  }
  if (cB.visible) cB.show();
  
  println(hs1.getPos());

}
