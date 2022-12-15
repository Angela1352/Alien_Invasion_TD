boolean broke = false;
int counter1 = 0;

void build() {
  noTint();
  drawMap();
  drawBuildInterface();
  animateThings();
  buildModeText();
  RoundMoneyLives();
  tint(255, 180);
  handleHover();
  handleBuildClicks();
  noTint();
}


void buildModeText() {
  counter++;

  if (counter <= 18) {
    textFont(font2);
    textSize(110);
    fill(66, 53, 141);
    text("BUILD MODE", 504, 142);
    fill(white);
    text("BUILD MODE", 496, 138);
  } else if (counter > 18) {
    if (counter ==  30) counter = 0;
  }
}


void drawBuildInterface() {
  noStroke();
  fill(66, 53, 141);
  strokeWeight(0);
  rect(500, 700, 1000, 200);

  fill(white);
  textFont(font2);
  textSize(20);
  play.show();
  buyGun.show();
  buyTank.show();
  buyAoE.show();

  fill(white);
  textSize(25);
  text("GUN", 242, 640);
  text("TANK", 382, 640);
  text("AOE", 524, 640);
}


void handleHover() {
  fill(white);
  textFont(font2);
  textSize(50);

  //GUN
  if (mouseX > 190 && mouseX < 290 && mouseY > 665 && mouseY < 765) {
    image(hover, 500, 400, 800, 350);
    image(hover, 220, 400, 200, 310);
    text("~ GUN TOWER ~", 602, 262);
    fill(drkPrpl);
    text("~ GUN TOWER ~", 598, 260);
    noTint();
    image(gunTower, 220, 400, 150, 300);

    fill(black);
    textSize(35);
    text("COST: $5", 602, 310);
    fill(red);
    text("COST: $5", 598, 310);
    fill(black);
    text("DAMAGE: -1 hp", 602, 340);
    fill(red);
    text("DAMAGE: -1 hp", 598, 340);

    fill(black);
    textSize(26);
    text("The gun tower shoots", 605, 410);
    text("four bullets, one in", 605, 450);
    text("each direction.", 605, 490);
  }

  //AOE
  if (mouseX > 470 && mouseX < 570 && mouseY > 665 && mouseY < 765) {
    image(hover, 500, 400, 800, 350);
    image(hover, 220, 400, 200, 310);
    text("~ AOE TOWER ~", 602, 262);
    fill(drkPrpl);
    text("~ AOE TOWER ~", 598, 260);
    noTint();
    image(aoeTower, 220, 400, 150, 300);

    fill(black);
    textSize(35);
    text("COST: $20", 602, 310);
    fill(red);
    text("COST: $20", 598, 310);
    fill(black);
    text("DAMAGE: -3 hp", 602, 340);
    fill(red);
    text("DAMAGE: -3 hp", 598, 340);

    fill(black);
    textSize(26);
    text("The AoE tower places an", 605, 410);
    text("electric ring that deals", 605, 450);
    text("damage to all mobs inside.", 605, 490);
  }

  //TANK
  if (mouseX > 330 && mouseX < 430 && mouseY > 665 && mouseY < 765) {
    image(hover, 500, 400, 800, 350);
    image(hover, 720, 470, 320, 170);
    text("~ TANK TOWER ~", 502, 262);
    fill(drkPrpl);
    text("~ TANK TOWER ~", 498, 260);
    noTint();
    image(tankTower, 720, 470, 300, 150);

    fill(black);
    textSize(35);
    text("COST: $10", 502, 310);
    fill(red);
    text("COST: $10", 498, 310);
    fill(black);
    text("DAMAGE: -2 hp", 502, 340);
    fill(red);
    text("DAMAGE: -2 hp", 498, 340);

    fill(black);
    textSize(26);
    text("The tank tower", 330, 400);
    text(" automatically targets ", 330, 440);
    text("and damages the first", 330, 480);
    text("mob that appears.", 330, 520);
  }
}


void handleBuildClicks() {
  fill(white);
  textFont(font2);
  textSize(25);
  text("Back", 102, 640);

  if (play.clicked) {
    mode = PLAY;
  }

  if (buyGun.clicked) {
    if (money >= 5) {
      if (towers.size() == 0 || towers.get(towers.size()-1).towerMode != PLACING) {
        towers.add(new Tower(GUN));
        money -= 5;
      }
    }
    if (money < 5) {
      broke = true;
      noMoney.rewind();
      noMoney.play();
    }
  }

  if (buyTank.clicked) {
    if (money >= 10) {
      if (towers.size() == 0 || towers.get(towers.size()-1).towerMode != PLACING) {
        towers.add(new Tower(TANK));
        money -= 10;
      }
    }
    if (money < 10) {
      broke = true;
      noMoney.rewind();
      noMoney.play();
    }
  }

  if (buyAoE.clicked) {
    if (money >= 20) {
      if (towers.size() == 0 || towers.get(towers.size()-1).towerMode != PLACING) {
        towers.add(new Tower(AOE));
        money -= 20;
      }
    }
    if (money < 20) {
      broke = true;
      noMoney.rewind();
      noMoney.play();
    }
  }

  if (broke == true) needMoney();
}


void needMoney() {
  counter1++;
  textFont(font2);
  textSize(40);

  if (counter1 <= 5) fill(red);
  else if (counter1 > 5 && counter1 <= 10) fill(white);
  else if (counter1 > 10 && counter1 <= 15) fill(red);
  else if (counter1 > 15 && counter1 <= 20) fill(white);
  else if (counter1 > 20) {
    broke = false;
    counter1 = 0;
  }
  text("MONEY: $", 763, 695);
  text(money, 920, 695);
}
