class Render extends Thread {
  int origin;
  int end;
  int image_width;
  int image_height;
  Point pixel;
  color pColor;
  
  Render(int origin, int end, int image_width, int image_height) {
    this.origin = origin;
    this.end = end;
    this.image_width = image_width;
    this.image_height = image_height;
    pixel = new Point();
  }
  public void run() {
    long start = millis();
    for (int i = origin; i < end; i++) {
      pixel = getPos(i, image_width);
     
      float a = map(pixel.x, 0, image_width, center_x-zoom, center_x+zoom);
      float b = map(pixel.y, 0, image_height, center_y+zoom, center_y-zoom);
      
      //ComplexNum c;
      //c = new ComplexNum(a,b);
      ComplexNum z;
      z = new ComplexNum(0,0);
      
      float modulus = 0;
      
      // z(1) = z(0)² + c
      for (int j = 0; j < iterations && modulus < 4; j++) {
        //real part a²-b²
        float real = z.real * z.real - z.imag * z.imag + a;
        //imaginary (2ab)i
        float imag = 2 * z.real * z.imag + b;
        z.real = real;
        z.imag = imag;
        
        modulus = z.real*z.real + z.imag*z.imag;
      }
        
      if (modulus < 4){
        pColor = color(0);
      }
      else{
        pColor = color(255);
      }
      
      pixels[i] = pColor;
    }
    print(" " + (millis() - start));
  }
}
