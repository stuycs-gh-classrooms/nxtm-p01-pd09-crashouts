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
size(600, 600);
initLevel();
}


void draw() {
background(0);


fill(255);
textSize(20);
textAlign(LEFT);
text("Score: " + score, 20, 20);
text("Lives: " + lives, 20, 45);
text("Level: " + level, 20, 70);


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
if (ball.y + ball.r >= racket.y && ball.x > racket.x && ball.x < racket.x + racket.w) {
ball.yspeed *= -1;
float hitPos = (ball.x - (racket.x + racket.w/2)) / (racket.w/2);
ball.xspeed = hitPos * 5;
}


// bottom collision = lose life
if (ball.y > height) {
lives--;
if (lives <= 0) {
gameOver = true;
} else {
ball.reset();
}
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


// win/level up
if (allBroken()) {
level++;
ball.reset();
initLevel();
}
}


void initLevel() {
ball = new Ball(width/2, height/2, 5 + level, -5 - level, 10);
racket = new Racket(width/2 - 50, height - 40, 100, 15);


blocks = new Block[rows][cols];
float bw = width / cols;
float bh = 25;


color[] rowColors = {
color(255, 0, 0), // 50 pts
color(255, 165, 0), // 40 pts
color(255, 255, 0), // 30 pts
color(0, 200, 0), // 20 pts
color(0, 150, 255) // 10 pts
};


for (int r = 0; r < rows; r++) {
for (int c = 0; c < cols; c++) {
blocks[r][c] = new Block(c * bw, r * bh + 40, bw - 2, bh - 2, rowColors[r], r);
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
