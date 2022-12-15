float angle = 0;

void intro() {
  theme.play();
  tint(255, 130);
  gifBkg.show();

  //Gif
  noTint();
  gifOne.show();
  if (gifOne.x < 1300) {
    gifOne.x = gifOne.x + 10;
  }

  if (gifOne.x == 1300) {
    gifOne.x = -200;
  }

  //Start button
  textFont(font1);
  textSize(45);
  start.show();
  if (start.clicked) mode = MAPS;

  //Alien Invasion text
  textSize(130 + 25*sin(angle));
  angle = angle + 0.2;
  fill(black);
  text("ALIEN", 497, 243);
  text("INVASION", 497, 423);
  fill(green);
  text("ALIEN", 503, 237);
  text("INVASION", 503, 417);
}
