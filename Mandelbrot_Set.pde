

void setup() {
  size(800, 800);
  loadPixels();  
  //arrange the pixels
  Point pixel;
  pixel = new Point();
  color pColor;

  for (int i = 0; i < pixels.length; i++) {
    pixel = getPos(i, width, height);
    float a = map(pixel.x, 0, width, -3, 1);
    float b = map(pixel.y, 0, width, -2, 2);
    
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
}

void draw() {
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
