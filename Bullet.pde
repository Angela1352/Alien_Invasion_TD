class Bullet {

  float x, y, vx, vy, d;
  int hp;
  float speed;

  Bullet(float _x, float _y, float _vx, float _vy) {
    x = _x;
    y = _y;
    vx = _vx;
    vy = _vy;
    d = 12;
    hp = 1;
    speed = 1;
  }

  Bullet(float _x, float _y, float _d) {
    x = _x;
    y = _y;
    d = _d;
  }

  void show() {
    fill(white);
    stroke(black);
    noStroke();
    circle(x, y, d);
  }

  void act() {
    //println(hp);

    x = x + 5*vx*speed;
    y = y + 5*vy*speed;

    if (x >= width || x <= 0 || y <= 0 || y >= height) {
      hp = hp -1;
    }
  }
}
