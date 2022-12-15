void speed() {
  drawMap();
  animateThings();
  drawSpeedInterface();
  RoundMoneyLives();
  fasterAnimations();

  //speed animations
  if (mobs.size() == 0) {
    int i = 0;
    while (i < towers.size()) {
      Tower myTower = towers.get(i);
      if (myTower.towerType == GUN) myTower.threshold = 30;
      if (myTower.towerType == AOE) myTower.threshold = 60;
      if (myTower.towerType == TANK) myTower.threshold = 50;
      i++;
    }
    mode = PLAY;
  }
}


void drawSpeedInterface() {
  noStroke();
  fill(66, 53, 141);
  strokeWeight(0);
  rect(500, 700, 1000, 200);

  counter++;

  if (counter <= 18) {
    textFont(font2);
    textSize(65);
    fill(green);
    text("SPEEDY MODE", 322, 682);
    fill(white);
    text("SPEEDY MODE", 318, 678);
  } else if (counter > 18) {
    if (counter ==  30) counter = 0;
  }
}


void fasterAnimations() {
  int i = 0;

  //Make mobs fast
  while (i < mobs.size()) {
    Mob myMob = mobs.get(i);
    if (myMob.value == 1) myMob.speed = 2;
    if (myMob.value == 3) myMob.speed = 4;
    if (myMob.value == 5) myMob.speed = 1;
    i++;
  }

  ////Make bullets fast
  //i = 0;
  //while (i < bullets.size()) {
  //  Bullet myBullet = bullets.get(i);
  //  myBullet.speed = 2;
  //  i++;
  //}

  //Make tank & aoe fast
  i = 0;
  while (i < towers.size()) {
    Tower myTower = towers.get(i);
    if (myTower.towerType == GUN) myTower.threshold = 15;
    if (myTower.towerType == AOE) myTower.threshold = 30;
    if (myTower.towerType == TANK) myTower.threshold = 25;
    i++;
  }
}
