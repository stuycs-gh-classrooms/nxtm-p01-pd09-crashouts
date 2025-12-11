Ball ball;
Racket racket;
Block[][] grid;

int rows = 6;
int cols = 10;
int lives = 3;
boolean paused = false;
boolean gameOver = false;
boolean win = false;

void setup() {
  size(600, 700);
  resetGame();
}

void draw() {
  background(0);

  if (paused) {
    fill(255);
    textAlign(CENTER);
    textSize(32);
    text("PAUSED", width/2, height/2);
    return;
  }

  if (gameOver) {
    fill(255, 50, 50);
    textAlign(CENTER);
    textSize(32);
    text("GAME OVER - Press R to Reset", width/2, height/2);
    return;
  }

  if (win) {
    fill(50, 255, 100);
    textAlign(CENTER);
    textSize(32);
    text("YOU WIN! Press R to Restart", width/2, height/2);
    return;
  }

  // draw racket
  racket.update();
  racket.display();

  // draw and move ball
  ball.move();
  ball.display();

  // check collisions with blocks
  boolean anyLeft = false;
  for (int r = 0; r < rows; r++) {
    for (int c = 0; c < cols; c++) {
      if (!grid[r][c].broken) {
        anyLeft = true;
        if (grid[r][c].checkCollision(ball)) {
          ball.yspeed *= -1;
        }
      }
      grid[r][c].display();
    }
  }

  // win condition
  if (!anyLeft) win = true;

  // check bottom death
  if (ball.y > height) {
    lives--;
    if (lives <= 0) gameOver = true;
    else ball.reset();
  }

  // show lives
  fill(255);
  textSize(18);
  text("Lives: " + lives, 60, 20);
}

void keyPressed() {
  if (key == 'r' || key == 'R') resetGame();
  if (key == ' ') paused = false;
  if (key == ESC) {
    paused = true;
    key = 0;
  }
}

void mouseMoved() {
  racket.x = mouseX - racket.w / 2;
}

void resetGame() {
  // initialize racket and ball
  racket = new Racket(width/2 - 50, height - 80, 100, 15);
  ball = new Ball(width/2, height/2, 5, -5, 12);

  // init grid
  grid = new Block[rows][cols];
  int bw = width / cols;
  int bh = 25;

  for (int r = 0; r < rows; r++) {
    for (int c = 0; c < cols; c++) {
      grid[r][c] = new Block(c * bw, 80 + r * bh, bw - 2, bh - 2);
    }
  }

  lives = 3;
  paused = false;
  gameOver = false;
  win = false;
}
