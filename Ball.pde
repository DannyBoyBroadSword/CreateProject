class Ball {
  PVector bPosition;
  boolean bPossession;
  PVector bVel;
  PVector bAccel;
  color bCol;
  int bSize;

  Ball(PVector bPosition, color bCol, int bSize) {
    this.bPosition = bPosition;
    this.bCol = bCol;
    this.bVel = new PVector (0,0);
    this.bSize = bSize;
    this.bAccel = new PVector (0,0);
  }
  PVector getVel() {
    return bVel; 
  }
  
  void update() {
    bVel.add(bAccel);
    bPosition.add(bVel);
    bVel.limit(10);
    bVel.x *= 0.99; //x friction
    bVel.y *= 0.99; //y friction
    for (Player p : playerList){
      this.collide(p);
    }
    //wall collisions
    if(this.bPosition.x - bSize/2 < 0 || this.bPosition.x + bSize/2 > width) {
      this.bVel.x *= -1;
    }
    else if(this.bPosition.y - bSize/2 < 0 || this.bPosition.y + bSize/2 > height){
      this.bVel.y *= -1;    
    }
    fill(bCol);
    ellipse(bPosition.x, bPosition.y , bSize,bSize);
  }
    //collision with players
  void collide(Player p){
    if ((this.bPosition.x + this.bSize/2 > p.pos.x) && 
        (this.bPosition.x - this.bSize/2 < p.pos.x + p.playWidth) &&
        (this.bPosition.y + this.bSize/2 > p.pos.y) &&
        (this.bPosition.y - this.bSize/2 < p.pos.y + p.playHeight)) {
      this.bVel.x = p.vel.x + abs(p.vel.x)/p.vel.x;
      this.bVel.y = p.vel.y + abs(p.vel.y)/p.vel.y;      
        }
}
}