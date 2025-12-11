Ball ball;
Racket racket;
Block[][] blocks;
int rows = 5;
int cols = 10;
int score = 0;
int lives = 3;
int level = 1;
boolean paused = false;
boolean gameOver = false;

void setup() {
  size(600, 700); // larger canvas to fit UI
}

void draw() {
  background(0);

  // UI
  fill(255);
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

  racket.update();
  racket.display();

  ball.move();
  ball.display();

  // paddle collision
  if (ball.y + ball.r >= racket.y 
  && ball.x > racket.x 
  && ball.x < racket.x + racket.w) {
    ball.yspeed *= -1;
  }

  // bottom collision = lose life
  if (ball.y > height) {
    lives--;
    if (lives <= 0) gameOver = true;
    else ball.reset();
  }

  int pts[] = {50, 40, 30, 20, 10};

  // block collisions
  for (int r = 0; r < rows; r++) {
    for (int c = 0; c < cols; c++) {
      Block b = blocks[r][c];
      if (!b.broken && b.checkCollision(ball)) {
        b.broken = true;
        ball.yspeed *= -1;
        score += pts[b.row];
      }
      b.display();
    }
  }
}



void initLevel() {
  blocks = new Block[rows][cols];
  float bh = 25;
  float bw = width/ cols ;
  color [] rowColors = {
    color (255, 255, 0),
    color (0, 255, 0),
    color (0, 0, 255),
    color (255, 165, 0),
    color (255, 0, 0)
  };
  for (int r = 0; r < rows; r++) {
    for (int c = 0; c < cols; c++) {
      blocks[r][c] = new Block(c * bw, r * bh + 120, bw - 2, bh - 2, rowColors[r], r);
    }
  }
}


 boolean allBroken() {
  for (int r = 0; r < rows; r++) {
    for (int c = 0; c < cols; c++) {
      if (!blocks[r][c].broken) return false;
    }
  }
  return true;
} 

void keyPressed() {
  if (key == 'p') paused = !paused;
  if (key == 'r') {
    score = 0;
    lives = 3;
    level = 1;
    gameOver = false;
    paused = false;
    initLevel();
  }
}
