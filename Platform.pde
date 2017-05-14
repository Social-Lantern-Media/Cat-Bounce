class Platform
{
  float x,y,w,h;
  float xvel, yvel;
  boolean reg = false;
  boolean regfast = false;
  boolean horzf = false;

  Platform(int x, int y, int w, int h)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    
    
  }

  void display()
  {
    fill(0);
    
   
   
    
    if (regfast == true) {
    
      image(platformfast,x,y,w,h);
    } else if (horzf == true) {
      
      image(platformhorz,x,y,w,h);
    }
    
    else {
   
      image(platformreg,x,y,w,h);
    }
    
   image(glaze,0, 0);
  image(leftbutton,0,420);
  image(rightbutton,280,420);  
    //rect(x,y,w,h);
  }

  void move()
  {
    x += xvel;
    y += yvel;
  }

}

class HorizontalMovingPlatform extends Platform
{
  static final float speed = 3.9;
  // set to random
  // add double bounce
  
  HorizontalMovingPlatform(int x, int y, int w, int h)
  {
    super(x, y, w, h);
    
    this.xvel = speed;
    horzf = true;
  }
  
  void move()
  {
    super.move();
    if( (x+w > width - 10) || (x < 10) )
    {
      xvel *= -1;
    }
  }
}

class FastMovingPlatform extends Platform
{
  static final float speed = 6.9;
  // set to random
  // add double bounce
  
  
  FastMovingPlatform(int x, int y, int w, int h)
  {
    super(x, y, w, h);
    this.xvel = speed;
    regfast = true;
  }
  
  void move()
  {
    super.move();
    if( (x+w > width - 10) || (x < 10) )
    {
      xvel *= -1;
    }
  }
}

class VerticalMovingPlatform extends Platform
{
  static final float speed = 6.9;
  // set to random
  // add double bounce
  
  VerticalMovingPlatform(int x, int y, int w, int h)
  {
    super(x, y, w, h);
    this.yvel = speed;
  }
  
  void move()
  {
    super.move();
    if( (y+h > height-5) )
    {
      yvel *= -1;
          } 
     if (y < 0) {
          yvel *= -1; 
          }
  }
}



class SpringPlatform extends Platform
{
  static final float speed = 0;
  // set to random
  // add double bounce
  
  SpringPlatform(int x, int y, int w, int h)
  {
    super(x, y, w, h);
   //  bounceVel = 10.1;
  }
  
  
}
