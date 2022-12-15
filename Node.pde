class Node {

  float x, y, dx, dy;

  Node(float _x, float _y, float _dx, float _dy) {
    x  = _x;
    y  = _y;
    dx = _dx;
    dy = _dy;
  }

  void show() {
    fill(black);
    stroke(black);
    strokeWeight(5);
    circle(x, y, 20);
    line(x, y, x+dx*50, y+dy*50);
  }
}
