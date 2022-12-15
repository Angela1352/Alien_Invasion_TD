class AoE_Ring {
  float x, y;
  int d;
  int i;
  int cooldown;

  AoE_Ring(float _x, float _y, int _d) {
    x = _x;
    y = _y;
    d = _d;
  }

  void show() {
    stroke(white);
    strokeWeight(2);
    fill(red, 30);
    circle(x, y, d);
  }
}
