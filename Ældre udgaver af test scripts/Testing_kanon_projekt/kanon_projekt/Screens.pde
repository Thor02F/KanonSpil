//SoundFile file;
//boolean toggleMusic = false;

void menuScreen() {  
  cB = new Button(width*2, height/1.1, 60, "Fire Player 1", color(255, 0, 0));
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

  theta1 = theta2 = 0.0;

  if (keyPressed && key == ' ') { 

    p1life = 100;
    p2life = 100;
    gameState = 1;
  }
}

void gameScreen() {
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
    cB = new Button(width/2, height/1.1, 60, "Fire Player 1", color(255, 0, 0));
  } else {
    cB = new Button(width/2, height/1.1, 60, "Fire Player 2", color(0, 0, 255));
  }
  if (cB.visible) cB.show();

  if (p1life <= 0 || p2life <= 0) gameState = 2;
}
