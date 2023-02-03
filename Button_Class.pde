class Button extends Clicked { //button class extending the clicked class

  String text;
  int textSize;

  Button (float x, float y, float w, float h, int size, String message) { //provides the button parameters
    super(x, y, w, h);
    this.text = message;
    this.textSize = size;
  }

  void sketch () { //draws the button and makes use of the click function created in the Clicked super class
    if (this.clicking()) {
      noStroke();
      fill(150, 150);
    } else {
      noStroke();
      fill(0, 0);
    }
    rect(this.x, this.y, this.w, this.h, 8);
    textSize(this.textSize);
    fill(255);
    text(this.text, this.x + this.w/ 2 - textWidth(this.text)/ 2, this.y + 38);
    stroke(1);
  }
}

class Clicked {

  float x, y, w, h;
  Clicked (float x1, float y1, float w1, float h1) { //parameters for clicked class
    this.x = x1;
    this.y = y1;
    this.w = w1;
    this.h = h1;
  }

  boolean clicking () { //if the mouse hovers over the button then return boolean value
    return mouseX > this.x && mouseX < this.x + this.w && mouseY > this.y && mouseY < this.y + this.h;
  }
}
