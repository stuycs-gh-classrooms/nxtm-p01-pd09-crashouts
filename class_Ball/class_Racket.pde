class Racket {
  float x, y, w, h;


  Racket(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }


  void update() {
    x = mouseX - w/2;
    y = height - 60; // fixed below UI and near bottom
  }


  void display() {
    fill(255);
    rect(x, y, w, h);
  }
}

