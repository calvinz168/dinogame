import processing.sound.*;
SoundFile file;

float cactus1X = 1280;
int cactus1Y = 400;
float cactus2X = 1280;
int cactus2Y = 400;
int cactus1W = 100;
int playerY = 400;
int direction = 1;
float posx, posy, vely, g;
float cactusSpeed = -4;
boolean can_jump = false;
boolean cactus = true;
PImage dino;
PImage cactus1;
boolean bruh = false;

void setup() {
  size(1280, 600);
  background(245);
  frameRate(120);
  smooth();
  file = new SoundFile(this, "Bruh Sound Effect #2.mp3");

  dino = loadImage("dinoboy.png");
  cactus1 = loadImage("cactusboi.png");

  g = 0.3;
  vely = 0;  
  posx = 300;
  posy = 400;
}

void draw() {

  int timeyy = round(millis()*0.01);
  background(245);
  line(0, 500, 1280, 500);
  fill(0);
  textSize(20);
  text(timeyy, width/2-10, 200);
  cactus();

  if ((bruh) && (!file.isPlaying())) {
    file.play();
  }

  //jump
  vely+=g;
  posy+=vely;
  player();

  if ( posy > 400 ) {
    posy = 400;
    vely = 0;
    can_jump = true;
  }
  
  //collision with cactus
  if ((posx + 50 > cactus1X) && (posx < cactus1X) && (posy <= cactus1Y) && (posy + 100 >= cactus1Y) || (posx+50 > cactus1X + 50) && (posx < cactus1X+50) && (posy <= cactus1Y) && (posy +100 >= cactus1Y)) {
    fill(0);
    textSize(32);
    text("bruh", 600, 100);
    bruh = true;
    exit();
    print("Score = ", timeyy);
  } else if ((posx + 50 > cactus2X) && (posx < cactus2X) && (posy <= cactus2Y) && (posy + 100 >= cactus2Y) || (posx+50 > cactus2X + 100) && (posx < cactus2X+100) && (posy <= cactus2Y) && (posy +100 >= cactus2Y)) {
    fill(0);
    textSize(32);
    text("bruh", 600, 100);
    bruh = true; 
    exit();
    print("Score = ", timeyy);
  } else {
    bruh = false;
  }

  //once cactus goes past the left side of the screen
  if ((cactus1X < - 50) || (cactus2X < - 100)) {
    cactus1X = 1280 + random(2000);
    cactus2X = 1280 + random(2000);
    cactus = !cactus;
    cactusSpeed = cactusSpeed - 1;
  }
  image(dino, posx, posy, 70, 100);
  image(cactus1, cactus1X, cactus1Y, 50, 100);

  image(cactus1, cactus2X, cactus2Y, 50, 100);
  image(cactus1, cactus2X + 50, cactus2Y, 50, 100);
}

void keyPressed() {
  if (( key == ' ') && ( can_jump )) {
    vely = -10;
    can_jump = false;
  }
}

void player() {
  noFill();
  noStroke();
  rect(posx, posy, 50, 100);
  stroke(5);
}

void cactus() {
  if (!cactus) {
    fill(245);
    noStroke();   
    rect(cactus2X += cactusSpeed, cactus2Y, 100, 100);
    stroke(5);
    
  } else {
    image(cactus1, cactus1X, cactus1Y, 50, 100);
    fill(245);
    noStroke();
    rect(cactus1X += cactusSpeed, cactus1Y, 50, 100);
    stroke(5);
  }
}
//spaghet
