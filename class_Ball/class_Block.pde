class Block {
  float x, y, w, h;
  boolean broken = false;

  Block(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  void display() {
    if (!broken) {
      fill(255, 150, 0);
      rect(x, y, w, h);
    }
  }

  boolean checkCollision(Ball b) {
    if (!broken && b.x + b.r > x && b.x - b.r < x + w && b.y + b.r > y && b.y - b.r < y + h) {
      broken = true;
      return true;
    }
    return false;
  }
}
