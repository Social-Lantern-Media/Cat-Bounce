class Sparkle {
  PVector location;
  float lifespan;
 
  Sparkle(PVector l) {
    location = l.get();
    lifespan = 55;
  }
 
  void run() {
    update();
    display();
  }
 
  void update() {
    lifespan -= 5;
  }
 
  void display() {
    float i = random(2, 5);
    fill(64, 69, 100);  //yellow
    quad(location.x-i, location.y, location.x, location.y-i, location.x+i, location.y, location.x, location.y+i);
  }
 
  boolean isDead() {
    if (lifespan < 0) {
      return true;
    }
    else {
      return false;
    }
  }
}
 
class Explosion {
  PVector location;
  PVector velocity;
  PVector acceleration;
  int     lifespan;
 
  Explosion(PVector l) {
    acceleration = new PVector(random(-1.5, 1.5), random(-1.5, 1.5));
    velocity = new PVector(random(-0.01, 0), random(-0.02, 0.03));
    location = l.get();
    lifespan = 255;
  }
 
  void run() {
    update();
    display();
  }
 
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    lifespan -= 2;
  }
 
  void display() {
    fill(18,18,18, lifespan);  //red
    int radius = (int) random(5, 15);
    ellipse(location.x, location.y, radius, radius);
  }
 
  boolean isDead() {
    if (lifespan < 0) {
      return true;
    }
    else {
      return false;
    }
  }
}
