// Importing the java library for iterating.
import java.util.Iterator;
// Importing the pdf library.
import processing.pdf.*;
// Importing the geomerative library.
import geomerative.*;

// Main Program 
// Defining classes and variables.
ParticleSystem ps;
SpawnPath path;
Attractors as;
Repellers rs;
RShape shp;
RPoint[] points;
// Attractor mass.
float attractorMass;
// Repeller mass.
float repellerMass;
float margin = 0;
float time = 60;
float runtime = 60*time;
// the amount of randomness in particle movement.
float wiggle = 0.3;
int bg = 15;
// getting the date for file names.
int day = day();
int mon = month();
int year = year();
int hr = hour();
int min = minute();
int sec = second();
String date = day + "_" + mon + "_" + year + "_" + hr + "-" + min + "-" + sec;
String file = "Lightning.svg";
// Whether or not to run the particles.
boolean runProg = false;
// Whether or not to display the attractors.
boolean setup = true;
boolean attractorPlace = true;

// Setup Function
void setup() {
  // Setup stuff.
  size(1000, 1000);
  smooth(4);
  frameRate(60);
  background(bg); 
  // Initialising geomerative.
  RG.init(this);
  // Setting up classes
  path = new SpawnPath();
  path.getVertices();
  ps = new ParticleSystem();
  as = new Attractors();
  rs = new Repellers();
  // Iterating through the arrayList of vertices and add a particle at each.
  for (int i = 0; i < path.vertices.size(); i++) {
    ps.addParticle(path.vertices.get(i).add(new PVector(width/2, height/2)), new PVector(0, 0));
  }
}

// What to do when a key is held.
void keyTyped() {
  // Increaing the attractor/repeller mass for the next 
  // attractor/repeller to be placed.
  if (key == 'w') {
    if (attractorPlace == true) {
      attractorMass += 10;
    } else {
      repellerMass += 10;
    }
  }
}
// What to do on key presses.
void keyPressed() {
  // Starting the particles when
  // 's' is pressed.
  if (key == 's') {
    runProg = true;
    // Hiding the attractors when running the program.
    setup = false;
    background(bg);
    // starting the pdf.
    beginRecord(PDF, "PDFs/output_" + date + ".pdf");
    background(bg);
  }
  // Selecting Repellers.
  if (key == 'r') {
    attractorPlace = false;
  }
  // Selecting Attractors.
  if (key == 'a') {
    attractorPlace = true;
  }
}

// What to do when the mouse is pressed
void mousePressed() {
  // Find out whether attractors or repellers are selected.
  if (attractorPlace == true) {
    // Add an attractor at the mouse location of the current mass.
    as.addAttractor(new PVector(mouseX, mouseY), attractorMass);
    attractorMass = 0;
  } else {
    // Add a repeller at the mouse location of the current mass.
    rs.addRepeller(new PVector(mouseX, mouseY), repellerMass);
    repellerMass = 0;
  }
}

// Running the program
void draw() {
  // Displaying the attractors/repellers/spawn path if 
  // setting up the program.
  if (setup == true) {
    background(bg);
    pushMatrix();
    // displaying the shape from illustrator 
    // in the middle of the page.
    translate(width/2, height/2);
    noFill();
    stroke(250);
    RG.ignoreStyles(true);
    shp.draw();
    popMatrix();
    // running the attractors/repellers.
    as.run();
    rs.run();
    // Instructions
    fill(240);
    textAlign(LEFT);
    textSize(20);
    text("Attractor Mass: " + attractorMass + "\nRepeller Mass: " + repellerMass + 
        "\nPress 'R' to place Repellers, Press 'A' to place Attractors.\nPress 'W' to increase attractor/repeller mass by 10, then click the location for it.\nPress 'S' to run the program, \nit will close once it has finished running", 10, 25);
  }
  if (runProg == true) {
    // Iterating through the list of attractors/repellers and 
    // applying each to the particle system.
    for (int i = 0; i < as.attractors.size(); i++) {   
      ps.applyAttractor(as.attractors.get(i));
    }
    for (int i = 0; i < rs.repellers.size(); i++) {
      ps.applyRepeller(rs.repellers.get(i));
    }
    // running the particles.
    for (int i = 0; i < ps.particles.size(); i++) {
      for (int j = 0; j < ps.particles.size(); j++) {
        if (i != j) {
          ps.particles.get(i).isClose(ps.particles.get(j));
        }
      }
    }
    // Running the particles and
    // decreasing runtime by 1 per frame.
    ps.run();
    runtime--;
  }
  // Ending the PDF if the program is finished,
  // then exiting the program.
  if (runtime <= 0) {
    noLoop();
    endRecord();
    exit();
  }
}