CanonHandler canonHandler;
LifeManager lifeManager;

void setup() {
  //size(1280,720);
  fullScreen();
  canonHandler = new CanonHandler();
  canonHandler.setupCanons();
  map = new Map();
  esp = loadImage("COLLAGE3.png");
  image(esp, 0, 0, width, height);

  esp = loadImage("COLLAGE3.png");
  image(esp, 0, 0, width, height);

  noStroke();

  hs1 = new HScrollbar(0, height/1.2, width/3, 20, 16);
  lifeManager = new LifeManager();
}

//midlertidig knap til at skyde


void draw() {

  background(255);
  map.display();
  //println();
  canonHandler.run();

  //map1337Espen2


  //draw lifeManager
  lifeManager.run();

  //draw powerSlider
  fill(255);

  hs1.update();
  hs1.display();



  //circleButton

  if (toggleColor==false) {
    cB = new Button(width/2, height/1.1, 60, "Fire Player 1", color(255, 0, 0));
  } else {
    cB = new Button(width/2, height/1.1, 60, "Fire Player 2", color(0, 0, 255));
  }
  if (cB.visible) cB.show();

  //println(hs1.getPos());
}
