class Goal {
  public PVector gPosition;
  public PVector gSize;
  public int ballHits;
  public int corners;
  public int goalCount;
  public color gColor;
  
  public Goal (PVector gPosition, PVector gSize, int corners, int goalCount, color gColor){
    this.gPosition = gPosition;
    this.gSize = gSize;
    this.corners = corners;
    this.goalCount = goalCount;
    this.gColor = gColor;
  }
  
  void update() {
    if ((ball.bPosition.x + ball.bSize/2 > this.gPosition.x) && 
        (ball.bPosition.x - ball.bSize/2 < this.gPosition.x + this.gSize.x) &&
        (ball.bPosition.y + ball.bSize/2 > this.gPosition.y) && 
        (ball.bPosition.y - ball.bSize/2 < this.gPosition.y + this.gSize.y)) {
      goalCount+=1;
      phase = 1;
    }
    stroke(gColor);
    strokeWeight(5);
    noFill();
    rect(gPosition.x, gPosition.y, gSize.x, gSize.y, corners);
  }
}