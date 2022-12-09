import fisica.*;
//pallete
color blue   = color(29, 178, 242);
color brown  = color(166, 120, 24);
color green  = color(74, 163, 57);
color red    = color(224, 80, 61);
color yellow = color(242, 215, 16);

//Mouse & Keyboard interaction variables
boolean mouseReleased;
boolean wasPressed;
int x;

//Buttons
Button gravity;
boolean g = false;
boolean b = false;
Button newBodies;

//assets
PImage redBird;
//fisica
FWorld world;

void setup() {
  rectMode(CENTER);
  //make window
  fullScreen();
  //gravity button
  gravity = new Button("GRAVITY", 100, 100, 150, 100, 255, 0);
  newBodies = new Button("NEWBODIES", 100, 300, 150, 100, 255, 0);
  //load resources
  redBird = loadImage("red-bird.png");
  //initialize world
  makeWorld();
  //add terrain to world
  makeTopPlatform();
  //makeBottomPlatform();
}
//=====================================================================================================================================
void makeWorld() {
  Fisica.init(this);
  world = new FWorld();
  world.setGravity(0, 900);
}
//=====================================================================================================================================
void makeTopPlatform() {
  FPoly p = new FPoly();
  //plot the vertices of this platform
  p.vertex(100, 500);
  p.vertex(100, 800);
  p.vertex(1300, 800);
  p.vertex(1300, 500);
  p.vertex(1200, 500);
  p.vertex(1200, 700);
  p.vertex(200, 700);
  p.vertex(200, 500);
  //p.vertex(1300, 600);


  // define properties
  p.setStatic(true);
  p.setFillColor(brown);
  p.setFriction(0.1);
  //put it in the world
  world.add(p);
}
//=====================================================================================================================================
//void makeBottomPlatform() {
//  FPoly p = new FPoly();
//  //plot the vertices of this platform
//  p.vertex(width+100, height*0.6);
//  p.vertex(300, height*0.8);
//  p.vertex(300, height*0.8+100);
//  p.vertex(width+100, height*0.6+100);
//  // define properties
//  p.setStatic(true);
//  p.setFillColor(brown);
//  p.setFriction(0);
//  //put it in the world
//  world.add(p);
//}

//=====================================================================================================================================
void draw() {
  click();
  println("x: " + mouseX + " y: " + mouseY);
  background(blue);
  if (newBodies.clicked) {
    b =! b;
  }
  if (b == false) {
    if (frameCount % 20 == 0) {  //Every 20 frames ...
      makeCircle();
      makeBlob();
      makeBox();
      makeBird();
    }
  }
  clouds();
  gravity.show();
  newBodies.show();

  if (gravity.clicked) g =! g;
  if (g == true)   world.setGravity(0, 900);
  if (g == false)   world.setGravity(0, 0);




  world.step();  //get box2D to calculate all the forces and new positions
  world.draw();  //ask box2D to convert this world to processing screen coordinates and draw
  clouds2();
}
//=====================================================================================================================================

void clouds() {
  fill(255);
  stroke(255);
  circle(x, 800, 200);
  circle(x+100, 800, 200);
  circle(x-100, 800, 200);
  circle(x, 700, 200);

  x = x+3;
  if (x > 1600) {
    x = -100;
  }
}

//=====================================================================================================================================

 void clouds2() {

  fill(255);
  stroke(255);
  circle(x, 250, 100);
  circle(x+50, 300, 100);
  circle(x-50, 300, 100);
  circle(x, 300, 100);

  x = x+3;

  if (x > 1600) {
    x = -100;
  }
}


//=====================================================================================================================================
void makeCircle() {
  FCircle circle = new FCircle(50);
  circle.setPosition(random(width), -5);
  //set visuals
  circle.setStroke(0);
  circle.setStrokeWeight(2);
  circle.setFillColor(red);
  //set physical properties
  circle.setDensity(0.2);
  circle.setFriction(1);
  circle.setRestitution(1);
  //add to world
  world.add(circle);
}
//=====================================================================================================================================
void makeBlob() {
  FBlob blob = new FBlob();
  //set visuals
  blob.setAsCircle(random(width), -5, 50);
  blob.setStroke(0);
  blob.setStrokeWeight(2);
  blob.setFillColor(yellow);
  //set physical properties
  blob.setDensity(0.2);
  blob.setFriction(1);
  blob.setRestitution(0.25);
  //add to the world
  world.add(blob);
}
//=====================================================================================================================================
void makeBox() {
  FBox box = new FBox(25, 100);
  box.setPosition(random(width), -5);
  //set visuals
  box.setStroke(0);
  box.setStrokeWeight(2);
  box.setFillColor(green);
  //set physical properties
  box.setDensity(0.2);
  box.setFriction(1);
  box.setRestitution(1);
  world.add(box);
}
//=====================================================================================================================================
void makeBird() {
  FCircle bird = new FCircle(48);
  bird.setPosition(random(width), -5);
  //set visuals
  bird.attachImage(redBird);
  //set physical properties
  bird.setDensity(0.8);
  bird.setFriction(1);
  bird.setRestitution(0.5);
  world.add(bird);
}
//=====================================================================================================================================



//=====================================================================================================================================
