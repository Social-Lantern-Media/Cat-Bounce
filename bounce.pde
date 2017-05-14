/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/7824*@* */
/* !do not delete the line above, required for linking your tweak if you upload again */
// bounce
// by Ben Chun
// (sorta-physics platform gameplay in the style of the famous Doodle Jump)

///TO DO
//falling spikes = instant death
//pickups = points. 
//spring = double jump

//add game states
  ///introduction
  ///gameover 2 restart for points = 0; 
Sparkle s;
ArrayList<Sparkle> sparkles;
Explosion e;
ArrayList<Explosion> explosions;
Boolean replay = false; 
PImage cat;
PImage background;
PImage glaze;
PImage pew;
PImage meow; 

PFont scorefont;
PImage startp; 

PImage platformreg;
PImage platformfast; 
PImage platformhorz;
PImage platformvert; 

PImage leftbutton;
PImage rightbutton; 

int circleSize = 100;   // Diameter of button 



Player p;
ArrayList platforms;
boolean wPressed, aPressed, sPressed, dPressed;

boolean spike = false;

int score; 
int fallCount= 0;
int points = 0;
int highscore = 0; 

boolean gameOver;

boolean play = false; 

void setup()
{
  colorMode(HSB, 360, 100, 100);
  
  size(340, 480);
    noCursor();
  noStroke();
 
  sparkles = new ArrayList<Sparkle>();
  explosions = new ArrayList<Explosion>();
  
  startp = loadImage("start.png"); 
  cat = loadImage("cat.png");
  leftbutton = loadImage("leftbutton.png");
  rightbutton = loadImage("rightbutton.png"); 
  
  background = loadImage("wallpaper.png");
  glaze = loadImage("glaze.png");
  
 pew = loadImage("pew.gif");  
 meow = loadImage("meow.png"); 
 
 scorefont = loadFont("cat.vlw"); 
  platformreg = loadImage("platformreg.png");
  platformfast = loadImage("fastplat.png");
  platformhorz = loadImage("horzplat.png");
 // platformvert = loadImage("vertplat.png");
  
  
  
  frameRate(60);
  
  
 
  
  initialize();
 
  
  
}

void initialize()
{
  play = true; 
  score = 0;
  points = 0; 
  fallCount = 0;
  gameOver = false;
  image(pew,0, 100); 
  
  p = new Player(width/2,height/2);
  
  platforms = new ArrayList();
 
  platforms.add(new HorizontalMovingPlatform(20,80,70,8));
 
  platforms.add(new VerticalMovingPlatform((int)random(40,180),20,50,8));
 
  platforms.add(new FastMovingPlatform(20,160,80,8));
   
  platforms.add(new SpringPlatform((int)random(40,180),100,70,16));
  
  
  platforms.add(new Platform(100,420,100,8));
  platforms.add(new Platform((int)random(40,180),320,100,8));
  platforms.add(new Platform((int)random(40,180),220,100,8));
  platforms.add(new Platform((int)random(40,180),120,100,8));
  platforms.add(new Platform((int)random(40,180),520,100,8));
  platforms.add(new Platform((int)random(40,180),20,100,8));
  
  
}

void draw()
{
  //println(score);
  background(0);
  //image(background,0,0);
       fill(255); 
 
  
  
   if ( dist(0, 420, mouseX, mouseY) < circleSize/2 ) {
    mousePressed = true;
    
  }
  else {
    mousePressed = false;
    
  };
  
   if ( dist(280, 420, mouseX, mouseY) < circleSize/2 ) {
    mousePressed = true;
  }
  else {
    mousePressed = false;
    
  };
  
  
  

    
  for(int i=0; i<platforms.size(); i++)
  {
    //  processing supported generics.
    // http://dev.processing.org/bugs/show_bug.cgi?id=598
    p.collide((Platform)platforms.get(i));
    ((Platform)platforms.get(i)).display();
    ((Platform)platforms.get(i)).move();
  }
  p.display(); 
  p.move();

  adjustViewport();
  cleanUp();
  seedNewPlatforms();
  
  if (platformsBelow() == 0) {gameOver = true; play = false; 
   image(startp,0,0);
  
  }
  ///if (spike = true) gameOver =true;  ***fix with gamestates for falling objects 
  
  if (gameOver) fallCount++; 
  if(replay == true ) initialize(); 
  //if (fallCount > 50 ) initialize();
  fill(38,39,34); 
  textFont(scorefont, 24);
  text("Climb Points : " + points, width / 2-125, 50);

}


int platformsBelow()
{
  int count = 0;
  for(int i=0; i<platforms.size(); i++)
  {
    if (((Platform)platforms.get(i)).y >= p.y-50) count++;
  }
  
  return count;
}


void adjustViewport()
{
  // above midpoint
  float overHeight = height * 0.5 - p.y;
  if(overHeight > 0)
  {
    p.y += overHeight;
    for(int i=0; i<platforms.size(); i++)
    {
      ((Platform)platforms.get(i)).y += overHeight;
    }
   
  }
  // falling
  float underHeight = p.y - (height-p.h-4);
  if(underHeight > 0)
  {
    p.y -= underHeight;
    for(int i=0; i<platforms.size(); i++)
    {
      ((Platform)platforms.get(i)).y -= underHeight;
    }
  }
 
}

void cleanUp()
{
  for(int i=platforms.size()-1; i>=0; i--)
  {
    // scrolled off the bottom
    if(((Platform)platforms.get(i)).y > height+40)
    {
      platforms.remove(i);
    }
  }
}

void seedNewPlatforms()
{
  if(platforms.size() < 7)
  {
    if(random(0,20) <= 15) platforms.add(new HorizontalMovingPlatform((int)random(10,width-80),-10,70,8));
    else if(random(0,20) >= 15) platforms.add(new FastMovingPlatform((int)random(10,width-80),-10,70,8));
    else if(random(0,15) <=5 ) platforms.add(new VerticalMovingPlatform((int)random(10,width-80),-10,70,8));
    else if(random(0,5) <= 2 ) platforms.add(new SpringPlatform((int)random(10,width-80),-10,90,8));
    else platforms.add(new Platform((int)random(20,200),-10,70,8));
  }
 // if(platforms.size() < 4) {
  //  platforms.add(new Platform((int)random(20,200),-10,70,8));
 // }
}

void mouseClicked(){
  play = true;
   replay = !replay;
  
}

void keyPressed()
{
  if (key == 'w') wPressed = true;
  if (key == 'a') aPressed = true;
  if (key == 's') sPressed = true;
  if (key == 'd') dPressed = true;
}

void mousePressed() {
    

  if ((mousePressed == true) &&  ( dist(0, 420, mouseX, mouseY) < circleSize/2 )) {

    aPressed = true;
    //dPressed = false;
  } 
  
  
  if ((mousePressed == true) &&  ( dist(280, 420, mouseX, mouseY) < circleSize/2 )) {

    dPressed = true;
   // aPressed = false;
  } 
  
}


void mouseReleased() {
  
   
   aPressed = false;
   dPressed = false;
}

void keyReleased()
{
  if (key == 'w') wPressed = false;
  if (key == 'a') aPressed = false;
  if (key == 's') sPressed = false;
  if (key == 'd') dPressed = false;
}





