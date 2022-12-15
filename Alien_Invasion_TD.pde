//TO DO:
//SPEED MODE: FIX AOE CIRCLE

//FIX: COOLDOWN FOR AOE IS NOT TOGETHER


//Tower Defense Game
//Angela Chen
//Programming 12

//MUSIC
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

// ================ GLOBAL VARIABLES =================

final int INTRO    = 0;
final int MAPS     = 1;
final int PLAY     = 2;
final int BUILD    = 3;
final int GAMEOVER = 4;
final int SPEED    = 5;
int mode;
int map;

//Tower types
final int GUN    = 0;
final int AOE    = 1;
final int TANK   = 2;

//Pallette
color white    = #ffffff;
color black    = #000000;
color purple1  = #9999FF;
color magenta  = #AF7AC5;
color blue     = #6A6AFF;
color purple   = #b388eb;
color green    = #6ddf39;
color drkPrpl  = #5D195D;
color red      = #FF0000;

//Mouse & Keyboard interaction variables
boolean mouseReleased;
boolean wasPressed;

//Buttons
Button start, map1, map2, nextWave, build, play;
Button buyGun, buyTank, buyAoE, speedUp, again;


//Collections of objects
Node[] nodes, map1nodes, map2nodes;
ArrayList<Mob> mobs;
ArrayList<Tower> towers;
ArrayList<Bullet> bullets;
ArrayList<AoE_Ring> ring;

//Images and Gifs
Gif gifOne, gifBkg, gifTwo;
int shipX = -150;
PImage mapStars, mapPlanets;
PImage playIcon, buildIcon, backIcon, gunIcon, tankIcon, AoEIcon, map1Icon, map2Icon, speedIcon;
PImage heart, plainRed, hover;
PImage mob1, mob2, mob3, gunTower, tankTower, aoeTower;

//Fonts
PFont font1, font2;

//Sound Effects
Minim minim;
AudioPlayer theme, hit, gameover, click, noMoney;

//BUILD
final int PLACING = 0;
final int PLACED  = 1;

//Others
int waveNumber, counter, begin; //numberOfMobs
int lives, money;


// ===================== SETUP =========================

void setup() {
  rectMode(CENTER);
  imageMode(CENTER);
  textAlign(CENTER, CENTER);
  size(1000, 800);
  initializeModes();
  initializeVariables();
  makeButtons();
  makeNodes();
}

void initializeModes() {
  //set up the default mode for things
  rectMode(CENTER);
  imageMode(CENTER);
  textAlign(CENTER, CENTER);
  mode = INTRO;
}

void initializeVariables() {
  //Load Images & Gifs
  gifBkg = new Gif("gifBkg/gifBkg(", ").gif", 41, 3, 600, 400, 1400, height);
  gifOne = new Gif("gifOne/gifOne(", ").gif", 24, 1, 200, 80, width/3, height/5);
  gifTwo = new Gif("gifTwo/gifTwo", ".gif", 5, 2, 500, 360, width, height);

  mapStars   = loadImage("photos/mapStars.jpg");
  mapPlanets = loadImage("photos/mapPlanets.jpg");

  map1Icon   = loadImage("photos/map1.png");
  map2Icon   = loadImage("photos/map2.png");
  playIcon   = loadImage("photos/playPhoto.png");
  buildIcon  = loadImage("photos/build.png");
  backIcon   = loadImage("photos/back.png");
  gunIcon    = loadImage("photos/gun.png");
  tankIcon   = loadImage("photos/tank.png");
  AoEIcon    = loadImage("photos/aoe.png");
  speedIcon  = loadImage("photos/speed.png");

  plainRed   = loadImage("photos/plainRed.jpg");
  hover      = loadImage("photos/hover.jpg");

  heart = loadImage("photos/heart.png");
  mob1  = loadImage("photos/mob1.png");
  mob2  = loadImage("photos/mob2.png");
  mob3  = loadImage("photos/mob3.png");

  gunTower  = loadImage("photos/gunTower.png");
  tankTower = loadImage("photos/tankTower.png");
  aoeTower  = loadImage("photos/aoeTower.png");

  //Load Fonts
  font1 = createFont("fonts/font1.ttf", 100);
  font2 = createFont("fonts/font2.ttf", 100);

  //Create Collections of Objects
  mobs    = new ArrayList<Mob>();
  towers  = new ArrayList<Tower>();
  bullets = new ArrayList<Bullet>();
  ring    = new ArrayList<AoE_Ring>();

  //Sound Effects
  minim    = new Minim(this);
  theme    = minim.loadFile("theme.mp3");
  hit      = minim.loadFile("hit.mp3");
  gameover = minim.loadFile("gameover.mp3");
  click    = minim.loadFile("click.mp3");
  noMoney  = minim.loadFile("broke.mp3");

  //Others
  waveNumber   = 0;
  lives        = 3;
  money        = 20;
  counter      = 0;
}

