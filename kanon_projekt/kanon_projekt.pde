Float theta1 = 0.0;
Float theta2 = 0.0;
Canon canon1, canon2;

void setup() {
  size(720, 360);
  canon1 = new Canon(new PVector(200, 200), theta1, 1.0, 40.0);
  canon2 = new Canon(new PVector(400, 200), theta2, -1.0, 40.0);
}

//midlertidig knap til at skyde
void keyPressed() {
  if (key == 's' ) {
    canon1.shoot();
    canon2.shoot();
  }
}

void draw() {
  background(255);
  fill(250, 50, 0);
  canon1.run();
  canon2.run();
  //println();
}
