float twidth = 50;
float theight = 50;
class Map {
  
 void display(){
 rect(0,height-height/5,width,height/5); 
 triangle(width/2-twidth,height-height/5,width/2+twidth,height-height/5,width/2,height-height/5-theight);
 fill(150);
 noStroke();  
 }
  
}

Map map;

PImage esp;

void setup(){
 size(1000,800);
 map = new Map();
 esp = loadImage("COLLAGE3.png");
 image(esp,0,0,width,height);
}

void draw(){
  map.display();
}
