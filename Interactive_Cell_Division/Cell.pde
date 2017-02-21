class Cell {
  
  PVector pos;
  PVector vel = new PVector();
  PVector acl = new PVector();
  PVector noff = new PVector(random(10000), random(10000));;
  float r;
  float maxAcl = 1;
  color col = #56E0D6;
  
  Cell(PVector givpos, float givr) {
    pos = givpos;
    r = givr;
    col = color(random(30, 120), random(180, 260), random(170, 250));
  }
  
  Cell(PVector givpos, float givr, color c) {
    pos = givpos;
    r = givr;
    col = c;
  }
  
  void update() {
    acl.x = map(noise(noff.x), 0, 1, -maxAcl, maxAcl);
    acl.y = map(noise(noff.y), 0, 1, -maxAcl, maxAcl);
    acl.mult(0.1);

    noff.add(0.01, 0.01, 0);

    vel.add(acl);
    vel.limit(90/r);
    pos.add(vel);
    
    if (pos.x > width + r) {
      pos.x = -r;
    } else if (pos.x < -r) {
      pos.x = width + r;
    } else if (pos.y > height + r) {
      pos.y = -r;
    } else if (pos.y < -r) {
      pos.y = height + r;
    }
    
    if(r < 50) {
      float chance = random(100);
      if (chance > 50) {
        r += .1;
      }
    }
  }
  
  void render() {
    fill(col, 100);
    ellipse(pos.x, pos.y, r*2, r*2);
    fill(#E03F72, 170);
    ellipse(pos.x, pos.y, r*2/3, r*2/3);
  }
  
  
  boolean clicked(int x, int y) {
    float d = dist(pos.x, pos.y, x, y);
    if (d < r) {
      return true;
    } else {
      return false;
    }
  }
  
  Cell mitosis() {
    PVector newPos = pos.copy();
    Cell c = new Cell(newPos, r/2, col);
    return c;
  }
}