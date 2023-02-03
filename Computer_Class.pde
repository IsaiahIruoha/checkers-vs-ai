class Computer extends Pieces {

  Computer (int column, int row) {
    super(column, row);
  }
  void spawnIn (int [][] grid) { //draws the ellipses
    for (int r = 0; r < 8; r++) {
      for (int c = 0; c < 8; c++) {
        if (grid[c][r] == 3 || grid[c][r] == 8) {
          drawRed(50 + c * width/8, 50 + r * height/8);
        }
      }
    }
  }

  boolean validMove() {
    if (compX2 + 2 > compX1 && compY2 + 2 > compY1 && compX2 -2 < compX1 && compY2 -2 < compY1) {
      if (compY2 > compY1) {
        return true;
      }
    }
    return false;
  }

  boolean validMoveKing() {
    if (compX2 + 2 > compX1 && compY2 + 2 > compY1 && compX2 -2 < compX1 && compY2 -2 < compY1) {
      if (compY2 < compY1 || compY2 > compY1) {
        return true;
      }
    }
    return false;
  }

  void crownCompPiece (int [][] grid) { //draws the crowned pieces
    for (int r = 0; r < 8; r++) {
      for (int c = 0; c < 8; c++) {
        if (grid[c][7] == 3) {
          grid[c][7] = 8;
        }
        if (grid[c][r] == 8) {
          image(crown, 13 + c * width/8, 10 + r * height/8, 75, 75);
        }
      }
    }
  }

  boolean gottaJump(int grid[][]) {
    for (int c = 0; c<8; c++) {
      for (int r = 0; r<8; r++) {
        for (int dc = 0; dc<8; dc++) {
          for (int dr = 0; dr<8; dr++) {
            if (grid[c][r] == 3) {
              if (grid[dc][dr] == 4 || grid[dc][dr] == 7) {
                if (dc > 0 && dr > 0 && dr < 7 && dc < 7) {
                  if (compPiece.checkJumps(TilesW, c, dc, r, dr) == true) {
                    return true;
                  }
                }
              }
            }
          }
        }
      }
    }
    return false;
  }

  boolean checkJumps (int grid[][], int oldX, int newX, int oldY, int newY) {

    if (newX + 2 > oldX && newY + 2 > oldY && newX - 2 < oldX && newY - 2 < oldY) {
      if (newY > oldY) {
        if (grid[newX][newY] != 0 && grid[newX][newY] != 1 && grid[newX][newY] != 3 && grid[newX][newY] != 8 && grid[oldX][oldY] != -1) {
          if (newX + 1 < 8 && newY + 1 < 8) {
            if (newX + 1 >= 0 && newY + 1 >= 0) {
              if (oldX == newX) playerTurn = true;
              if (grid[newX + 1][newY  + 1] == 1) {
                if (newX > oldX && newY > oldY) {
                  compX1 = oldX;
                  compX2 = newX + 1;
                  compY1 = oldY;
                  compY2 = newY + 1;
                  elimX = newX;
                  elimY = newY;
                  return true;
                }
              }
              if (grid[abs(newX - 1)][abs(newY  + 1)] == 1) {
                if (newX < oldX && newY > oldY) {
                  compX1 = oldX;
                  compX2 = abs(newX - 1);
                  compY1 = oldY;
                  compY2 = abs(newY + 1);
                  elimX = newX;
                  elimY = newY;
                  return true;
                }
              }
            }
          }
        }
      }
    }
    return false;
  }

  boolean gottaJumpKing(int grid[][]) {
    for (int c = 0; c<8; c++) {
      for (int r = 0; r<8; r++) {
        for (int dc = 0; dc<8; dc++) {
          for (int dr = 0; dr<8; dr++) {
            if (grid[c][r] == 8) {
              if (grid[dc][dr] == 4 || grid[dc][dr] == 7) {
                if (dc > 0 && dr > 0 && dr < 7 && dc < 7) {
                  if (compPiece.checkJumpsKing(TilesW, c, dc, r, dr) == true) {
                    return true;
                  }
                }
              }
            }
          }
        }
      }
    }
    return false;
  }

  boolean checkJumpsKing (int grid[][], int oldX, int newX, int oldY, int newY) {
    if (newX + 2 > oldX && newY + 2 > oldY && newX - 2 < oldX && newY - 2 < oldY) {
      if (grid[newX][newY] != 0 && grid[newX][newY] != 1 && grid[newX][newY] != 3 && grid[newX][newY] != 8 && grid[oldX][oldY] != -1) {
        if (newX + 1 < 8 && newY + 1 < 8) {
          if (newX + 1 >= 0 && newY + 1 >= 0) {
            if (oldX == newX) playerTurn = true;
            if (grid[abs(newX - 1)][abs(newY  - 1)] == 1) {
              if (newX < oldX && newY < oldY) {
                compX1 = oldX;
                compX2 = abs(newX - 1);
                compY1 = oldY;
                compY2 = abs(newY - 1);
                elimX = newX;
                elimY = newY;
                return true;
              }
            }
            if (grid[abs(newX - 1)][newY + 1] == 1) {
              if (newX < oldX && newY > oldY) {
                compX1 = oldX;
                compX2 = abs(newX - 1);
                compY1 = oldY;
                compY2 = newY + 1;
                elimX = newX;
                elimY = newY;
                return true;
              }
            }
            if (grid[newX + 1][newY + 1] == 1) {
              if (newX < oldX && newY < oldY) {
                compX1 = oldX;
                compX2 = newX + 1;
                compY1 = oldY;
                compY2 = newY + 1;
                elimX = newX;
                elimY = newY;
                return true;
              }
            }
            if (grid[newX + 1][abs(newY - 1)] == 1) {
              if (newX > oldX && newY < oldY) {
                compX1 = oldX;
                compX2 = newX + 1;
                compY1 = oldY;
                compY2 = abs(newY - 1);
                elimX = newX;
                elimY = newY;
                return true;
              }
            }
          }
        }
      }
    }
    return false;
  }
}
