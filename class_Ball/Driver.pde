Ball ball;
text("Score: " + score, 20, 20);


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


if (ball.y + ball.r >= racket.y && ball.x > racket.x && ball.x < racket.x + racket.w) {
ball.yspeed *= -1;
float hitPos = (ball.x - (racket.x + racket.w/2)) / (racket.w/2);
ball.xspeed = hitPos * 5;
}


if (ball.y > height) {
gameOver = true;
}


int pts[] = {50, 40, 30, 20, 10};


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


if (allBroken()) {
paused = true;
fill(255);
textSize(32);
textAlign(CENTER);
text("YOU WIN! Press R", width/2, height/2);
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
setup();
paused = false;
gameOver = false;
score = 0;
}
}
