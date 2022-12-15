void maps() {
  gifBkg.show();
  map1.show();
  map2.show();
  mapDetails();

  if (map1.clicked) {
    map = 1;
    nodes = map1nodes;
    mode = PLAY;
  }

  if (map2.clicked) {
    map = 2;
    nodes = map2nodes;
    mode = PLAY;
  }
}

void mapDetails() {
  counter++;

  if (counter <= 18) {
    textFont(font2);
    textSize(90);
    fill(66, 53, 141);
    text("SELECT A MAP", 504, 122);
    fill(white);
    text("SELECT A MAP", 496, 118);
  } else if (counter > 15) {
    if (counter ==  30) counter = 0;
  }

  fill(black);
  textSize(50);
  text("SEA OF", 253, 542);
  text("STARS", 253, 592);
  text("RIVER OF", 763, 542);
  text("PLANETS", 763, 592);

  fill(white);
  text("SEA OF", 248, 540);
  text("STARS", 248, 590);
  text("RIVER OF", 758, 540);
  text("PLANETS", 758, 590);

  image(map1Icon, 250, 375, 380, 270);
  image(map2Icon, 750, 375, 380, 270);
}
