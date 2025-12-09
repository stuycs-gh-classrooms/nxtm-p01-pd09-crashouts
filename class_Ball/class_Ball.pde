class Balls {
  //instance variables
  int xcor, ycor;
  int xspeed, yspeed;
  int ballSize;
  PVector middle;
  boolean moving;

  void Ball(int x, int y, int s)
  {
    ballSize = s;
    x = int(random(ballSize/2, width - ballSize/2));
    y = int(random(ballSize/2, height - ballSize/2));
    xspeed = 5;
    yspeed = 5;
  }

  void setup() {
    size(600, 400);
    ballSize = 100;
    moving = true;
  }
  void display() {
    circle (xcor, ycor, ballSize);
    fill (0);
  }
}

void move(int x, int y, int xspeed, int yspeed, int ballSize)
{
  if (y >= height - ballSize/2 ||
    y <= ballSize/2) {
    yspeed *= -1;
  }//up/down bounce

  if (x >= width - ballSize/2 ||
    x <= ballSize/2) {
    xspeed *= -1;
  }//left/right bounce

  if (x == 0 && y == 0 ) {
    xspeed *= -1;
    yspeed *= -1;
    y+= yspeed;
    x+= xspeed;
  }
}
