
class CanonBall {
  PVector position;
  PVector velocity;
  PVector acceleration = new PVector();
  PVector gravity = new PVector(0,0.01);
  float angle;
  float radius;
  float direction;

  CanonBall(PVector position, float angle, float radius, float direction) {
    this.position = position;
    this.radius = radius;
    this.direction = direction;
    this.angle = angle;
    velocity = new PVector(direction*cos(angle)*5, sin(angle)*5);

  }

  void update() {
    applyForce(gravity);
    position.add(velocity);
    velocity.add(acceleration);
  }

  void display() {
    pushMatrix();
    translate(position.x, position.y);
    ellipse(0,0,radius,radius);
    popMatrix();
  }

  boolean hasHit() {
    if (velocity.x == 0 && velocity.y == 0 || position.x > width || position.x < 0 || position.y > height || position.y < 0) {
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
    println(angle);
  }
}
