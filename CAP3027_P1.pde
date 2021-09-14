/* PROJECT 1: RANDOM WALK 
   CAP 3027
   Professor Joshua Fox
   
   project by Carl Noll
   est time: 4 hours
   9/9/2021
*/

import controlP5.*;
int r, centerX, centerY, buttonValue, step, background_Toggle;
color b;

color stepColor; 
ControlP5 cp5;
int iterations = 1000;
int stepCount = 0;
int iterCount = 0;
boolean start = false, isColor = false, isGradual = false, isClicked = false;
RandomWalker random;

void setup() {
  size(800, 800);
  pixelDensity(2);
  b = color(25, 40, 240);

  background_Toggle = 2; //ON; if set to 1 = OFF
  
  random = new RandomWalker();

  buttonValue = 0;

  centerX = width/2;
  centerY = height/2;

  //user controls!
  cp5 = new ControlP5(this);

  cp5.addSlider("iterations", 1000, 500000).setSize(400, 30).setPosition(250, 30);
  cp5.addSlider("stepCount", 1, 1000).setSize(400, 30).setLabel("Step Count").setPosition(250, 60);

  cp5.addToggle("isColor").setPosition(200, 30).setSize(30, 30).setLabel("  color");
  cp5.addToggle("isGradual").setPosition(160, 30).setSize(30, 30).setLabel("gradual");
  cp5.addButton("start").setPosition(50, 30).setSize(90, 30).setValue(0).setOff();

  cp5.getController("isColor").getValueLabel().align(ControlP5.CENTER, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
}

void draw() {
  
  if (background_Toggle != 1) // background toggle: 1 = off, 2 = on
  {background(b); }
  stroke(0);

  
  //if user chose gradual
  if (buttonValue == 1 && !isGradual) {
    for (int i = 0; i <= iterations; i++) {

      random.walk();

//color handling
      if (isColor) {
        stroke(map(i, 0, iterations, 0, 255));
      }
      else {
        stroke(0);}
        
      random.display();
    }
    noLoop();
    buttonValue = 0;
    random.reset();
    
    
  }
  // for N (iterCount) iterations, DRAW goes through and animates the walk in real time
  else if (buttonValue == 1 && isGradual) {
    
    background_Toggle = 1;
    
    for (int i = 0; i <= stepCount; i++) {
      
      random.walk();
      //color handling
      if (isColor) {
        stroke(map(iterCount, 0, iterations, 0, 255));
      }
      else {
        stroke(0);}
      random.display();
      iterCount++;
      //PROBLEM 2: only draws the current frame's walk (POINTS GO AWAY AFTER DRAW LOOP FINISHES >)
      //SOLVED: set off background using background_Toggle
      
    }
    if (iterCount >= iterations) {
      noLoop();
      buttonValue = 0;
      iterCount = 0;
      random.reset();
      
    }
  }

}
//PROBLEM 1: interface does not respond after no loop; solved with mousepressed()

void mousePressed() {
  loop(); 
  if (buttonValue == 0) { //issue fixed: pressing anywhere will clear the walk for non-gradual route 
  background_Toggle = 1;} // set background off after walk completes
}


public void start(int value) {
  if (frameCount > 1){
  
  background_Toggle = 2; //gradual sequence finished, next loop will include background
  buttonValue = 1; //buttonValue toggles to 1 whenever start is pressed

  }
}
/* PLANNING !
gradual vs !gradual, need to control: the rate at which points are laid down over time

step count: how many steps take place in 1 frame
 
 case 1: random walk appears at once
 case 2: random walk occurs in real time, gradual
   case 2 considers step count
   method: draw loop becomes the for loop, with i increment, decide stepcount 
 and cap value at 'iterations'
 
 
 */
