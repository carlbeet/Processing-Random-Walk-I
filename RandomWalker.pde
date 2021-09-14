class RandomWalker {
 float xpos, ypos;
 float xtot, ytot;
 int step;
  
  
RandomWalker() {
xpos = width/2;
ypos = height/2;
xtot = 0;
ytot = 0;
}

public void walk() {

  step = int(random(1,5));
 
  //clamps 
  if (xtot >= width/2) { step = int(random(2,5)); } //2-4
  if (xtot <= -width/2) { while (step == 2) {step = int(random(1,5));} } // anything but 2
  if (ytot >= height/2) { while (step == 3) {step = int(random(1,5));} } // anything but 3 
  if (ytot <= -height/2) { step = int(random(1,4)); } //1-3
   
  if (step == 1) {
    xpos +=1;
    xtot ++;
  }
  else if (step == 2) {
    xpos -=1;
    xtot --;
  }
  else if (step == 3) {
    ypos +=1;
    ytot ++;
  }
  else if (step == 4) {
    ypos -= 1;
    ytot --;
  }

 
}

public void display(){
  point(xpos, ypos);
}

public void reset() {
  xpos = width/2;
  ypos = height/2;
  xtot = 0;
  ytot = 0;
}

}
