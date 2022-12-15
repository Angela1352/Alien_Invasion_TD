class Tower {

  float x, y;
  int cooldown, threshold;
  int towerMode;
  int towerType;
  int counter;
  boolean exists;

  Tower(int type) {
    x = mouseX;
    y = mouseY;
    cooldown = 0;
    exists = false;
    towerMode = PLACING;
    towerType = type;
    if (towerType == GUN) threshold = 30;
    if (towerType == AOE) threshold = 60;
    if (towerType == TANK) threshold = 50;
  }


  void show() {
    checkExists();

    if (towerMode == PLACING) {
      x = mouseX;
      y = mouseY;

      if (exists == true) {
        if (towerType == GUN || towerType == TANK) {
          noStroke();
          fill(red, 150);
          circle(mouseX, mouseY, 150);
        } else if (towerType == AOE) {
          noStroke();
          fill(red, 150);
          circle(mouseX, mouseY, 300);
        }
      } else {
        if (towerType == GUN || towerType == TANK) {
          noStroke();
          fill(white, 150);
          circle(mouseX, mouseY, 150);
        } else if (towerType == AOE) {
          noStroke();
          fill(white, 150);
          circle(mouseX, mouseY, 300);
        }
      }

      if (mouseX > 970 || mouseX < 30 || mouseY < 38 || mouseY > 560) {
        exists = true;
      } else exists = false;

      if (mousePressed && mouseX < 970 && mouseX > 30 && mouseY > 38 && mouseY < 560 && !exists) {
        towerMode = PLACED;
      }
    }

    if (towerType == GUN) showGunTower();
    if (towerType == AOE) showAoETower();
    if (towerType == TANK) showTankTower();
  }


  void checkExists() {
    for (int i = 0; i < towers.size(); i++) {
      Tower myTower = towers.get(i);

      if (myTower.towerMode == PLACED) {

        if (towerType == GUN || towerType == AOE) {
          if (mouseX > myTower.x-50 && mouseX < myTower.x+50 && mouseY > myTower.y-80 && mouseY < myTower.y+80) {
            //strokeWeight(0);
            //fill(white, 30);
            //rect(myTower.x, myTower.y, 100, 160);
            exists = true;
            break;
          } else {
            exists = false;
          }
        } else if (towerType == TANK) {
          if (mouseX > myTower.x-85 && mouseX < myTower.x+85 && mouseY > myTower.y-50 && mouseY < myTower.y+50) {
            //strokeWeight(0);
            //fill(white, 30);
            //rect(myTower.x, myTower.y, 170, 100);
            exists = true;
            break;
          } else {
            exists = false;
          }
        }
      }
    }
  }


  void showGunTower() {
    image(gunTower, x, y, 40, 70);
  }


  void showAoETower() {
    image(aoeTower, x, y, 40, 70);
  }


  void showTankTower() {
    int i = 0;

    image(tankTower, x, y, 80, 50);
    stroke(white);
    strokeWeight(6);

    if (i < mobs.size()) {
      Mob myMob = mobs.get(0);

      if (mode == SPEED && cooldown > 21) stroke(red);
      if (cooldown > 46) stroke(red);
      line(x-23, y-22, myMob.x, myMob.y);
    } else {
      i++;
    }
  }


  void act() {
    //println(cooldown);

    if (towerType == GUN) {
      cooldown++;
      if (cooldown >= threshold) {
        cooldown = 0;

        bullets.add(new Bullet(x, y, 0, -10)); //UP
        bullets.add(new Bullet(x, y, 0, 10)); //DOWN
        bullets.add(new Bullet(x, y, -10, 0)); //LEFT
        bullets.add(new Bullet(x, y, 10, 0)); //RIGHT
      }
    }

    if (towerType == TANK) {
      cooldown++;
      if (cooldown >= threshold) {
        Mob myMob = mobs.get(0);

        if (myMob.hp >= 2) myMob.hp -= 2;
        else if (myMob.hp == 1) myMob.hp--;

        cooldown = 0;
      }
    }


    if (towerType == AOE) {
      if (mode == PLAY) cooldown++;
      else cooldown = 0;

      if (cooldown >= threshold) {
        ring.add(new AoE_Ring(x, y, 300));

        int i = 0;
        while (i < mobs.size()) {
          Mob myMob = mobs.get(i);
          if (dist(x, y, myMob.x, myMob.y) < 150) {

            if (myMob.hp > 2) myMob.hp -= 3;
            else if (myMob.hp == 2) myMob.hp -= 2;
            else if (myMob.hp == 1) myMob.hp--;
          }
          i++;
          cooldown = 0;
        }
      }

      int i = 0;
      if (i < ring.size()) {
        counter++;
        AoE_Ring myRing = ring.get(i);
        myRing.show();
      } else i++;

      if (counter == 8) {
        ring.remove(i);
        counter = 0;
      }
    }
  }
}
