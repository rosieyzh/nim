/***********************************************************
 *                    THE GAME OF NIM                      *
 * Created by Rosie Zhao, Ran Tao, Yao Liu, and Marcel Goh *
 *                  of McGill University                   *
 *          for ConUHacks IV (26-27 January 2019)          *
 ***********************************************************
 */

/* GLOBAL VARIABLES */
Game g;
int chosenRow;         // restricts player to a specific row once chosen
boolean menuScreen;    // are we on the menu screen?
boolean playersTurn;   // is it the player's turn?
boolean cpuEnabled;    // enable AI player
PImage quit;
PImage reset;
PImage confirm;
PImage playerOn;
PImage playerOff;
PImage cpuOn;
PImage cpuOff;
PImage canvas;
PFont titleFont;
PFont menuFont;

void setup() {
  /* initialize game variables */
  chosenRow = -1;
  playersTurn = true;
  menuScreen = false;

  /* load images */
  quit = loadImage("quit.png");
  reset = loadImage("reset.png");
  confirm = loadImage("confirm.png");
  playerOn = loadImage("player_on.png");
  playerOff = loadImage("player_off.png");
  cpuOn = loadImage("cpu_on.png");
  cpuOff = loadImage("cpu_off.png");
  canvas = loadImage("background.png");

  /* load fonts */
  titleFont = loadFont("MunroSmall-172.vlw");

  g = new Game(11,16);
  size(600, 450);
  background(0);
  noStroke();
  fill(102);
  noLoop();         // game does not automatically loop
}

void mousePressed() {
  if (playersTurn) {
    /* check if any doughnuts are clicked */
    for (int i=0; i<g.numRows; ++i) {
      int numItems = g.minItems + i;
      for (int j=0; j<numItems; ++j) {
        Item currItem = g.itemMatrix[i][j];
        if ((mouseX >= currItem.x) && (mouseX < currItem.x + currItem.width) &&
            (mouseY >= currItem.y) && (mouseY < currItem.y + currItem.height)) {
          if (chosenRow == -1 || chosenRow == i) {
            currItem.clicked = true;
            --g.table[i];
            chosenRow = i;
          }
          break;
        }
      }
    }

    /* check if done button clicked */
    if ((mouseX >= 250) && (mouseX < 350) && (mouseY >= 410) && (mouseY < 450)) {
      chosenRow = -1;
      g.cpuNormalMove();
    }
  }

  /* check if quit button clicked */
  if ((mouseX >= 550) && (mouseX < 600) && (mouseY >= 430) && (mouseY < 450)) {
    // TODO: ADD QUIT BEHAVIOUR
  }

  /* check if reset button clicked */
  if ((mouseX >= 500) && (mouseX < 550) && (mouseY >= 430) && (mouseY < 450)) {
    g = new Game(g.minItems,g.maxItems);
    playersTurn = true;
    chosenRow = -1;
  }

  /* update the screen */
  redraw();
}

void draw() {
  background(0);
  image(canvas, 0, 0, 600, 450);
  //CURRENTLY BROKEN
  if (menuScreen) {
    fill(255);
    textAlign(CENTER);
    textFont(titleFont);
    text("NIM", 300, 125, 400, 150);
    textFont(menuFont);
    //text("PUZZLE SIZE:  3  5  7  11", 300, 175, 400, 200);
    //text("NUMBER OF ROWS:  3  4  5  6", 300, 225, 400, 350);
  } else {
    /* draw doughnuts */
    g.display();

    /* draw buttons */
    image(quit, 550, 430, 50, 20);  // quit button
    image(reset, 500, 430, 50, 20);  // reset button
    image(confirm, 250, 410, 100, 40);   // confirm button

    /* draw player/CPU icons */
    if (playersTurn) {
      image(playerOn, 0, 0, 100, 40);
      image(cpuOff, 527, 0, 100, 40);
    } else {
      image(playerOff, 0, 0, 100, 40);
      image(cpuOn, 527, 0, 100, 40);
    }

    //TESTTTTTT
    for (int i=0; i<g.numRows; ++i) {
      print(g.table[i]+" ");
    }
    println();
    //ENDTESTTTTT
  }

}
