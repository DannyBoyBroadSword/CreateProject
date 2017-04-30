//Make sure key repeats are on (when you press key it keeps going like "kkkkkkkkkk")
Player r;
Player b; 
Goal leftGoal;
Goal rightGoal;
Ball ball;
int phase = 1;
boolean win = false;
ArrayList<Player> playerList = new ArrayList<Player>();

void setup() {
  r = new Player("red");
  b = new Player("blue");
  playerList.add(r);
  playerList.add(b);
  size(1024, 640);
  leftGoal = new Goal(new PVector(5, height/2-75), new PVector(60, 150), 7, 0, color(200, 0, 0));
  rightGoal = new Goal(new PVector(width-65, height/2-75), new PVector(60, 150), 7, 0, color(0, 0, 200));
}

void draw() {
  background(50, 120, 0);
  stroke(255);
  strokeWeight(5);
  noFill();
  line(width/2, 0, width/2, height);
  ellipse(width/2, height/2, 100, 100);
  fill(255);
  textSize(14);
  text("Blue: "+leftGoal.goalCount, width/2-75, 20);
  text("Red: "+rightGoal.goalCount, width/2-75, 35);
  if(b.ballHits != 0){
    println("blue hits"+b.ballHits);
    //println("blue shots"+b.ballHits);
    //println(leftGoal.goalCount/b.getHits());
    float blueShotPercentage = float(leftGoal.goalCount*100)/float(b.ballHits);
    float bluePossession = float(b.ballHits*100)/(float(b.ballHits)+float(r.ballHits));
    text("Blue Shot Percentage: "+str(blueShotPercentage)+"%", width/2-75, 50);
    text("Blue Possession: "+str(bluePossession)+"%", width/2-75, 65);
    text("Blue Chance of Winning: "+(pow((bluePossession*blueShotPercentage*.001),(float(5-leftGoal.goalCount))))*100+"%", width/2-75, 80);
  }else if(b.ballHits == 0){
    
  }
  if(r.ballHits != 0){
    //println(rightGoal.goalCount/r.getHits());
    float redShotPercentage = float(rightGoal.goalCount*100)/float(r.ballHits);
    float redPossession = float(r.ballHits*100)/(float(b.ballHits)+float(r.ballHits));
    text("Red Shot Percentage: "+str(redShotPercentage)+"%", width/2-75, 95);
    text("Red Possession: "+str(redPossession)+"%", width/2-75, 110);
    text("Red Chance of Winning: "+(pow((redPossession*redShotPercentage*.001),(float(5-rightGoal.goalCount))))*100+"%", width/2-75, 125);
  }else if(r.ballHits == 0){
  }
   
  if (phase == 1) {
    if (win) {
      leftGoal.goalCount = 0; 
      rightGoal.goalCount = 0; 
      win = false;
    }
    ball = new Ball(new PVector(width/2, height/2), color(0), 25);
    r.pos = new PVector(width*.15, height*0.5);
    b.pos = new PVector((width-b.playWidth)*0.85, height*0.5);
    r.vel = new PVector (0, 0);
    b.vel = new PVector (0, 0);
    fill(#666970);
    stroke(#666970);
    rect(width/2-170, height/2-35, 330, 60, 7);
    fill(255);
    textSize(32);
    text("Press ENTER to Begin", width/2-170, height/2);
    textSize(12);
    text("Use wasd and arrow keys to move", width/2-100, height/2+20);
  }
  if (leftGoal.goalCount == 5 || rightGoal.goalCount == 5) {
    phase = 0; 
    gameReset();
  }
  if (phase == 2) {
    r.update();
    b.update();
    ball.update();
    leftGoal.update();
    rightGoal.update();
  }
}

void keyPressed() { 
  //Key controls for red team 

  if (key == 'w') {
    r.accel.y -= 0.25;
  } else if (key == 's') {
    r.accel.y += 0.25;
  } else if (key == 'a') {
    r.accel.x -= 0.25;
  } else if (key == 'd') {
    r.accel.x += 0.25;
  }


  //**______________________________________**//
  //Key controls for blue team 

  if (key == CODED) {
    if (keyCode == UP) {
      b.accel.y -= 0.25;
    } else if (keyCode == DOWN) {
      b.accel.y += 0.25;
    } else if (keyCode == LEFT) {
      b.accel.x -= 0.25;
    } else if (keyCode == RIGHT) {
      b.accel.x += 0.25;
    }
  }
  if (key == ENTER) {
    phase = (phase+1)%3;
  }
}


void keyReleased() {
  if (key == 'w') {
    r.accel.y = 0;
  } else if (key == 's') {
    r.accel.y = 0;
  } else if (key == 'a') {
    r.accel.x = 0;
  } else if (key == 'd') {
    r.accel.x = 0;
  }

  //Key released controls for blue

  if (key == CODED) {
    if (keyCode == UP) {
      b.accel.y = 0;
    } else if (keyCode == DOWN) {
      b.accel.y = 0;
    } else if (keyCode == LEFT) {
      b.accel.x = 0;
    } else if (keyCode == RIGHT) {
      b.accel.x = 0;
    }
  }
}

void gameReset() {
  win = true;
  if (phase == 0) {
    textSize(84);
    if (leftGoal.goalCount == 5) {
      fill(#666970);
      stroke(#666970);
      rect(width/2-180, height/2+65, 350, 50, 7);
      fill(rightGoal.gColor);
      text("BLUE    WINS", width/2-255, height/2);
      textSize(32);
      fill(255);
      text("Press ENTER to Restart", width/2-180, height/2+100);
    }
    if (rightGoal.goalCount == 5) {
      fill(#666970);
      stroke(#666970);
      rect(width/2-180, height/2+65, 350, 50, 7);
      fill(leftGoal.gColor);
      text("RED    WINS", width/2-215, height/2);
      textSize(32);
      fill(255);
      text("Press ENTER to Restart", width/2-180, height/2+100);
    }
  }
}