int lastMouse_x;
int lastMouse_y;
float dMouse_x = 0;
float dMouse_y = 0;
boolean last_pressed;
int last_time = 0;
float center_x = -0.7;
float center_y = 1;
float zoom = 1;
int iterations = 100;

int renderTime = 0;
int px_thrad;

Button button_increaseIterations;
Button button_decreaseIterations;

void setup() {
  size(700, 700);
  px_thrad = width * height / 16;
  
  button_increaseIterations = new Button (20, height-50, 25, 25);
  button_increaseIterations.setColor(200,200,200);
  button_increaseIterations.setName("+");
  
  button_decreaseIterations = new Button (20, height-20, 25, 25);
  button_decreaseIterations.setColor(200,200,200);
  button_decreaseIterations.setName("-");
}

void draw() {
  
  
  loadPixels();
  renderTime = millis();
  
  Render r1 = new Render(1, 0, px_thrad, width, height);
  Render r2 = new Render(2, px_thrad, px_thrad*2, width, height);
  Render r3 = new Render(3, px_thrad*2, px_thrad*3, width, height);
  Render r4 = new Render(4, px_thrad*3, px_thrad*4, width, height);
  Render r5 = new Render(5, px_thrad*4, px_thrad*5, width, height);
  Render r6 = new Render(6, px_thrad*5, px_thrad*6, width, height);
  Render r7 = new Render(7, px_thrad*6, px_thrad*7, width, height);
  Render r8 = new Render(8, px_thrad*7, px_thrad*8, width, height);
  Render r9 = new Render(9, px_thrad*8, px_thrad*9, width, height);
  Render r10 = new Render(10, px_thrad*9, px_thrad*10, width, height);
  Render r11 = new Render(11, px_thrad*10, px_thrad*11, width, height);
  Render r12 = new Render(12, px_thrad*11, px_thrad*12, width, height);
  Render r13 = new Render(13, px_thrad*12, px_thrad*13, width, height);
  Render r14 = new Render(14, px_thrad*13, px_thrad*14, width, height);
  Render r15 = new Render(15, px_thrad*14, px_thrad*15, width, height);
  Render r16 = new Render(16, px_thrad*15, px_thrad*16, width, height);
  
  r1.start();
  r2.start();
  r3.start();
  r4.start();
  r5.start();
  r6.start();
  r7.start();
  r8.start();
  r9.start();
  r10.start();
  r11.start();
  r12.start();
  r13.start();
  r14.start();
  r15.start();
  r16.start();
  
  try {r1.join();}
  catch (InterruptedException e) {}
  try {r2.join();}
  catch (InterruptedException e) {}
  try {r3.join();}
  catch (InterruptedException e) {}
  try {r4.join();}
  catch (InterruptedException e) {}
  try {r5.join();}
  catch (InterruptedException e) {}
  try {r6.join();}
  catch (InterruptedException e) {}
  try {r7.join();}
  catch (InterruptedException e) {}
  try {r8.join();}
  catch (InterruptedException e) {}
  try {r9.join();}
  catch (InterruptedException e) {}
  try {r10.join();}
  catch (InterruptedException e) {}
  try {r11.join();}
  catch (InterruptedException e) {}
  try {r12.join();}
  catch (InterruptedException e) {}
  try {r13.join();}
  catch (InterruptedException e) {}
  try {r14.join();}
  catch (InterruptedException e) {}
  try {r15.join();}
  catch (InterruptedException e) {}
  try {r16.join();}
  catch (InterruptedException e) {}
  
  print(" / " + (millis() - renderTime));
  
  updatePixels();
  
  //Interface
  button_increaseIterations.draw();
  button_decreaseIterations.draw();
  
  //pan
  if (mousePressed == true){
    if (last_pressed == true){
      dMouse_x = lastMouse_x - mouseX;
      dMouse_y = lastMouse_y - mouseY;
      center_x = center_x + dMouse_x*zoom*2/width;
      center_y = center_y - dMouse_y*zoom*2/height;
    }
    lastMouse_x = mouseX;
    lastMouse_y = mouseY;
    last_pressed = true;
  }else{
    last_pressed = false;
  }
  
  int time = millis() - last_time;
  last_time = millis();
  println(" # " + time);
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
  else if (button_decreaseIterations.isPressed()){
    iterations -= 10;
  }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if (e > 0){
    //Zoom out
    float aux = mouseX-(mouseX-width/2)*1.1;
    center_x = map(aux, 0, width, center_x-zoom, center_x+zoom);
    aux = mouseY-(mouseY-height/2)*1.1;
    center_y = map(aux, 0, height, center_y+zoom, center_y-zoom);
    zoom = zoom*1.1;
  }else{
    //Zoom in
    float aux = mouseX-(mouseX-width/2)*0.9;
    center_x = map(aux, 0, width, center_x-zoom, center_x+zoom);
    aux = mouseY-(mouseY-height/2)*0.9;
    center_y = map(aux, 0, height, center_y+zoom, center_y-zoom);
    zoom = zoom*0.9;
  }
}
