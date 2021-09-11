CanonHandler canonHandler;
LifeManager lifeManager;
int gameState = 2;
ParticleSystem ps1, ps2;

void setup() {
  fullScreen();
  canonHandler = new CanonHandler();
  canonHandler.setupCanons();
  ps1 = new ParticleSystem(new PVector(canon2.position.x,canon2.position.y));
  ps2 = new ParticleSystem(new PVector(canon1.position.x,canon1.position.y));
  lifeManager = new LifeManager();
  
  
  map = new Map();
  esp = loadImage("COLLAGE3.png");
  image(esp, 0, 0, width, height);

  noStroke();

  hs1 = new HScrollbar(0, height/1.2, width/3, 20, 16);
}

void draw() {

  if (gameState ==  1) {
    gameScreen();
  } else if (gameState == 2) {
    menuScreen();
  } else {
    println("something went wrong");
  }
}
