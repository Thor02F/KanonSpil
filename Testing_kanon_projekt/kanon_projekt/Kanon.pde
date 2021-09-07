class Canon {
  PVector position;
  PVector velocity;
  float angle;
  float direction;
  boolean shoot = false;
  float radius;
  ArrayList<CanonBall> canonBalls;

  Canon(PVector position, float angle, float direction, float radius) {
    this.position = position;
    this.angle = angle;
    this.radius = radius;
    this.direction = direction;
    canonBalls = new ArrayList<CanonBall>();
  }

  void shoot() {
    pushMatrix();
    translate(position.x, position.y);
    canonBalls.add(new CanonBall(new PVector(direction*70*cos(angle)+position.x, 70*sin(angle)+position.y), angle, 10.0, direction));
    popMatrix();
  }

  void update() {
    for (int i = canonBalls.size()-1; i >= 0; i--) {
      CanonBall c = canonBalls.get(i);
      c.run();
      //c.velocity = new PVector(cos(angle)*5, sin(angle*5));
      if (c.hasHit()) {
        canonBalls.remove(i);
      }
    }

    if (keyPressed == true) {
      if (keyCode == UP) {
        angle = angle - 0.05;
        if (angle< -PI/2) { // Prevents rotating the gun too much
          angle = -PI/2;
        }
      }
      if (keyCode == DOWN) {
        angle = angle + 0.05;
        if (angle>=0.01) {
          angle = 0.01;
        }
      }
    }
  }

  void display() {
    pushMatrix();
    noStroke();
    //rectMode(CENTER);
    translate(position.x, position.y);
    scale(direction, 1);
    ellipse(0, radius/2, radius, radius);
    rect(0, 0, 10, 10);
    //println(angle);
    rotate(angle);
    rect(0, 0, 70, 10);
    //ellipse(0, 0, radius, radius);
    popMatrix();
  }

  void run() {
    update();
    display();
  }
}
