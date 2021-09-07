
class CanonBall {
  PVector position;
  PVector velocity;
  PVector acceleration = new PVector();
  PVector gravity = new PVector(0, 0.01);
  float angle;
  float radius;
  float direction;

  CanonBall(PVector position, float angle, float radius, float direction) {
    this.position = position;
    this.radius = radius;
    this.direction = direction;
    this.angle = angle;
    velocity = new PVector(hs1.getPos()*direction*cos(angle)*5, hs1.getPos()*sin(angle)*5);
  }

  void update() {
    applyForce(gravity);
    position.add(velocity);
    velocity.add(acceleration);
    //velocity.mult(hs1.getPos());
  }

  void display() {
    pushMatrix();
    translate(position.x, position.y);
    ellipse(0, 0, radius, radius);
    popMatrix();
  }


  boolean hasHit() {
    if (velocity.x == 0 && velocity.y == 0 || position.x > width || position.x < 0) {
      return true;
    } else {
      return false;
    }
  }

  void applyForce(PVector gravity) {
    acceleration.add(gravity);
  }

  void run() {
    update();
    display();
    //println(angle);
  }
}
