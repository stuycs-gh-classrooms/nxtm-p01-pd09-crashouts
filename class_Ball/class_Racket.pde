class Racket {
  float x, y, w, h;

  Racket(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  void update() {
    x = constrain(mouseX - w/2, 0, width - w);
  }

  void display() {
    fill(255);
    rect(x, y, w, h);
  }
}
