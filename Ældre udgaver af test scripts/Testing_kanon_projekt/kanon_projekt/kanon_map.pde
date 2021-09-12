PImage esp;
Map map = new Map();
import processing.sound.*;
SoundFile age_of_war;

class Map {
  void display() {
    fill(150);
    line(width, height*4/5, width/2+width/48, height*4/5);
    line(0, height*4/5, width/2-width/48, height*4/5);
    line(width/2-width/48, height*4/5, width/2, height*4/5-width/24);
    line(width/2+width/48, height*4/5, width/2, height*4/5-width/24);
    rect(0, height-height/5, width, height/5); 
    triangle(width/2-twidth, height-height/5, width/2+twidth, height-height/5, width/2, height-height/5-theight);

    //noStroke();
  }
}
