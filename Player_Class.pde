class Player extends Pieces {

  Player (int column, int row) {
    super(column, row);
  }

  void spawnIn (int [][] grid) { //draws the ellipses
    for (int r = 0; r < 8; r++) {
      for (int c = 0; c < 8; c++) {
        if (grid[c][r] == 4 || grid[c][r] == 5 || grid[c][r] == 7 || grid[c][r] == 9) {
          drawBlack(50 + c * width/8, 50 + r * height/8);
        }
      }
    }
  }

  void findBorder (int [][] grid, int state, int borderState) { //draws selected border around tile mouse is in
    int gridx = int(mouseX/100); //find the grid square
    int gridy = int(mouseY/100);
    for (int r = 0; r < 8; r++) {
      for (int c = 0; c < 8; c++) {
        while (grid[c][r] == borderState) grid[c][r] = state;
      }
    }
    if (grid[gridx][gridy] == state) {
      grid[gridx][gridy] = borderState;
    }
  }

  void drawBorder (int[][] grid, int borderState) { //draws the border around the selected tiles
    for (int r = 0; r < 8; r++) {
      for (int c = 0; c < 8; c++) {
        if (grid[c][r] == borderState) {
          fill (255);
          noStroke();
          rect(newX * width/8, newY * height/8, width/8, height/128);
          rect(newX * width/8, (100 - height/128) + newY * height/8, width/8, height/128);
          rect(newX * width/8, newY * height/8, width/128, height/8);
          rect((100 - width/128) + newX * width/8, newY * height/8, width/128, height/8);
          stroke(3);
        }
      }
    }
  }

  boolean validMove() { //checks if players move is valid
    if (newX + 2 > oldX && newY + 2 > oldY && newX - 2 < oldX && newY -2 < oldY) {
      if (newY < oldY) {
        return true;
      }
    }
    return false;
  }

  void shiftToSpot (int [][] grid, int state) { //shifts the position of the pieces if move is valid
    if (playPiece.validMove() == true) {
      if (grid[newX][newY] != 0 && grid[newX][newY] != 3 && grid[newX][newY] != 8 && grid[newX][newY] != 4 && grid[oldX][oldY] != 7 && grid[oldX][oldY] != 9 && grid[oldX][oldY] != -1) {
        if (playerTurn == true) {
          grid[oldX][oldY] = 1;
          grid[newX][newY] = state;
          resetTurn();
        }
      }
    }
  }

  void crownPlayPiece (int [][] grid) { //draws the crowned pieces
    for (int r = 0; r < 8; r++) {
      for (int c = 0; c < 8; c++) {
        if (grid[c][0] == 4 || grid[c][0] == 5) {
          grid[c][0] = 7;
        }
        if (grid[c][r] == 7 || grid[c][r] == 9) {
          image(crown, 13 + c * width/8, 10 + r * height/8, 75, 75);
        }
      }
    }
  }

  boolean elimCheck (int [][]grid, int state) { //eliminates computer piece and jumps over them
    if (playPiece.validMove() == true) {
      if (grid[newX][newY] != 0 && grid[newX][newY] != 1 && grid[newX][newY] != 4 && grid[newX][newY] != 7  && grid[oldX][oldY] != -1 && grid[oldX][oldY] != 9 && grid[oldX][oldY] != 7 ) {
        if (playerTurn == true) {
          if (newX + 1 < 8 && newY + 1 < 8) {
            if (newY != 0 && newX != 0 && newX != 7) {
              if (grid[abs(newX - 1)][abs(newY  - 1)] == 1) {
                if (newX < oldX && newY < oldY) {
                  grid[abs(newX - 1)][abs(newY  - 1)] = state;
                  grid[newX][newY] = 1;
                  grid[oldX][oldY] = 1;
                  comps--;
                  resetTurn();
                  return true;
                }
              }
              if (grid[newX + 1][abs(newY  - 1)] == 1) {
                if (newX > oldX && newY < oldY) {
                  grid[newX + 1][abs(newY  - 1)] = state;
                  grid[newX][newY] = 1;
                  grid[oldX][oldY] = 1;
                  comps--;
                  resetTurn();
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

  void resetTurn () { //resets the turn after players move
    playerTurn = false;
    oldX = -1;
    oldY = -1;
    newX = -1;
    newY= -1;
  }

  boolean gottaJump(int grid[][]) {
    for (int c = 0; c<8; c++) {
      for (int r = 0; r<8; r++) {
        for (int dc = 0; dc<8; dc++) {
          for (int dr = 0; dr<8; dr++) {
            if (grid[c][r] == 4) {
              if (grid[dc][dr] == 3 || grid[dc][dr] == 8) {
                if (playPiece.checkJumps(TilesW, c, dc, r, dr) == true) {
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

  boolean checkJumps (int grid[][], int oldX, int newX, int oldY, int newY) {
    if (newX + 2 > oldX && newY + 2 > oldY && newX - 2 < oldX && newY - 2 < oldY) {
      if (newY < oldY) {
        if (grid[newX][newY] != 0 && grid[newX][newY] != 1 && grid[newX][newY] != 4 && grid[oldX][oldY] != -1) {
          if (playerTurn == true) {
            if (newX + 1 < 8 && newY + 1 < 8) {
              if (newX + 1 >= 0 && newY + 1 >= 0) {
                if (grid[abs(newX - 1)][abs(newY  - 1)] == 1) {
                  if (newX < oldX && newY < oldY) {
                    return true;
                  }
                }
                if (grid[newX + 1][abs(newY - 1)] == 1) {
                  if (newX > oldX && newY < oldY) {
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

  boolean gottaJumpKing(int grid[][]) {
    for (int c = 0; c<8; c++) {
      for (int r = 0; r<8; r++) {
        for (int dc = 0; dc<8; dc++) {
          for (int dr = 0; dr<8; dr++) {
            if (grid[c][r] == 7) {
              if (grid[dc][dr] == 3 || grid[dc][dr] == 8) {
                if (playPiece.checkJumpsKing(TilesW, c, dc, r, dr) == true) {
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

  boolean checkJumpsKing (int grid[][], int oldX, int newX, int oldY, int newY) {
    if (newX + 2 > oldX && newY + 2 > oldY && newX - 2 < oldX && newY - 2 < oldY) {
      if (grid[newX][newY] != 0 && grid[newX][newY] != 1 && grid[newX][newY] != 4 && grid[oldX][oldY] != -1) {
        if (playerTurn == true) {
          if (newX + 1 < 8 && newY + 1 < 8) {
            if (newX + 1 >= 0 && newY + 1 >= 0) {
              if (grid[newX + 1][newY  + 1] == 1) {
                if (newX > oldX && newY > oldY) {
                  return true;
                }
              }
              if (grid[abs(newX - 1)][abs(newY  + 1)] == 1) {
                if (newX < oldX && newY > oldY) {
                  return true;
                }
              }
              if (grid[abs(newX - 1)][abs(newY  - 1)] == 1) {
                if (newX < oldX && newY < oldY) {
                  return true;
                }
              }
              if (grid[newX + 1][abs(newY  - 1)] == 1) {
                if (newX > oldX && newY < oldY) {
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

  boolean validMoveKing() { //checks if players move is valid
    if (newX + 2 > oldX && newY + 2 > oldY && newX - 2 < oldX && newY -2 < oldY) {
      if (newY > oldY || oldY > newY) {
        return true;
      }
    }
    return false;
  }

  void shiftToSpotKing (int [][] grid, int state) { //shifts the position of the pieces if move is valid
    if (playPiece.validMoveKing() == true) {
      if (grid[newX][newY] != 0 && grid[newX][newY] != 3 && grid[newX][newY] != 8 && grid[newX][newY] != 4 && grid[oldX][oldY] != 7 && grid[oldX][oldY] != -1 && grid[oldX][oldY] == 9) {
        if (playerTurn == true) {
          grid[oldX][oldY] = 1;
          grid[newX][newY] = state;
          resetTurn();
        }
      }
    }
  }

  boolean elimCheckKing (int [][]grid, int state) { //eliminates computer piece and jumps over them
    if (playPiece.validMoveKing() == true) {
      if (grid[newX][newY] != 0 && grid[newX][newY] != 1 && grid[newX][newY] != 4 && grid[newX][newY] != 7 && grid[newX][newY] != 9 && grid[newX][newY] != 7  && grid[oldX][oldY] != -1 && grid[oldX][oldY] != 4 && grid[oldX][oldY] != 5) {
        if (playerTurn == true) {
          if (newX + 1 < 8 && newY + 1 < 8) {
            if (newY != 0 && newX != 0 && newX != 7) {
              if (grid[newX + 1][newY  + 1] == 1) {
                if (newX > oldX && newY > oldY) {
                  grid[newX + 1][newY  + 1] = state;
                  grid[newX][newY] = 1;
                  grid[oldX][oldY] = 1;
                  comps--;
                  resetTurn();
                  return true;
                }
              }
              if (grid[abs(newX - 1)][abs(newY  - 1)] == 1) {
                if (newX < oldX && newY < oldY) {
                  grid[abs(newX - 1)][abs(newY  - 1)] = state;
                  grid[newX][newY] = 1;
                  grid[oldX][oldY] = 1;
                  comps--;
                  resetTurn();
                  return true;
                }
              }
              if (grid[newX + 1][abs(newY  - 1)] == 1) {
                if (newX > oldX && newY < oldY) {
                  grid[newX + 1][abs(newY  - 1)] = state;
                  grid[newX][newY] = 1;
                  grid[oldX][oldY] = 1;
                  comps--;
                  resetTurn();
                  return true;
                }
              }
              if (grid[abs(newX - 1)][newY  + 1] == 1) {
                if (newX < oldX && newY > oldY) {
                  grid[abs(newX - 1)][newY  + 1] = state;
                  grid[newX][newY] = 1;
                  grid[oldX][oldY] = 1;
                  comps--;
                  resetTurn();
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
}
