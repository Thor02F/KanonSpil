class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;

  Particle(PVector l) {
    acceleration = new PVector(0,0.05);
    velocity = new PVector(random(-1,1),random(-2,0));
    position = l.get();
    lifespan = 255.0;
  }

  void run() {
    update();
    display();
  }

  //Opdater livet
  void update() {
    //velocity.add(acceleration);
    //position.add(velocity);
    lifespan -= 15.0;
  }

  // Method til display
  void display() {
    stroke(0,lifespan);
    strokeWeight(2);
    fill(255,0,0,lifespan); //RGB code og synlighed
    ellipse(position.x,position.y,150,150);
  }
  
  //Fjerner døde partikler
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}
