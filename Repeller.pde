// Creating a class for repellers.
class Repeller {
  // Initialising variables.
  PVector position;
  PVector force;
  float mass;
  float G;
  float distance;
  float strength;

  //Repller creation function,
  // takes an input for position and mass.
  Repeller(PVector pos, float m) {
    position = pos.copy();
    mass = m;
    G = -0.4;
  }

  // Function that creates the repulsion
  // between each repller and particle.
  PVector repel(Particle p) {
    // Finds the direction of the attraction.
    force = PVector.sub(position, p.position);
    // Constrains the distance between the particle 
    // and repeller for visual reasons. Also to 
    // prevent division by 0.
    distance = force.mag();
    distance = constrain(distance, 200, 500);
    // Normalising the force before multiplying by 
    // the strength.
    force.normalize();
    // Strength is calculated from the real-world formula 
    // for gravitational attraction.
    strength = (G * mass * p.mass) / (distance * distance);
    force.mult(strength);
    // Returning the force so that it can be applied.
    return force;
  }

  // Function for displaying the repellers,
  void display() {
    noStroke();
    fill(0, 0, 200);
    ellipse(position.x, position.y, mass/4, mass/4);
  }
}