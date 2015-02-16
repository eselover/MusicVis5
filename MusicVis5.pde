import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

Minim minim;
AudioPlayer song;
FFT fft;

void setup()
{
  size(400, 400, P3D);
  minim = new Minim(this);
  song = minim.loadFile("InstantReplay.mp3", 2048);
  song.loop();
  fft = new FFT(song.bufferSize(), song.sampleRate());
}

void draw()
{
  background(0);

  float time = millis()/2000.0;

  stroke(random(0, 255), random(0, 255), random(0, 255));
  noFill();

  fft.forward(song.mix);
  
  pushMatrix();
  translate(200, 200, -30);
  rotate(time);
  for (int i = 0; i < fft.specSize (); i++)
  {
    ellipse(-100, -100, fft.getBand(i) / 2, fft.getBand(i)/ 2);
    ellipse(-100, 100, fft.getBand(i) / 2, fft.getBand(i) / 2);
    ellipse(100, -100, fft.getBand(i) / 2, fft.getBand(i) / 2);
    ellipse(100, 100, fft.getBand(i) / 2, fft.getBand(i) / 2);
    ellipse(sin(time), cos(time), fft.getBand(i) * 2, fft.getBand(i) * 2);
  }
  popMatrix();
}

