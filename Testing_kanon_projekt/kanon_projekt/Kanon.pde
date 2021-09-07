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

  void shoot() {
    pushMatrix();
    translate(position.x, position.y);
    canonBalls.add(new CanonBall(new PVector(direction*70*cos(angle)+position.x, 70*sin(angle)+position.y), angle, 10.0, direction));
    popMatrix();
  }

  void move() {
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
      if (key == upButton) {
        angle = angle - 0.05;
        if (angle< -PI/2) { // Prevents rotating the gun too much
          angle = -PI/2;
        }
      }
      if (key == downButton) {
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

  void run() {
    update();
    display();
    //move();
  }
}
