// Class to store all particles in.
class ParticleSystem {

  // Initialising variables.
  ArrayList<Particle> particles;
  PVector spawnPos;

  // Creating a particle system that adds new particles
  // to an ArrayList.
  ParticleSystem() {
    particles = new ArrayList<Particle>();
  }

  // Creating the function to add each particle
  // to the array, based on vertices stored in an array.
  // Also acceleration determined by its position.
  void addParticle(PVector vertex, PVector acc) {
    spawnPos = vertex;
    particles.add(new Particle(spawnPos, acc));
  }

  // Function to apply each attractor 
  // to each particle
  void applyAttractor(Attractor a) {
    for (Particle p : particles) {
      // Calling the function to 
      // attract the particle and 
      // then applying the required force.
      PVector force = a.attract(p);
      p.applyForce(force);
    }
  }

  void applyRepeller(Repeller r) {
    for (Particle p : particles) {
      // Calling the function to 
      // attract the particle and 
      // then applying the required force.
      PVector force = r.repel(p);
      p.applyForce(force);
    }
  }

  // Function to iterate through the list and 
  // run each particle and check that its "alive".
  void run() {
    Iterator<Particle> it = particles.iterator();
    while (it.hasNext()) {
      Particle p = it.next();
      p.run();
      if (p.isDead()) {
        it.remove();
      }
    }
  }
}