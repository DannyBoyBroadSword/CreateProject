class Player {
  PVector pos;
  String team;
  PVector vel;
  PVector accel;
  int score;
  color col;
  int playWidth;
  int playHeight;

  Player (String team) {
    this.team = team;
    if (team.equals("blue")) { 
      pos = new PVector((width-playWidth)*0.85, height*0.5);
      col = color(0,0,200);
    } else {
      pos = new PVector(width*.15, height*0.5);
      col = color(200,0,0);
    }
    score = 0;
    this.vel = new PVector (0,0);
    
    
    playWidth = 50; 
    playHeight = 35;
    this.accel = new PVector (0,0);

  }
  
  PVector getVel() {
    return vel;
    
  }
  
  void update() {
    vel.add(accel);
    pos.add(vel);
    vel.limit(7);
    vel.x *= 0.95; //x friction
    vel.y *= 0.95; //y friction
    if (pos.x > width - vel.x - playWidth) {
      pos = new PVector (width-playWidth, pos.y);
    }
    if (pos.x < 0) {
      pos = new PVector (0, pos.y);
    }
    if (pos.y < 0 ) {
      pos = new PVector (pos.x, 0);
    }
    if (pos.y > height-playHeight) {
      pos = new PVector (pos.x, height-playHeight);
    }
    for (Player p : playerList){
      if (!this.equals(p)) this.collide(p);
    }
    fill(col);
    stroke(255);
    strokeWeight(2);
    rect(pos.x, pos.y ,playWidth,playHeight);
    
  }
  //Collision with Players
  boolean collide(Player p){
    if (p.pos.x < this.pos.x && this.pos.x < (p.pos.x + playWidth) && (p.pos.y < this.pos.y && this.pos.y < (p.pos.y + playHeight))){
      this.vel.x *= -2;
      this.vel.y *= -2;
      return true;
    }
    else if (p.pos.x < (this.pos.x + playWidth) && this.pos.x < (p.pos.x + playWidth) && (p.pos.y < (this.pos.y + playHeight) && this.pos.y < (p.pos.y + playHeight))){
      this.vel.x *= -2;
      this.vel.y *= -2;
      return true;
    }
    else return false;
  }
}