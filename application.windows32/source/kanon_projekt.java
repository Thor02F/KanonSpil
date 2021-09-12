import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.sound.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class kanon_projekt extends PApplet {

//import processing.sound.*;
CanonHandler canonHandler;
LifeManager lifeManager;
int gameState = 2;
ParticleSystem ps1, ps2;

public void setup() {
  
  canonHandler = new CanonHandler();
  canonHandler.setupCanons();
  ps1 = new ParticleSystem(new PVector(canon2.position.x,canon2.position.y));
  ps2 = new ParticleSystem(new PVector(canon1.position.x,canon1.position.y));
  lifeManager = new LifeManager();
  
  
  map = new Map();
  esp = loadImage("COLLAGE3.png");
  image(esp, 0, 0, width, height);

  noStroke();

  hs1 = new HScrollbar(0, height/1.2f, width/3, 20, 16);
}

public void draw() {

  if (gameState ==  1) {
    gameScreen();
  } else if (gameState == 2) {
    menuScreen();
  } else {
    println("something went wrong");
  }
}

class CanonBall {
  PVector position;
  PVector velocity;
  PVector acceleration = new PVector();
  PVector gravity = new PVector(0, 0.01f);
  float angle;
  float radius;
  float direction;
  boolean hasHit = false;

  CanonBall(PVector position, float angle, float radius, float direction) {
    this.position = position;
    this.radius = radius;
    this.direction = direction;
    this.angle = angle;
    velocity = new PVector(hs1.getPos()*direction*cos(angle)*5, hs1.getPos()*sin(angle)*5);
  }

  public void update() {
    applyForce(gravity);
    position.add(velocity);
    velocity.add(acceleration);

    if (velocity.x == 0 && velocity.y == 0 || position.x > width || position.x < 0) {
      hasHit = false;
    }
  }

  public void display() {
    pushMatrix();
    translate(position.x, position.y);
    ellipse(0, 0, radius, radius);
    popMatrix();
  }

  public void applyForce(PVector gravity) {
    acceleration.add(gravity);
  }


  public boolean isDead() {
    if (position.x < 0 || position.x > width || position.y > height) {
      return true;
    } else {
      return false;
    }
  }

  public void run() {
    update();
    display();
    //hasHit();
    //println(angle);
  }
}
class Canon {
  PVector position;
  PVector velocity = new PVector(0, 0);
  float angle;
  float direction;
  boolean shoot = false;
  float radius;
  ArrayList<CanonBall> canonBalls;
  char rightButton, leftButton, upButton, downButton;

  Canon(PVector position, float angle, float direction, float radius, char leftButton, char rightButton, char upButton, char downButton) {
    this.position = position;
    this.angle = angle;
    this.radius = radius;
    this.direction = direction;
    this.rightButton = rightButton;
    this.leftButton = leftButton;
    this.upButton = upButton;
    this.downButton = downButton;
    canonBalls = new ArrayList<CanonBall>();
  }

  public void shoot() {
    pushMatrix();
    translate(position.x, position.y);
    canonBalls.add(new CanonBall(new PVector(direction*70*cos(angle)+position.x, 70*sin(angle)+position.y), angle, 10.0f, direction));
    popMatrix();
  }

  public void move() {
    if (keyPressed && key == rightButton) {
      velocity.x = 1;
      position.add(velocity);
    }
    if (keyPressed && key == leftButton) {
      velocity.x = 1;
      position.sub(velocity);
    }
    velocity.x = 0;
  }

  public void update() {
    for (int i = canonBalls.size()-1; i >= 0; i--) {
      CanonBall c = canonBalls.get(i);
      c.run();
      //c.velocity = new PVector(cos(angle)*5, sin(angle*5));
      if (c.isDead() || gameState != 1) {
        canonBalls.remove(i);
        //println("removed ball");
      }
    }

    if (keyPressed == true) {
      if (key == upButton) {
        angle = angle - 0.05f;
        if (angle< -PI/2) { // Prevents rotating the gun too much
          angle = -PI/2;
        }
      }
      if (key == downButton) {
        angle = angle + 0.05f;
        if (angle>=0.01f) {
          angle = 0.01f;
        }
      }
    }
  }

  public void display() {
    pushMatrix();
    noStroke();
    translate(position.x, position.y);
    scale(direction, 1);
    ellipse(0, radius/2, radius, radius);
    rect(0, 0, 10, 10);
    triangle(5, 40, -65, 40, 0, 10);
    triangle(0, 40, 30, 40, 0, 10);
    rect(-70, 40, 100, 10);
    rotate(angle);
    rect(0, 0, 70, 10);
    popMatrix();
  }

  public void run() {
    update();
    display();
    //move();
  }
}
Float theta1 = 0.0f;
Float theta2 = 0.0f;
Canon canon1, canon2;


class CanonHandler {

  public void setupCanons() {
    canon1 = new Canon(new PVector(200, height - 200), theta1, 1.0f, 40.0f, 'a', 'd', 'w', 's');
    canon2 = new Canon(new PVector(width - 200, height - 200), theta2, -1.0f, 40.0f, 'j', 'l', 'i', 'k');
  }

  public void moveCanons() {

    if (canon1.position.x < width/2-70) {
      canon1.move();
    } else {
      canon1.velocity.x = 0;
      canon1.position.x -= 1;
    }

    if (canon2.position.x > width/2+70) {
      canon2.move();
    } else {
      canon2.velocity.x = 0;
      canon2.position.x += 1;
    }
  }
  public void run() {
    fill(250, 50, 0);
    canon1.run();
    fill(0, 50, 250);
    canon2.run();
    moveCanons();
    hitDetect();
  }

  public void hitDetect() {
    //HIT DETECTION
    for (CanonBall b : canon1.canonBalls) {
      //kanon2 ramt ??
      if (dist(b.position.x, b.position.y, canon2.position.x, canon2.position.y)<50) {
        //der skal ske et eller andet med noget liv
        //println("kanon 2 ramt");
        ps1 = new ParticleSystem(new PVector(canon2.position.x,canon2.position.y));
        ps1.addParticle();
        b.position.x = width * 2;
        p2hit = true;
      }
    }

    for (CanonBall b : canon2.canonBalls) {
      //kanon1 ramt ?
      if (dist(b.position.x, b.position.y, canon1.position.x, canon1.position.y)<50) {
        //der skal ske et eller andet med noget liv
        //println("kanon 1 ramt");
        ps2 = new ParticleSystem(new PVector(canon1.position.x,canon1.position.y));
        ps2.addParticle();
        b.position.x = width * 2;
        p1hit = true;
      }
    }
  }
}

boolean p2hit = false, p1hit = false;
float p2life = 100, p1life = 100;

class LifeManager {
  public void update() {
    if (p2hit == true) {
      p2life -= 10; //mister 10 liv ved et hit
      p2hit = false; //bør sørge for at der kun trækkes liv fra en gang per hit
    }
    if (p1hit == true) {
      p1life -= 10; //mister 10 liv ved et hit
      p1hit = false; //bør sørge for at der kun trækkes liv fra en gang per hit
    }
  }

  public void display() {
    text(str(p1life), width/16, height/16, 9999, 9999);
    text(str(p2life), width/1.2f, height/16, 9999, 9999);
  }

  public void run() {
    update();
    display();
  }
}
float twidth = 50;
float theight = 50;
/*
class Map {
 
 void display(){
 rect(0,height-height/5,width,height/5); 
 triangle(width/2-twidth,height-height/5,width/2+twidth,height-height/5,width/2,height-height/5-theight);
 fill(150);
 noStroke();  
 }
 
 }
 */
//Map map;

//PImage esp;
/*
void setup(){
 size(1000,800);
 map = new Map();
 esp = loadImage("COLLAGE3.png");
 image(esp,0,0,width,height);
 }
 */
/*
void draw(){
 map.display();
 }
 */
class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;

  Particle(PVector l) {
    acceleration = new PVector(0,0.05f);
    velocity = new PVector(random(-1,1),random(-2,0));
    position = l.get();
    lifespan = 255.0f;
  }

  public void run() {
    update();
    display();
  }

  //Opdater livet
  public void update() {
    //velocity.add(acceleration);
    //position.add(velocity);
    lifespan -= 15.0f;
  }

  // Method til display
  public void display() {
    stroke(0,lifespan);
    strokeWeight(2);
    fill(255,0,0,lifespan); //RGB code og synlighed
    ellipse(position.x,position.y,150,150);
  }
  
  //Fjerner døde partikler
  public boolean isDead() {
    if (lifespan < 0.0f) {
      return true;
    } else {
      return false;
    }
  }
}
//SoundFile file;
//boolean toggleMusic = false;

