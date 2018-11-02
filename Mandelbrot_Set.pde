int lastMouse_x;
int lastMouse_y;
float dMouse_x = 0;
float dMouse_y = 0;
boolean last_pressed;
long last_time = 0;
float center_x = -0.7;
float center_y = 0;
float zoom = 2;
int iterations = 100;

int px_thrad;

Button button_increaseIterations;

void setup() {
  size(700, 700);
  px_thrad = width * height / 4;
  
  button_increaseIterations = new Button (20, height-50, 25, 25);
  button_increaseIterations.setColor(200,200,200);
  button_increaseIterations.setName("+");
}

void draw() {
  long time = millis() - last_time;
  last_time = millis();
  println("Time: " + time + " ms");
  
  center_x = center_x + dMouse_x*zoom*2/width;
  center_y = center_y - dMouse_y*zoom*2/height;
  //println(center_x + " / " + center_y);
  
  loadPixels();
  
  Render r1 = new Render(0, px_thrad, width, height);
  Render r2 = new Render(px_thrad, px_thrad*2, width, height);
  Render r3 = new Render(px_thrad*2, px_thrad*3, width, height);
  Render r4 = new Render(px_thrad*3, px_thrad*4, width, height);
  r1.start();
  r2.start();
  r3.start();
  r4.start();
  
  try {r1.join();}
  catch (InterruptedException e) {}
  
  try {r2.join();}
  catch (InterruptedException e) {}
  
  try {r3.join();}
  catch (InterruptedException e) {}
  
  try {r4.join();}
  catch (InterruptedException e) {}
  
  updatePixels();
  
  //Interface
  button_increaseIterations.draw();
  
  //pan
  if (mousePressed == true){
    if (last_pressed == true){
      dMouse_x = lastMouse_x - mouseX;
      dMouse_y = lastMouse_y - mouseY;
    }
    lastMouse_x = mouseX;
    lastMouse_y = mouseY;
    last_pressed = true;
  }else{
    last_pressed = false;
    dMouse_x = 0;
    dMouse_y = 0;
  }
}

class Point {
  int x;
  int y;
}

class ComplexNum {
  float real;
  float imag;
  
  ComplexNum(float r, float i){
    this.real = r;
    this.imag = i;
  }
  
  ComplexNum(ComplexNum c){
    this.real = c.real;
    this.imag = c.imag;
  }
  float modulus(){
    float mod = sqrt(real*real + imag*imag);
    return mod;
  }
}

Point getPos(int index, int _width) {
  Point p;
  p = new Point();
  p.y = index / _width;
  p.x = index % _width;

  return p;
}

void mousePressed(){
  if (mouseButton == 39){
    center_x = 0;
    center_y = 0;
  }
  if (button_increaseIterations.isPressed()){
    iterations += 10;
  }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if (e > 0){
    zoom = zoom*1.1;
  }else{
    zoom = zoom*0.9;
  }
}
