PImage esp;
Map map = new Map();

void setup(){
  esp = loadImage("COLLAGE3.png");
  image(esp,0,0,width,height);
}

class Map{
  void display(){
    line(width,height*4/5,width/2+width/48,height*4/5);
    line(0,height*4/5,width/2-width/48,height*4/5);
    line(width/2-width/48,height*4/5,width/2,height*4/5-width/24);
    line(width/2+width/48,height*4/5,width/2,height*4/5-width/24);
  }
}
