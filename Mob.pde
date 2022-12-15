class Mob {

  float x, y, vx, vy, d;
  float hp, maxhp;
  PImage pic, image;
  int value;
  float speed;

  Mob (float _x, float _y, float _vx, float _vy) {
    x  = _x;
    y  = _y;
    vx = _vx;
    vy = _vy;
    d = 60;
    value = 1;
    maxhp = 5;
    hp = maxhp;
    speed = 1;
    pic = image;
    image = mob1;
  }


  void show() {
    image(image, x, y, d, d);
    healthbar();
  }


  void act() {
    x = x + 5*vx*speed; // keep as 5 ------------------------------------------------------
    y = y + 5*vy*speed;

    int i = 0;

    if (map == 1) {
      while (i < map1nodes.length) {
        if (dist(map1nodes[i].x, map1nodes[i].y, x, y) < 10) {
          vx = map1nodes[i].dx;
          vy = map1nodes[i].dy;
        }
        i++;
      }
    } else if (map == 2) {
      while (i < map2nodes.length) {
        if (dist(map2nodes[i].x, map2nodes[i].y, x, y) < 10) {
          vx = map2nodes[i].dx;
          vy = map2nodes[i].dy;
        }
        i++;
      }
    }

    i = 0;
    while (i < bullets.size()) {
      Bullet myBullet = bullets.get(i);
      if (dist(myBullet.x, myBullet.y, x, y) < d/2 + myBullet.d/2) {
        hp--;
        bullets.remove(myBullet);
      }
      i++;
    }
  }


  void healthbar() {
    rectMode(CORNER);
    noStroke();
    fill(100);
    rect(x-24, y-(d)+6, 50, 20);
    fill(red);
    rect(x-22, y-(d)+8, 46, 16);
    fill(green);
    rect(x-22, y-(d)+8, hp*46/maxhp, 16);
    rectMode(CENTER);
  }
}
