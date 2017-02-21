ArrayList<Cell> c = new ArrayList();
ArrayList toRemove = new ArrayList();
ArrayList toAdd = new ArrayList();
static int cellInitSize = 50;
Cell cToRemove;
int startCount = 5;

void setup() {
  size(1200, 800);
  for (int i = 0; i < startCount; i++) {
    c.add(new Cell(new PVector(random(width - cellInitSize) + cellInitSize/2, random(height - cellInitSize) + cellInitSize/2), cellInitSize));
  }
}

void draw() {
  background(#498EAD, 100);
  
  for (Cell cl : c) {
    cl.update();
    cl.render();
  }
}

void mousePressed() {
  if (mouseButton == LEFT) {
    for (Cell cl : c) {
      if (cl.clicked(mouseX, mouseY) && cl.r > 20 && c.size() < 50) {
        for (int i = 0; i < random(1, 3); i++) {
          toAdd.add(cl.mitosis());
        }
        toRemove.add(cl);
        break;
      }
    }
  } else if (mouseButton == RIGHT) {
    for (Cell cl : c) {
      if (cl.clicked(mouseX, mouseY) && c.size() > 1) {
        toRemove.add(cl);
        break;
      }
    }
  }
  
  c.removeAll(toRemove);
  c.addAll(toAdd);
  toRemove.clear();
  toAdd.clear();
}