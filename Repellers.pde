// Class to store all repellers in.
class Repellers {

  // Initialising variables. 
  ArrayList<Repeller> repellers;
  PVector spawnPos;

  // Function for creating repellers and
  // storing them in an ArrayList.
  Repellers() {
    repellers = new ArrayList<Repeller>();
  }

  // Function for adding each repeller to 
  // the array. Takes arguments of position and
  // mass.
  void addRepeller(PVector pos, float mass) {
    spawnPos = pos.copy();
    repellers.add(new Repeller(spawnPos, mass));
  }

  // Iterates through the array and
  // displays each repeller.
  void run() {
    if (setup == true) {
      for (int i = 0; i < repellers.size(); i++) {
        Repeller r = repellers.get(i);
        r.display();
      }
    }
  }
}