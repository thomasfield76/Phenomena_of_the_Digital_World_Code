// Class for generating the path for 
// the particles to spawn along.
class SpawnPath {
  // Initialising variables.
  ArrayList<PVector> vertices;
  // Function that creates the path 
  // using vertices
  SpawnPath() {
    // loading the svg file created in illustrator.
    shp = RG.loadShape(file);
    // centering the shape and adding a margin.
    shp = RG.centerIn(shp, g, margin);
    // getting the points from the svg.
    // these were the anchor points in illustrator.
    points = shp.getPoints();
    // creating a list to store the vertices in.
    vertices = new ArrayList();
  }

  // Function to retrieve the vertices and
  // add them to an array to later determine
  // the spawn points of each particle.
  void getVertices() {
    // checking there are actually some vertices.
    if (points != null) {
      for (int i = 0; i < points.length; i+=1) {
        PVector vertex = new PVector(points[i].x, points[i].y);
        vertices.add(vertex);
      }
    }
  }
}