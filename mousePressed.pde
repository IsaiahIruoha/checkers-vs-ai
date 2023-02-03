
void mousePressed () {
  if (gameState == 0) {
    if (oldX == -1 && oldY == -1) { //if positions are in defautl state then run
      if (newX == -1 && newY == -1) {
        newX = mouseX/100;
        newY = mouseY/100;
      }
      oldX = newX;
      oldY = newY;
      newX = mouseX/100;
      newY = mouseY/100;

      if (TilesW[oldX][oldY] == 1 && TilesW[newX][newY] == 1 ) { //if the tile selected is a free tile, do not allow it to move
        oldX = -1;
        oldY = -1;
        newX = -1;
        newY= -1;
      }
    } else { //if a position has been found then run the shifting function and then reset variables
      if (TilesW[oldX][oldY] == 4 || TilesW[oldX][oldY] == 5 && TilesW[newX][newY] == 5 || TilesW[newX][newY] == 4 || TilesW[oldX][oldY] == 7 || TilesW[oldX][oldY] == 9 && TilesW[newX][newY] == 9 || TilesW[newX][newY] == 7 ) { //if the tile selected is the wrong state, do not allow it to move, relocate the new tile
        oldX = newX;
        oldY = newY;
      }

      if (TilesW[oldX][oldY] == 4 || TilesW[oldX][oldY] == 5 && TilesW[newX][newY] == 1 || TilesW[newX][newY] == 3 || TilesW[newX][newY] == 8) {
        newX = mouseX/100;
        newY = mouseY/100;
        oldX = newX;
        oldY = newY;
      }
      if (TilesW[oldX][oldY] == 7 || TilesW[oldX][oldY] == 9 && TilesW[newX][newY] == 1 || TilesW[newX][newY] == 3 || TilesW[newX][newY] == 8 ) {
        newX = mouseX/100;
        newY = mouseY/100;
        oldX = newX;
        oldY = newY;
      }
      if (TilesW[oldX][oldY] == 1 && TilesW[newX][newY] == 1 || TilesW[oldX][oldY] == 0 && TilesW[newX][newY] == 0) { //if the tile selected is the wrong state, do not allow it to move, relocate the new tile
        newX = mouseX/100;
        newY = mouseY/100;
        oldX = newX;
        oldY = newY;
      }
      newX = mouseX/100;
      newY = mouseY/100;
      playPiece.elimCheck(TilesW, 4);
      if (playPiece.elimCheck(TilesW, 4) == false) playPiece.elimCheckKing(TilesW, 7);
      if (playPiece.elimCheck(TilesW, 4) == false && playPiece.elimCheckKing(TilesW, 7) == false && playPiece.gottaJump(TilesW) == false && playPiece.gottaJumpKing(TilesW) == false) {
        playPiece.shiftToSpot (TilesW, 4);
        playPiece.shiftToSpotKing (TilesW, 7);
      }
    }

    playPiece.findBorder(TilesW, 4, 5); //function that checks each mousePressed for a tile that qualifies for a border (selected)
    playPiece.findBorder(TilesW, 7, 9); //function that checks each mousePressed for a tile that qualifies for a border (selected)

    if (playerTurn == false) {
      if (compPiece.gottaJump(TilesW) == false && compPiece.gottaJumpKing(TilesW) == false) { //add the other gotta jump
        for (int r = 0; r < 8; r++) {
          for (int c = 0; c < 8; c++) {
            if (TilesW[c][r] == 8) {
              compKing = floor(random(2));
              break;
            }
          }
        }

        if (compKing == 1) {
          if (comps > 0 && players > 0) {
            compX1 = floor(random(8));
            compX2 = floor(random(8));
            compY1 = floor(random(8));
            compY2 = floor(random(8));

            while (TilesW[compX1][compY1] != 8 || TilesW[compX2][compY2] != 1 || compPiece.validMoveKing() == false) {
              compX1 = floor(random(8));
              compX2 = floor(random(8));
              compY1 = floor(random(8));
              compY2 = floor(random(8));
            }
            TilesW[compX1][compY1] = 1;
            TilesW[compX2][compY2] = 8;
            playerTurn = true;
          }
        }

        if (compKing == 0) {
          if (comps > 0 && players > 0) {
            compX1 = floor(random(8));
            compX2 = floor(random(8));
            compY1 = floor(random(8));
            compY2 = floor(random(8));
            while (TilesW[compX1][compY1] != 3 || TilesW[compX2][compY2] != 1 || compPiece.validMove() == false) { //valid move check
              compX1 = floor(random(8));
              compX2 = floor(random(8));
              compY1 = floor(random(8));
              compY2 = floor(random(8));
            }
            TilesW[compX1][compY1] = 1;
            TilesW[compX2][compY2] = 3;
            playerTurn = true;
          }
        }
      } else if (compPiece.gottaJump(TilesW) == true) {
        if (compX2 < 8 && compY2 < 8) {
          if (elimY != 0 && elimX != 0) {
            TilesW[compX1][compY1] = 1;
            TilesW[compX2][compY2] = 3;
            TilesW[elimX][elimY] = 1;
            players--;
            compX1 = 0;
            compX2 = 0;
            compY1 = 0;
            compY2 = 0;
            elimX = 0;
            elimY = 0;
            playerTurn = true;
          }
        }
      } else if (compPiece.gottaJumpKing(TilesW) == true) {
        if (compX2 < 8 && compY2 < 8) {
          if (elimY != 0 && elimX != 0) {
            TilesW[compX1][compY1] = 1;
            TilesW[compX2][compY2] = 8;
            TilesW[elimX][elimY] = 1;
            players--;
            compX1 = 0;
            compX2 = 0;
            compY1 = 0;
            compY2 = 0;
            elimX = 0;
            elimY = 0;
            playerTurn = true;
          }
        }
      }
    }
  }
  if (gameState == 1) {
    if (exit1.clicking()) {  //exit button (start screen)
      exit();
    }
    if (retry1.clicking()) { //retry button (win screen)
      reset();
    }
  }
  if (gameState == 2) {
    if (exit2.clicking()) {  //exit button (start screen)
      exit();
    }
    if (retry2.clicking()) { //retry button (win screen)
      reset();
    }
  }
}
