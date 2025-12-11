class Block {
float x, y, w, h;
boolean broken = false;
color col;
int row;


Block(float x, float y, float w, float h, color col, int row) {
this.x = x;
this.y = y;
this.w = w;
this.h = h;
this.col = col;
this.row = row;
}


void display() {
if (!broken) {
fill(col);
rect(x, y, w, h);
}
}


boolean checkCollision(Ball b) {
if (!broken && b.x + b.r > x && b.x - b.r < x + w && b.y + b.r > y && b.y - b.r < y + h) {
return true;
}
return false;
}
}
