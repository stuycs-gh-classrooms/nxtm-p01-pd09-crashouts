
// Global variables
Ball[][] grid;         // 3x5 grid of balls
Ball projectile;        // The moving projectile

int ROWS = 3;
int COLS = 5;
int BALL_SIZE = 40;     
int PROJECTILE_SIZE = 20;

void setup() {
  size(600, 600);
  grid = new Ball[ROWS][COLS];

  makeBalls(grid);
  newProjectile(PROJECTILE_SIZE);
}

void draw() {
  background(255);

  drawGrid(grid);

  // Move and draw projectile
  projectile.move();
  projectile.display();

  processCollisions(projectile, grid);
}


void keyPressed() {

  if (key == ' ') {
    // launch projectile upward
    projectile.yspeed = -5;
  }

  if (keyCode == LEFT) {
    projectile.center.x -= 10;
  }

  if (keyCode == RIGHT) {
    projectile.center.x += 10;
  }
}


void makeBalls(Ball[][] g) {

  int startX = 100;
  int startY = 100;

  for (int r = 0; r < ROWS; r++) {
    for (int c = 0; c < COLS; c++) {

      // Each ball positioned size distance apart
      float x = startX + c * BALL_SIZE * 1.5;
      float y = startY + r * BALL_SIZE * 1.5;

      g[r][c] = new Ball(new PVector(x, y), BALL_SIZE);
      g[r][c].setColor(color(200, 0, 100));
    }
  }
}


void newProjectile(int psize) {

  float x = width / 2;
  float y = height - psize;

  projectile = new Ball(new PVector(x, y), psize);

  projectile.setColor(color(0, 100, 255));
  projectile.xspeed = 0;
  projectile.yspeed = 0;
}


void drawGrid(Ball[][] g) {

  for (int r = 0; r < ROWS; r++) {
    for (int c = 0; c < COLS; c++) {
      if (g[r][c] != null) {
        g[r][c].display();
      }
    }
  }
}


void processCollisions(Ball p, Ball[][] g) {

  for (int r = 0; r < ROWS; r++) {
    for (int c = 0; c < COLS; c++) {

      Ball b = g[r][c];

      if (b != null && p.collisionCheck(b)) {

    projectile.xspeed = -5;
    projectile.yspeed = -5;
      }
    }
  }
}
