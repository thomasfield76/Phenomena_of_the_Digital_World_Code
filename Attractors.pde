// Class to store all attractors in.
class Attractors {

  // Initialising variables. 
  ArrayList<Attractor> attractors;
  PVector spawnPos;

  // Function for creating attractors and
  // storing them in an ArrayList.
  Attractors() {
    attractors = new ArrayList<Attractor>();
  }

  // Function for adding each attractor to 
  // the array. Takes arguments of position and
  // mass.
  void addAttractor(PVector pos, float mass) {
    spawnPos = pos.copy();
    attractors.add(new Attractor(spawnPos, mass));
  }

  // Iterates through the array and
  // displays each attractor.
  void run() {
    if (setup == true) {
      for (int i = 0; i < attractors.size(); i++) {
        Attractor a = attractors.get(i);
        a.display();
      }
    }
  }
}