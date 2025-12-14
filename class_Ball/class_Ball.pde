class Ball {
  float x, y;
  float xspeed, yspeed;
  float r;

  Ball(float x, float y, float xs, float ys, float r) {
    this.x = random (0, width);
    this.y = random (300, 680);
    this.xspeed = xs;
    this.yspeed = ys;
    this.r = r;
  }

  void move() {
    x += xspeed;
    y += yspeed;

    // bounce off walls
    if (x < r || x > width - r) xspeed *= -1;
    if (y < 100) yspeed *= -1;
  }

  void display() {
    fill(255);
    ellipse(x, y, r * 2, r * 2);
  }

  void reset() {
    x = 300;
    y = 700;
    xspeed = 5;
    yspeed = -5;
  }
}
