class Player
{

  
  static final float gravity = 0.14;
  static final float bounceVel = 8.1;
  static final float maxYVel = 12;
  static final float maxXVel = 2;
   boolean catcall; 

  float x, y, xVel, yVel;
  int w, h;
  Player(int x, int y)
  {
    this.x = x;
    this.y = y;
    w = h = 70;
  }

  void display()
  {
    //player
     sparkles.add(new Sparkle(new PVector(x+30, y+30)));
 
  for (int i = 0; i < sparkles.size(); i++) {
    Sparkle s = sparkles.get(i);
    s.run();
    if (s.isDead()) {
      sparkles.remove(i);
    }
  }
    image(cat,x,y,w,h); 
    fill(204,0,0);
    
    if (catcall == true) {
      
      image(meow, x,y-50,w+20,h+20); 
        
    } else { catcall = false;}
   // rect(x,y,w,h);
  }

  void move()
  {
    x += xVel;
    y += yVel;

    // wrap around
    if (x > width-w) x = 0;
    if (x < 0) x = width-w;

    // horizontal
    if (!gameOver)
    {
      if (aPressed) xVel -= 1.05;
      else if (dPressed) xVel += 1.05;
      else
      {
        if (xVel > 0) xVel -= 0.03;
        else  xVel += 0.03;
      }
    }
    
    if (abs(xVel) < 0.01) xVel = 0;
    xVel = min(maxXVel, xVel);
    xVel = max(-maxXVel, xVel);

    // vertical
    yVel += gravity;
    yVel = min(maxYVel, yVel);
    yVel = max(-maxYVel, yVel);
  }

  void collide(Platform p)
  {
    // standard rectangle intersections, but only for our lowest quarter
    if(x         < p.x + p.w &&
      x + w      > p.x       &&
      y+h/2+h/4  < p.y + p.h &&
      y + h      > p.y)
     
    {
      // but we only care about platforms when falling
      if (yVel >= 0) {
        // for bouncing
        yVel = -bounceVel;
        
  }
 
  
        points = points +1; 
          for (int i = 0; i < 5; ++i) {
      explosions.add(new Explosion(new PVector(x+20, y)));
    }
        for (int i = 0; i < explosions.size(); ++i) {
    Explosion e = explosions.get(i);
    e.run();
    if (e.isDead()) {
      explosions.remove(i);
    }
  }
        catcall = true; 
        
      } else {
       
        catcall = false;
        
      }
      
       points = points;   
       
      
  }}