public void menuScreen() {  
  cB = new Button(width*2, height/1.1f, 60, "Fire Player 1", color(255, 0, 0));
  canonHandler = new CanonHandler();
  canonHandler.setupCanons();
  background(255);
  fill(0);
  textSize(height / 20);
  text("GAME OVER. Press Space", height / 2, width / 2);
  esp = loadImage("COLLAGE3.png");
  image(esp,0,0,width,height);

  for (CanonBall b : canon1.canonBalls) { 
    b.position.x = width * 2;
  }
  for (CanonBall b : canon2.canonBalls) {
    b.position.x = width * 2;
  }

  theta1 = theta2 = 0.0f;

  if (keyPressed && key == ' ') { 

    p1life = 100;
    p2life = 100;
    gameState = 1;
  }
}

public void gameScreen() {
  //file = new SoundFile(this, "Tanks.wav");// Musiken begynder at at være funky efter noget tid
  //if (toggleMusic == false){
  //file.play();
  //toggleMusic = true;
  //}
  background(255);
  map.display();
  canonHandler.run();
  lifeManager.run();
  fill(255);
  hs1.run();
  ps1.run();
  ps2.run();
  //circleButton
  if (toggleColor == false) {  
    cB = new Button(width/2, height/1.1f, 60, "Fire Player 1", color(255, 0, 0));
  } else {
    cB = new Button(width/2, height/1.1f, 60, "Fire Player 2", color(0, 0, 255));
  }
  if (cB.visible) cB.show();

  if (p1life <= 0 || p2life <= 0) gameState = 2;
}
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

