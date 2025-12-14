Ball ball;            
Racket racket;       
Block[][] blocks; 

int rows = 3;
int cols = 3;
int score = 0;
int lives = 3;
int level = 1;       

float r, g, b;       
boolean paused = false;
boolean gameOver = false;
boolean finalLevel = false; // true level 3

void setup() {
  size(600, 700);
  initLevel();
}

void draw() {
  if (finalLevel) {
    r = random(255);
    g = random(255);
    b = random(255);
    background(r, g, b);
  } else {
    background(0);
  }

  if (finalLevel) fill(255 - r, 255 - g, 255 - b);
  else fill(255);

  textSize(20);
  textAlign(LEFT);
  text("Score: " + score, 20, 30);
  text("Lives: " + lives, 20, 60);
  text("Level: " + level, 20, 90);

  // Pause / Game Over
  if (paused || gameOver) {
    fill(255);
    textSize(32);
    textAlign(CENTER);
    if (gameOver) text("GAME OVER - Press R", width/2, height/2);
    else text("PAUSED", width/2, height/2);
    return;
  }

  // Paddle
  racket.update();
  racket.display();

  // Ball
  ball.move();
  ball.display();

  // Ball–paddle collision
  if (ball.y + ball.r >= racket.y &&
      ball.x > racket.x &&
      ball.x < racket.x + racket.w) {

    ball.yspeed *= -1;

    float hitPos = (ball.x - (racket.x + racket.w/2)) / (racket.w/2);
    ball.xspeed = hitPos * (finalLevel ? 9 : 5);
  }

  // Ball falls below paddle
  if (ball.y > height) {
    lives--;

    if (lives <= 0) {
      gameOver = true;
    } else {
      resetBallForCurrentLevel();
    }
  }

  int pts[] = {50, 40, 30, 20, 10};

  // Block collisions
  for (int r = 0; r < rows; r++) {
    for (int c = 0; c < cols; c++) {
      Block blk = blocks[r][c];
      if (!blk.broken && blk.checkCollision(ball)) {
        blk.broken = true;
        ball.yspeed *= -1;
        score += pts[blk.row];
      }
      blk.display();
    }
  }

  // Level progression
  if (allBroken()) {
    if (level < 3) {
      level++;
      initLevel();
    } else {
      fill(255);
      textSize(36);
      textAlign(CENTER);
      text("YOU BEAT THE IMPOSSIBLE LEVEL", width/2, height/2);
      noLoop();
    }
  }
}

//Level initialization + difficulty scales
void initLevel() {
  finalLevel = (level == 3);

  float ballSpeed;
  if (level == 1) ballSpeed = 5;
  else if (level == 2) ballSpeed = 7.5;
  else ballSpeed = 11;

  ball = new Ball(width/2, 300, ballSpeed, -ballSpeed, 10);

  float racketWidth;
  if (level == 1) racketWidth = 100;
  else if (level == 2) racketWidth = 75;
  else racketWidth = 45;

  racket = new Racket(width/2 - racketWidth/2, height - 60, racketWidth, 15);

  blocks = new Block[rows][cols];
  float bw = width / cols;
  float bh = 25;

  color[] rowColors = {
    color(255, 0, 0),
    color(255, 165, 0),
    color(255, 255, 0),
    color(0, 200, 0),
    color(0, 150, 255)
  };

  for (int r = 0; r < rows; r++) {
    for (int c = 0; c < cols; c++) {
      blocks[r][c] = new Block(c * bw, r * bh + 120, bw - 2, bh - 2, rowColors[r], r);
    }
  }
}


void resetBallForCurrentLevel() {
  float ballSpeed;
  if (level == 1) ballSpeed = 5;
  else if (level == 2) ballSpeed = 7.5;
  else ballSpeed = 11;

  ball = new Ball(width/2, 300, ballSpeed, -ballSpeed, 10);
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
    paused = false;
    gameOver = false;
    loop();
    initLevel();
  }
}
