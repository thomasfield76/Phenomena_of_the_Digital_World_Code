// Creating a class for particles.
class Particle {
  // Initialising variables.
  PVector position;
  PVector velocity;
  PVector acceleration;
  PVector force;
  float mass;
  float G;
  float maxspeed;
  float lifespan = 60*time;
  float r, g, b;
  float distance;
  float strength;

  // Particle creation function
  // Takes an input for position.
  Particle(PVector pos, PVector acc) {
    // Arbituary mass.
    mass = 1;
    // Gravity constant.
    G = 0.4;
    maxspeed = 0.5;
    // setting position, velocity, acceleration.
    position = pos.copy();
    velocity = new PVector(0, 0);
    acceleration = new PVector(acc.x, acc.y);
    // Setting particle colours.
    r = 250;
    g = 250;
    b = 250;
  }

  // Function that applys the acceleration force to each particle.
  void applyForce(PVector force) {
    // PVector f = PVector.div(force, mass);
    acceleration.add(force);
  }
  // Function that updates the particles motion variables
  // for each frame, this creates the motion.
  void update() {
    // adding randoms to the velocity to get wiggly effect.
    velocity.add(new PVector(random(-wiggle, wiggle), random(-wiggle, wiggle)));
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    position.add(velocity);
    acceleration.mult(0);
    // Once this reaches 0, particle dies.
    lifespan--;
  }

  // Function that displays each particle.
  void display() {
    // Straightforward appearance setting.
    strokeWeight(1);
    // mapping lifespan to opacity so that the particles
    // become more transparent over time.
    stroke(r, g, b, map(lifespan, 0, runtime, 0, 15));
    point(position.x, position.y);
  }
  // Function to simplify the main program,
  // not necessary but keeps it clean.
  void run() {
    update();
    display();
  }
  
  // Function that checks if a particle is close to another,
  // if one is close then it draws a line between them.
  void isClose(Particle other) {
    // Finding the distance.
    float dist = dist(position.x, position.y, other.position.x, other.position.y);
    // Drawing a line if the dist is between two values.
    if (dist >= 10 && dist <= 15) {
      pushMatrix();
      noFill();
      strokeWeight(1);
      stroke(250, map(lifespan, 0, 60*time, 0, 5));
      line(position.x, position.y, other.position.x, other.position.y);
      // adding a thicker point at each point when they are a certain distance apart.
      strokeWeight(3);
      point(position.x, position.y);
      point(other.position.x, other.position.y);
      popMatrix();
    }
  }

  // Setting a boolean to check whether the 
  // particle is "dead" or not, determined by
  // either its position or lifespan value.
  boolean isDead() {
    if (runtime <= 0) {
      return true;
    } else {
      return false;
    }
  }
}