public void mousePressed() {
  if (cB.visible) { //Hvis knappen ikke kan ses eksistere den ikke
    float d = dist(cB.pos.x, cB.pos.y, mouseX, mouseY);
    if (d <= cB.radius) {
      // Knappen er klikket på og kalder på funktionen
      toggleColor = !toggleColor;
      if (toggleColor == true) {
        canon1.shoot();
      } else
        canon2.shoot();
    }
  }
}

class Button {
  PVector pos;
  float radius;
  int col;
  String caption;
  boolean visible;

  Button(float x, float y, float r, String txt, int c) {
    pos = new PVector(x, y);
    radius = r;
    caption = txt;
    col = c;
    visible = true;
  }

  public void show() {
    fill(col);
    strokeWeight(3);
    ellipse(pos.x, pos.y, radius * 2, radius * 2);
    fill(0);
    float fontSize = radius * 0.30f;
    textSize(fontSize);
    float tw = textWidth(caption);
    float tx = pos.x - (tw/2);
    float ty = pos.y + (fontSize / 2);
    text(caption, tx, ty);
  }
}
PImage esp;
Map map = new Map();

SoundFile age_of_war;

class Map {
  public void display() {
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
  class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;

  ParticleSystem(PVector position) {
    origin = position.get();
    particles = new ArrayList<Particle>();
  }

  public void addParticle() {
    particles.add(new Particle(origin));
  }

  public void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
}
HScrollbar hs1, hs2;  // Two scrollbars

class HScrollbar {
  int swidth, sheight;    // width and height of bar
  float xpos, ypos;       // x and y position of bar
  float spos, newspos;    // x position of slider
  float sposMin, sposMax; // max and min values of slider
  int loose;              // how loose/heavy
  boolean over;           // is the mouse over the slider?
  boolean locked;
  float ratio = 4000;

  HScrollbar (float xp, float yp, int sw, int sh, int l) {
    swidth = sw;
    sheight = sh;
    int widthtoheight = sw - sh;
    ratio = (float)sw / (float)widthtoheight;
    xpos = xp;
    ypos = yp-sheight/2;
    spos = xpos + swidth/2 - sheight/2;
    newspos = spos;
    sposMin = xpos;
    sposMax = xpos + swidth - sheight;
    loose = l;
  }

  public void update() {
    if (overEvent()) {
      over = true;
    } else {
      over = false;
    }
    if (mousePressed && over) {
      locked = true;
    }
    if (!mousePressed) {
      locked = false;
    }
    if (locked) {
      newspos = constrain(mouseX-sheight/2, sposMin, sposMax);
    }
    if (abs(newspos - spos) > 1) {
      spos = spos + (newspos-spos)/loose;
    }
  }

  public float constrain(float val, float minv, float maxv) {
    return min(max(val, minv), maxv);
  }

  public boolean overEvent() {
    if (mouseX > xpos && mouseX < xpos+swidth &&
      mouseY > ypos && mouseY < ypos+sheight) {
      return true;
    } else {
      return false;
    }
  }

  public void display() {
    noStroke();
    fill(204);
    rect(xpos, ypos, swidth, sheight);
    if (over || locked) {
      fill(0, 0, 0);
    } else {
      fill(102, 102, 102);
    }
    rect(spos, ypos, sheight, sheight);
  }

  public float getPos() {
    // Convert spos to be values between
    // 0 and the total width of the scrollbar

    return 1+(spos+0.1f)/100;
  }

  public void run() {
    display();
    update();
  }
}
  public void settings() {  size (1280,720); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#666666", "--stop-color=#cccccc", "kanon_projekt" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
