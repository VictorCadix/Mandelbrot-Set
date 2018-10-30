

void setup() {
  size(400, 400);
  loadPixels();  
  //arrange the pixels
  Point pixel;
  pixel = new Point();

  for (int i = 0; i < pixels.length; i++) {
    pixel = getPos(i, width, height);
    float a = map(pixel.x, 0, width, -2, 2);
    float b = map(pixel.y, 0, width, -2, 2);
    
    float z = 0;
    //real part a²-b²
    float real = a*a - b*b;
    //imaginary (2ab)i
    float imag = 2*a*b;
    
    
    
    color black = color(0);
    float sum = a + b;
    color bnw = color(sum);
    pixels[i] = bnw;
  }

  updatePixels();
}

void draw() {
}

class Point {
  int x;
  int y;
}

Point getPos(int index, int _width, int _height) {
  Point p;
  p = new Point();
  p.y = index / _width;
  p.x = index % _width;

  return p;
}
