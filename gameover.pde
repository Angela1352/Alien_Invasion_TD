void gameOver() {
  gifBkg.show();
  gifTwo.show();

  textFont(font1);
  textSize(100 + 25*sin(angle));
  angle = angle + 0.2;
  fill(black);
  text("ALIENS", 497, 223);
  text("ATTACKED", 497, 383);
  fill(red);
  text("ALIENS", 503, 217);
  text("ATTACKED", 503, 377);

  textFont(font2);
  textSize(50);
  fill(black);
  text("ROUNDS SURVIVED:  " + waveNumber, 497, 523);
  fill(white);
  text("ROUNDS SURVIVED:  " + waveNumber, 503, 520);

  //Play again button
  textFont(font1);
  textSize(45);
  again.show();
  if (again.clicked) mode = INTRO;
  reset();
}
