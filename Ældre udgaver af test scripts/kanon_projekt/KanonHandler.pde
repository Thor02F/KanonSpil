Float theta1 = 0.0;
Float theta2 = 0.0;
Canon canon1, canon2;


class CanonHandler {

  void setupCanons() {
    canon1 = new Canon(new PVector(200, height - 200), theta1, 1.0, 40.0, 'a', 'd', 'w', 's');
    canon2 = new Canon(new PVector(width - 200, height - 200), theta2, -1.0, 40.0, 'j', 'l', 'i', 'k');
  }

  void moveCanons() {

    if (canon1.position.x < width/2-70) {
      canon1.move();
    } else {
      canon1.velocity.x = 0;
      canon1.position.x -= 1;
    }

    if (canon2.position.x > width/2+70) {
      canon2.move();
    } else {
      canon2.velocity.x = 0;
      canon2.position.x += 1;
    }
  }
  void run() {
    fill(250, 50, 0);
    canon1.run();
    fill(0, 50, 250);
    canon2.run();
    moveCanons();
  }
}
