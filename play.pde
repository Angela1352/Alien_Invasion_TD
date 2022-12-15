void play() {

  drawMap();
  animateThings();
  drawPlayInterface();
  handleButtonClicks();
  RoundMoneyLives();
  //temporaryNodes();
}


void drawMap() {
  if (map == 1) {
    image(mapStars, 500, 300, 1000, 700);

    //pathway
    stroke(#B4A7D6);
    strokeWeight(40);
    line(0, 500, 300, 500);
    line(300, 500, 300, 300);
    line(300, 300, 100, 300);
    line(100, 300, 100, 100);
    line(100, 100, 800, 100);
    line(800, 100, 800, 350);
    line(800, 350, 450, 350);
    line(450, 350, 450, 200);
    line(450, 200, 600, 200);
    line(600, 200, 600, 500);
    line(600, 500, 1000, 500);
  }

  if (map == 2) {
    image(mapPlanets, 400, 250, 1200, 700);

    //pathway
    stroke(purple);
    strokeWeight(40);
    line(0, 500, 900, 500);
    line(900, 500, 900, 100);
    line(900, 100, 100, 100);
    line(100, 100, 100, 400);
    line(100, 400, 750, 400);
    line(750, 400, 750, 200);
    line(750, 200, 250, 200);
    line(250, 200, 250, 300);
    line(250, 300, 1000, 300);
  }
}


void animateThings() {
  int i = 0;
  while (i < mobs.size()) {
    Mob myMob = mobs.get(i);
    myMob.act();
    myMob.show();
    if (myMob.hp <= 0) {
      mobs.remove(i);
      money += 1;
    } else if (myMob.x >= 1020) {
      fill(red, 100);
      rect(500, 300, 1000, 700);
      lives--;
      hit.rewind();
      hit.play();
      mobs.remove(i);
    } else {
      i++;
    }
  }

  i = 0;
  while (i < bullets.size()) {
    Bullet myBullet = bullets.get(i);
    myBullet.act();
    myBullet.show();

    if (myBullet.hp <= 0) {
      bullets.remove(i);
    } else {
      i++;
    }
  }

  i = 0;
  while (i < towers.size()) {
    Tower myTower = towers.get(i);
    myTower.show();
    if (mobs.size() != 0 && myTower.towerMode == PLACED) myTower.act();
    i++;
  }
}


void drawPlayInterface() {
  noStroke();
  fill(66, 53, 141);
  strokeWeight(0);
  rect(500, 700, 1000, 200);

  fill(white);
  textFont(font2);
  textSize(25);
  text("PLAY", 104, 640);
  nextWave.show();
  textFont(font2);
  textSize(25);
  fill(white);
  text("BUILD", 244, 640);
  text("SPEED", 384, 640);
  build.show();
  speedUp.show();
}


void handleButtonClicks() {

  if (nextWave.clicked && mobs.size() == 0) {
    addWave();
    waveNumber++;
  }

  if (build.clicked && mobs.size() == 0) mode = BUILD;

  if (speedUp.clicked && mobs.size() != 0) mode = SPEED;
}


void addWave() {
  int i = 0;
  int x = 0;

  while (i <= waveNumber) {
    mobs.add(new Mob(x, 500, 1, 0));
    i++;
    x -= 100;
  }

  if (waveNumber % 3 == 0) {
    i = 0;
    x = -50;
    while (i < waveNumber/3) {
      mobs.add(new ChonkyMob(x, 500, 1, 0));
      x = x - 200;
      i++;
    }
  }

  if (waveNumber % 2 == 0) {
    i = 0;
    x = -100;
    while (i < waveNumber/4) {
      mobs.add(new SpeedyMob(x, 500, 1, 0));
      x = x - 250;
      i++;
    }
  }
}


void RoundMoneyLives() {
  int livesX, livesY, livesS;

  livesX = 820;
  livesY = 755;
  livesS = 40;

  fill(magenta);
  noStroke();
  rect(805, 700, 360, 170);

  if (lives == 3) {
    image(heart, livesX, livesY, livesS+20, livesS);
    image(heart, livesX+50, livesY, livesS+20, livesS);
    image(heart, livesX+100, livesY, livesS+20, livesS);
  } else if (lives == 2) {
    image(heart, livesX, livesY, livesS+20, livesS);
    image(heart, livesX+50, livesY, livesS+20, livesS);
  } else if (lives == 1) {
    image(heart, livesX, livesY, livesS+20, livesS);
  } else if (lives <= 0) {
    mode = GAMEOVER;
    gameover.rewind();
    gameover.play();
  }

  fill(white);
  textFont(font2);
  textSize(40);
  text("LIVES:", 719, 753);
  text("ROUND: ", 745, 640);
  text(waveNumber, 865, 640);
  text("MONEY: $", 763, 695);
  text(money, 920, 695);
}


void temporaryNodes() {
  int i = 0;
  if (map == 1) {
    while (i < 10) {
      map1nodes[i].show();
      i++;
    }
  } else if (map == 2) {

    while (i < 8) {
      map2nodes[i].show();
      i++;
    }
  }
}