void makeButtons() {
  //INTRO - Start
  start = new Button("START", width/2, 625, 200, 100, purple, white);

  //MAPS - Choose Map
  map1 = new Button("1", 250, 430, 400, 400, magenta, purple1);
  map2 = new Button("2", 750, 430, 400, 400, magenta, purple1);

  //PLAY - Next Wave, To Build Mode
  nextWave = new Button(playIcon, 100, 715, 100, 100, magenta, purple1);
  build    = new Button(buildIcon, 240, 715, 100, 100, magenta, purple1);
  speedUp  = new Button(speedIcon, 380, 715, 100, 100, magenta, purple1);

  //BUILD - To play mode, Buy Sniper, Buy Gun, Buy AoE
  play     = new Button(backIcon, 100, 715, 100, 100, magenta, purple1);
  buyGun   = new Button(gunIcon, 240, 715, 100, 100, magenta, purple1);
  buyTank  = new Button(tankIcon, 380, 715, 100, 100, magenta, purple1);
  buyAoE   = new Button(AoEIcon, 520, 715, 100, 100, magenta, purple1);

  //GAMEOVER - Reset
  again = new Button("AGAIN", width/2, 625, 200, 100, purple, white);
}

void makeNodes() {
  //MAP 1
  map1nodes = new Node[10];

  map1nodes[0] = new Node(300, 500, 0, -1);
  map1nodes[1] = new Node(300, 300, -1, 0);
  map1nodes[2] = new Node(100, 300, 0, -1);
  map1nodes[3] = new Node(100, 100, 1, 0);
  map1nodes[4] = new Node(800, 100, 0, 1);
  map1nodes[5] = new Node(800, 350, -1, 0);
  map1nodes[6] = new Node(450, 350, 0, -1);
  map1nodes[7] = new Node(450, 200, 1, 0);
  map1nodes[8] = new Node(600, 200, 0, 1);
  map1nodes[9] = new Node(600, 500, 1, 0);

  //MAP 2
  map2nodes = new Node[8];

  map2nodes[0] = new Node(900, 500, 0, -1);
  map2nodes[1] = new Node(900, 100, -1, 0);
  map2nodes[2] = new Node(100, 100, 0, 1);
  map2nodes[3] = new Node(100, 400, 1, 0);
  map2nodes[4] = new Node(750, 400, 0, -1);
  map2nodes[5] = new Node(750, 200, -1, 0);
  map2nodes[6] = new Node(250, 200, 0, 1);
  map2nodes[7] = new Node(250, 300, 1, 0);
}


// ===================== DRAW ===========================

void draw() {
  click();
  if (mode == INTRO) {
    intro();
  } else if (mode == MAPS) {
    maps();
  } else if (mode == PLAY) {
    play();
  } else if (mode == BUILD) {
    build();
  } else if (mode == GAMEOVER) {
    gameOver();
  } else if (mode == SPEED) {
    speed();
  }
}
