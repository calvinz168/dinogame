import processing.sound.*;            
SoundFile file;
PImage earth;                      //earth picture
PImage moon;                       //moon picture
PImage asteroid2;                  //scene 2 asteroid picture
PImage stars;                      //stars in scene1
PImage trex;                       //trex picture
PImage spritesheet = loadImage("https://i.pinimg.com/originals/b2/f3/02/b2f30283fe843fcccf12118afe2d9a57.png");
int DIM = 2;
int W = spritesheet.width/DIM;
int H = spritesheet.height/DIM;
int actionCounter = 0;             //counter for actions, scenes
boolean scene1pics = true;         //if scene 1 is active
boolean scene2 = false;            //if scene 2 is active
boolean soundtesterame = false;    //tests if sound is currently playing, if it is, it wont stack
int pixelbois = 10;                //pixelation thing for scene 2
boolean scene2pics = false;        //if scene 2 pics are acrtive
//-------------------------------------------------------------------------------
float cactus1X = 1280;             //x position for cactus 1
int cactus1Y = 400;                //y position for cactus 1
float cactus2X = 1280;             //x position for cactus 2
int cactus2Y = 400;                //y position for cactus 2
int cactus1W = 100;                //width of cactus 1
int playerY = 400;                 //y position of player(trex)
int direction = 1;                 //direction of cactus
float posx, posy, vely, g;         //for proper gravityand jump
float cactusSpeed = -4;            //speed of cactus
boolean can_jump = false;          //so cant double jump
boolean cactus = true;             //which cactus
PImage dino;                       //picture of dino
PImage cactus1;                    //picture of cactuses
boolean bruh = false;              //for sound
int start;

void setup() {
  size(1280, 800);

  frameRate(60);
  smooth();
  earth     = loadImage("earth.jpg");
  moon      = loadImage("moon.jpg");
  asteroid2 = loadImage("scene2asteroid.jpg");
  stars     = loadImage("stars.png");
  dino      = loadImage("dinoboy.png");
  cactus1   = loadImage("cactusboi.png");
  file      = new SoundFile(this, "Dinosaur roar.mp3");

  g = 0.3;
  vely = 0;  
  posx = 300;
  posy = 400;
}

void draw() {
  background(0);

  int x = frameCount%DIM*W;
  int y = frameCount/DIM%DIM*H;
  PImage sprite = spritesheet.get(x, y, W, H); 
  surface.setLocation(displayWidth/2-width/2, displayHeight-height * 2);
  // println(mouseX, mouseY);

  //doesnt draws scene1 pictures if its not scene 1
  if (actionCounter >1) {
    scene1pics = false;
  }
  //tests if sound is playing; if it is, it doesnt play again; so it doesnt stack
  if (file.isPlaying()) {
    soundtesterame = true;
  } else {
    soundtesterame = false;
  }

  //collision detection with the earth and the asteroid
  if ((actionCounter >= 2)  && (actionCounter <= 4)|| (actionCounter == 1) && (mouseX >= 450) && (mouseX < 850) && (mouseY >= 182) && (mouseY <= 569)) {
    actionCounter = 3;
    background(0);
    image(asteroid2, 0, 0, 1280, 600);
    image(sprite, 914, 220, 75, 75);
    text("click on the dinosaurs for a roar", width/2-200, 650);
    text("press ENTER to transform", width/2-150, 700);
    text(actionCounter, 1200, 550);
  }

  //pixellation
  if ((key == ENTER) && (actionCounter >= 3)) {
    pixelbois += 10;
    for (int i = 0; i < 1280; i = i + pixelbois) {
      for (int l = 0; l < 1280; l = l + pixelbois) {

        color c = get(i+pixelbois, l+pixelbois);
        fill(c);
        noStroke();
        rect(i + 10, l, pixelbois, pixelbois);
        rect(-10, i, pixelbois, pixelbois);

        fill(255);
        text("now press space to transform and run from the asteroid", width/2-500, 400);
        // text(pixelbois, width/2-150,500);
        start = millis();
      }
    }
  }
  //game-------------------------------------------------------------------------------------------------------------------------------------------------------------------
  if (key == ' ') {
    if((mousePressed) && (!soundtesterame)){
      file.play();
    }
    int ms = round((millis() - start)*0.01);

    actionCounter = 20;
    pixelbois =1;

    background(245);
    fill(0);

    line(0, 500, 1280, 500);
    fill(0);
    textSize(20);
    text(ms, 600, 200);
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
    if ((posx + 70 > cactus1X) && (posx < cactus1X) && (posy <= cactus1Y) && (posy + 100 >= cactus1Y) || (posx+70 > cactus1X + 50) && (posx < cactus1X+50) && (posy <= cactus1Y) && (posy +100 >= cactus1Y)) {
      fill(0);
      textSize(32);
      text("bruh", 600, 100);
      bruh = true;
      exit();
      print("Score = ", ms);
    } else if ((posx + 70 > cactus2X) && (posx < cactus2X) && (posy <= cactus2Y) && (posy + 100 >= cactus2Y) || (posx+70 > cactus2X + 100) && (posx < cactus2X+100) && (posy <= cactus2Y) && (posy +100 >= cactus2Y)) {
      fill(0);
      textSize(32);
      text("bruh", 600, 100);
      bruh = true; 
      exit();
      print("Score = ", ms);
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

  //end of game----------------------------------------------------------------------------------------------------------------------------------------------------------------------

  //test if mouse click on dinosaur for dino roar
  if ((mousePressed) && (!soundtesterame) && (actionCounter >= 2) && (mouseX >= 652) && (mouseX <=791) && (mouseY >= 265) && (mouseY <= 344) || (mousePressed) && (!soundtesterame) && (actionCounter >= 2) && (mouseX > 452) && (mouseX < 722) && (mouseY > 333) && (mouseY < 580) || (mousePressed) && (!soundtesterame) && (actionCounter >=2) && (mouseX >= 837) && (mouseX <= 1184) && (mouseY > 412) && (mouseY < 538) || (mousePressed) && (!soundtesterame) && (actionCounter >=2) && (mouseX >=642) && (mouseX <=751) && (mouseY > 428) && (mouseY < 502)) {
    file.play();
    actionCounter -=1;
  }
  if (actionCounter == 1) {
    text("now finna hit the earth with that asteroid", width/2-300, 700);
  }
  //this is the drawing part and procedures
  if (actionCounter <= 2) {
    scene1();
  }
  if (actionCounter == 1) {
    image(sprite, mouseX -50, mouseY - 50);
  }
}

void scene1() {

  if (scene1pics == true) {
    image(moon, 100, 100, 100, 100);
    image(earth, 400, 150, 500, 450);
    image(stars, 0, 0, 1280, 600);

    textSize(32);
    fill(255);

    text("space", width/2-50, 50);
    text("click outside the earth to spawn an asteroid", width/2-300, 650);
  } else {
    text(actionCounter, 1200, 550);
  }
}

void mousePressed() {
  actionCounter += 1;
}
void keyPressed() {
  if (( key == ' ') && ( can_jump )) {
    vely = -10;
    can_jump = false;
  }
  if (key == 'p') {
    pixelbois +=10;
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
