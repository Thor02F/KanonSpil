CanonHandler canonHandler;
;

void setup() {
  //size(720,360);
  fullScreen();
  canonHandler = new CanonHandler();
  canonHandler.setupCanons();
}

//midlertidig knap til at skyde
void keyPressed() {
  if (key == ' ' ) {
    canon1.shoot();
    canon2.shoot();
  }
}

void draw() {
  background(255);
  //println();
  canonHandler.run();
}
