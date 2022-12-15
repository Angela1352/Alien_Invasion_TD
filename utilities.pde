void click() {
  mouseReleased = false;
  if (mousePressed) wasPressed = true;
  if (wasPressed && mousePressed == false) {
    mouseReleased = true;
    wasPressed = false;
    click.rewind();
    click.play();
  }
}

void reset() {
  theme.rewind();
  theme.play();
  rectMode(CENTER);
  imageMode(CENTER);
  textAlign(CENTER, CENTER);
  size(1000, 800);

  //Others
  waveNumber   = 0;
  lives        = 3;
  money        = 20;
  counter      = 0;

  //Remove offscreen
  for (int i = 0; i < mobs.size(); i++) mobs.remove(0);
  for (int i = 0; i < bullets.size(); i++) bullets.remove(i);
  for (int i = 0; i < ring.size(); i++) ring.remove(i);
  for (int i = 0; i < towers.size(); i++) towers.remove(0);
}
