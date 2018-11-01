int lastMouse_x;
int lastMouse_y;
float dMouse_x = 0;
float dMouse_y = 0;
boolean last_pressed;
long last_time = 0;
float center_x = -0.7;
float center_y = 0;
float zoom = 2;

void setup() {
  size(700, 700);
  
}

void draw() {
  long time = millis() - last_time;
  last_time = millis();
  println("Time: " + time + " ms");
  
  loadPixels();
  //arrange the pixels
  Point pixel;
  pixel = new Point();
  color pColor;
  //println(dMouse_x);
  //println(dMouse_y);
  
  center_x = center_x + dMouse_x*zoom*2/width;
  center_y = center_y - dMouse_y*zoom*2/height;
  //println(center_x + " / " + center_y);

  for (int i = 0; i < pixels.length; i++) {
    pixel = getPos(i, width, height);
   
    float a = map(pixel.x, 0, width, center_x-zoom, center_x+zoom);
    float b = map(pixel.y, 0, height, center_y+zoom, center_y-zoom);
    
    ComplexNum c;
    c = new ComplexNum(a,b);
    ComplexNum z;
    z = new ComplexNum(0,0);
    
    // z(1) = z(0)² + c
    
    for (int j = 0; j < 100; j++) {
      //real part a²-b²
      float real = z.real * z.real - z.imag * z.imag + a;
      //imaginary (2ab)i
      float imag = 2 * z.real * z.imag + b;
      z.real = real;
      z.imag = imag;
      
      //modulus
      float modulus = sqrt(z.real*z.real + z.imag*z.imag);
      
      if (modulus < 100){
        pColor = color(0);
      }
      else{
        pColor = color(255);
      }
      
      pixels[i] = pColor;
    }
  }

  updatePixels();
  
  
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

Point getPos(int index, int _width, int _height) {
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
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if (e > 0){
    zoom = zoom*1.1;
  }else{
    zoom = zoom*0.9;
  }
}
