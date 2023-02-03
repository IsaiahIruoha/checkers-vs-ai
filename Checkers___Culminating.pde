
/*
 cr = 0, invalid square, out of bounds
 cr = 1, default, all tiles start here
 cr = 2,
 cr = 3, computer piece
 cr = 4, player piece
 cr = 5, currently selected
 cr = 6, killed
 cr = 7, crowned Player
 cr = 8, crowned computer
 cr = 9, selected crowned Player
 */

int [][] TilesW = new int[8][8]; //grid created
Computer compPiece; //comptuter pieces created
Player playPiece; //player pieces created
boolean selected; //boolean for if a player piece is selected
int oldX, oldY; //used to store locations of pieces
int newX, newY;
boolean playerTurn; //player turn true/false
int compX1, compX2;
int compY1, compY2;
int elimX, elimY;
PImage crown; //image for crown when a piece is kinged
int compKing; //decides which piece moves when a king and a normal computer piece exist
int gameState; //game screens
Button retry1, retry2, exit1, exit2, retry3, exit3;  //button class for retry, exit on win and lose screen
int comps, players; //counts the amount of players and amount of enemies remaining

void setup () {
  size(800, 800); //screen resolution set
  compPiece = new Computer (5, 5); //computer class declared, used more for storage of functions
  playPiece = new Player (5, 5);  //player piece class declared, used more for storage of functions
  selected = true;
  oldX = -1;
  oldY = -1;
  newX = -1;
  newY = -1;
  playerTurn = true;
  crown = loadImage("crown.png");
  compKing = 0;
  gameState = 0;
  retry1 = new Button(width/2 - 225/2, 375, 225, 60, 30, "Retry");
  retry2 = new Button(width/2 - 225/2, 375, 225, 60, 30, "Retry");
  exit1 = new Button(width/2 - 225/2, 450, 225, 60, 30, "Exit");
  exit2 = new Button(width/2 - 225/2, 450, 225, 60, 30, "Exit");
  comps = 12;
  players = 12;

  for (int r = 0; r < 8; r++) { //sets all squares to 1 by default
    for (int c = 0; c < 8; c++) {
      TilesW[c][r] = 1;
    }
  }
  compPiece.markSpawns(TilesW); //changes the computer pieces to a value of 3
  playPiece.markSpawns(TilesW); //changes the player pieces to a value of 4
  markInvalid(TilesW); //marks the squares where no player can more (0)
}

void draw () {
  cursor(HAND); //sets cursor to hand
  for (int r = 0; r < 4; r++) { //colours the grid background
    for (int c = 0; c < 4; c++) {
      fill(#e3c099);
      rect( c * width*2/8, 100 + r * height*2/8, width/8, height/8);
      rect(100+ c * width*2/8, r * height*2/8, width/8, height/8);
      fill(#c38452);
      rect( c * width*2/8, r * height*2/8, width/8, height/8);
      rect(100 + c * width*2/8, 100 + r * height*2/8, width/8, height/8);
    }
  }

  compPiece.spawnIn(TilesW);  //spawns in the initial red pieces
  playPiece.spawnIn(TilesW);  //spawns in the initial black pieces
  if (gameState == 0) {
    playPiece.drawBorder(TilesW, 5);
    playPiece.drawBorder(TilesW, 9);
    playPiece.crownPlayPiece(TilesW); //crown the player piece
    compPiece.crownCompPiece(TilesW); //crown the computer piece
    playPiece.gottaJump(TilesW); //checks available jumps
    playPiece.gottaJumpKing(TilesW); //checks available jumps
  }
  if (gameState == 1) {
    fill(0, 150);
    rect(250, 250, 300, 300, 8);
    textSize(55);
    fill(#FF3131);
    text("Game Lost", width/2 - textWidth("Game Over")/2, height / 2 - 65);
    exit1.sketch(); //exit class
    retry1.sketch(); //retry class
  }
  if (gameState == 2) {
    fill(0, 150);
    rect(250, 250, 300, 300, 8);
    textSize(55);
    fill(#39FF14);
    text("Game Won", width/2 - textWidth("Game Over")/2, height / 2 - 65);
    exit2.sketch(); //exit class
    retry2.sketch(); //retry class
  }

  if (players <= 0) gameState = 1;
  if (comps <= 0) gameState = 2;
}

void drawRed (int x, int y) { //function for drawing red pieces
  fill(255, 0, 0);
  ellipse(x, y, 75, 75);
}

void drawBlack (int x, int y) { //function for drawing white pieces
  fill(0);
  ellipse(x, y, 75, 75);
}

void markInvalid (int [][]grid) { //marks the squares that are invalid/out of bounds
  for (int r = 0; r < 4; r++) {
    for (int c = 0; c < 4; c++) {
      grid[(c * width / 4) / 100][ (100+  r * height / 4) / 100] = 0;
      grid[( 100 + c * width / 4) / 100][ (r * height / 4) / 100] = 0;
    }
  }
}

void reset() { //function to reset the program

  gameState = 0;
  selected = true;
  oldX = -1;
  oldY = -1;
  newX = -1;
  newY = -1;
  playerTurn = true;
  compKing = 0;
  gameState = 0;
  comps = 12;
  players = 12;
  for (int r = 0; r < 8; r++) { //sets all squares to 1 by default
    for (int c = 0; c < 8; c++) {
      TilesW[c][r] = 1;
    }
  }
  compPiece.markSpawns(TilesW); //changes the computer pieces to a value of 3
  playPiece.markSpawns(TilesW); //changes the player pieces to a value of 4
  markInvalid(TilesW);
}
