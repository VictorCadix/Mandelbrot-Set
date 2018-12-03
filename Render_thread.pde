class Render extends Thread {
  int threadNum;
  int origin;
  int end;
  int image_width;
  int image_height;
  Point pixel;
  color pColor;
  
  Render(int threadNumber, int origin, int end, int image_width, int image_height) {
    this.threadNum = threadNumber;
    this.origin = origin;
    this.end = end;
    this.image_width = image_width;
    this.image_height = image_height;
    pixel = new Point();
  }
  public void run() {
    //int start = millis();
    for (int i = origin; i < end; i++) {
      pixel = getPos(i, image_width);
     
      double a = reMap(pixel.x, 0, image_width, center_x-zoom, center_x+zoom);
      double b = reMap(pixel.y, 0, image_height, center_y+zoom, center_y-zoom);
      
      //ComplexNum c;
      //c = new ComplexNum(a,b);
      ComplexNum z;
      z = new ComplexNum(0,0);
      
      double modulus = 0;
      int iterations;
      // z(1) = z(0)² + c
      for (iterations = 0; iterations < max_iterations && modulus < 4; iterations++) {
        //real part a²-b²
        double real = z.real * z.real - z.imag * z.imag + a;
        //imaginary (2ab)i
        double imag = 2 * z.real * z.imag + b;
        z.real = real;
        z.imag = imag;
        
        modulus = z.real*z.real + z.imag*z.imag;
      }
      float aux = map(iterations, 0, max_iterations, 0, 250);
      if (modulus < 4){
        pColor = color(0);
      }
      else{
        pColor = color(255-aux);
      }
      
      pixels[i] = pColor;
    }
    //int end = millis();
    //print(" * R"+ threadNum + " " + (end - start));
  }
}
