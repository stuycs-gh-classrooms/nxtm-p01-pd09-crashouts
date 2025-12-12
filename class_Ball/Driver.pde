Ball ball; // the ball object
Racket racket; // the player paddle
Block[][] blocks; // 2D array of blocks
int rows = 5;
int cols = 10;
int score = 0;
int lives = 3;
float level = 1;
float r;
float g;
float b;
boolean paused = false;
boolean gameOver = false;

void setup() {
  size(600, 700);
  initLevel(); //  first level
}

void draw() {
  background(0);

  // Draw the UI at the top of the screen
  r = random (0, 255);
  g = random (0, 255);
  b = random (0, 255);
  fill(r, g, b);
  textSize(20);
  textAlign(LEFT);
  text("Score: " + score, 20, 30);
  text("Lives: " + lives, 20, 60);
  text("Level: " + level, 20, 90);

  if (paused || gameOver) {
    fill(255);
    textSize(32);
    textAlign(CENTER);
    if (gameOver) text("GAME OVER - Press R", width/2, height/2);
    else text("PAUSED", width/2, height/2);
    return;
  }

  // Update and draw the paddle
  racket.update();
  racket.display();

  // Move and draw the ball
  ball.move();
  ball.display();

  // Check collision between ball and paddle
  if (ball.y + ball.r >= racket.y
    && ball.x > racket.x
    && ball.x < racket.x + racket.w)
  {
    ball.yspeed *= -1; // reverse vertical direction
    // this is what we wanted (somewhat) as the extra feature: change horizontal speed based on where it hit the paddle
    float hitPos = (ball.x - (racket.x + racket.w/2)) / (racket.w/2);
    ball.xspeed = hitPos * 5;
  }

  // Ball falls below paddle = lose life
  if (ball.y > height) {
    lives--;
    if (lives <= 0) gameOver = true; // game over if no lives left
    else ball.reset(); // reset ball if lives remain
  }

  int pts[] = {50, 40, 30, 20, 10}; // points for each row

  // Check collisions with blocks
  for (int r = 0; r < rows; r++) {
    for (int c = 0; c < cols; c++) {
      Block b = blocks[r][c];
      if (!b.broken && b.checkCollision(ball)) {
        b.broken = true; // mark block as destroyed
        ball.yspeed *= -1; // bounce ball
        score += pts[b.row]; // add points
      }
      b.display(); // draw block
    }
  }

  // Check if all blocks are broken -> level up
  if (allBroken()) {
    level++;
    ball.reset();
    initLevel();
    while (level == 2) {
      background(r, g, b);
    }
  }
}

// Initialize or reset the level
void initLevel() {
  float ballSpeed = 5 + level * 1.5; // ball speed increases with level
  ball = new Ball(width/2, 300, ballSpeed, -ballSpeed, 10);

  float racketWidth = max(40, 100 - level * 5); // paddle shrinks as level increases, min width 40
  racket = new Racket(width/2 - racketWidth/2, height - 60, racketWidth, 15);

  // Create blocks
  blocks = new Block[rows][cols];
  float bw = width / cols;
  float bh = 25;

  color[] rowColors = {
    color(255, 0, 0), // 50 pts
    color(255, 165, 0), // 40 pts
    color(255, 255, 0), // 30 pts
    color(0, 200, 0), // 20 pts
    color(0, 150, 255)  // 10 pts
  };

  for (int r = 0; r < rows; r++) {
    for (int c = 0; c < cols; c++) {
      // position blocks below the top UI
      blocks[r][c] = new Block(c * bw, r * bh + 120, bw - 2, bh - 2, rowColors[r], r);
    }
  }
}

// Check if all blocks are destroyed
boolean allBroken() {
  for (int r = 0; r < rows; r++) {
    for (int c = 0; c < cols; c++) {
      if (!blocks[r][c].broken) return false;
    }
  }
  return true;
}

// Keyboard controls
void keyPressed() {
  if (key == 'p') paused = !paused; // pause/unpause
  if (key == 'r') { // reset game
    score = 0;
    lives = 3;
    level = 1;
    gameOver = false;
    paused = false;
    initLevel();
  }
}
