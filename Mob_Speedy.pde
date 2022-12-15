class SpeedyMob extends Mob {
  SpeedyMob(float _x, float _y, float _vx, float _vy) {
    super(_x, _y, _vx, _vy);
    d = 60;
    maxhp = 5 + waveNumber;
    hp = maxhp;
    value = 3;
    speed = 2;
    image = mob3;
  }
}
