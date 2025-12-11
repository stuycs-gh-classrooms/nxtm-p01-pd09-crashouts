// Ball.pde (updated)

class Ball {
  float x, y;
  float xspeed, yspeed;
  float r;

  Ball(float x, float y, float xs, float ys, float r) {
    this.x = x;
    this.y = y;
    this.xspeed = xs;
    this.yspeed = ys;
    this.r = r;
  }

  void move() {
    x += xspeed;
    y += yspeed;

    // wall bounce
    if (x < r || x > width - r) {
      xspeed *= -1;
    }
    if (y < r) {
      yspeed *= -1;
    }
  }

  void display() {
    fill(255);
    ellipse(x, y, r * 2, r * 2);
  }

  void reset() {
    x = width/2;
    y = height/2;
    xspeed = 5;
    yspeed = -5;
  }
}
