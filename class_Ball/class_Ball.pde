class Balls {
  //instance variables
  int xcor, ycor;
  int xspeed, yspeed;
  int ballSize;
  PVector middle;
  
  
  //constructors
  Balls(PVector pos, int is) 
  {
    ballSize = is;
    middle = new PVector (pos.x , pos.y);
  }
  
  boolean blocks(Balls other) {
    return (this.middle.dist(other.middle) <= (this.ballSize/2 + other.ballSize/2);
  }// checks if ball has hit block
    
