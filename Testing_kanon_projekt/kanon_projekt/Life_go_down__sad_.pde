
boolean p2hit = false, p1hit = false;
float p2life = 100, p1life = 100;

class LifeManager {
  void update() {
    if (p2hit == true) {
      p2life -= 10; //mister 10 liv ved et hit
      p2hit = false; //bør sørge for at der kun trækkes liv fra en gang per hit
    }
    if (p1hit == true) {
      p1life -= 10; //mister 10 liv ved et hit
      p1hit = false; //bør sørge for at der kun trækkes liv fra en gang per hit
    }
  }

  void display() {
    text(str(p1life), width/16, height/16, 9999, 9999);
    text(str(p2life), width/1.2, height/16, 9999, 9999);
  }

  void run() {
    update();
    display();
  }
}
