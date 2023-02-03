class Pieces {
  int c;
  int r;
  int x;
  int y;

  Pieces (int column, int row) {
    this.c = column;
    this.r = row;
    this.x = 100;
    this.y = 100;
  }

  boolean clicking () { //if the mouse hovers over the button then return boolean value
    return dist(mouseX, mouseY, this.x, this.y) < 37.5;
  }
  void markSpawns (int [][]grid) { //marks the ellipses spots
    for (int r = 0; r < 2; r++) {
      for (int c = 0; c < 4; c++) {
        grid[(150 + c * width*2/8) / 100][ (550 + r * height*2/8) / 100] = 4;
        grid[(50 + c * width*2/8) / 100][ (50 + r * height*2/8) / 100] = 3;
      }
    }
    for (int r = 0; r < 1; r++) {
      for (int c = 0; c < 4; c++) {
        grid[(50 + c * width*2/8) / 100][ (650 + r * height*2/8) / 100] = 4;
        grid[(150 + c * width*2/8) / 100][ (150 + r * height*2/8) / 100] = 3;
      }
    }
  }
}
