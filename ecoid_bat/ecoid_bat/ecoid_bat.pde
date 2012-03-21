import java.util.ArrayList;
import processing.serial.*;

//proxy
import java.net.*;

FileWriter writer;

PImage bat;

int width = 400;
int height = 400;

PFont theFont = createFont("FFScala", 12);

ArrayList Reports;

int lf = 10;    // Linefeed in ASCII
String myString = null;
Serial port;  // The serial port

void setup() {
  frameRate(1);
  //size(320, 440);
  size(width, height);
  textFont(theFont);
  bat = loadImage("data/bat.png");
  
  // List all the available serial ports
  println(Serial.list());
  // I know that the first port in the serial list on my mac
  // is always my  Keyspan adaptor, so I open Serial.list()[0].
  // Open whatever port is the one you're using.
  port = new Serial(this, Serial.list()[0], 9600);
  port.clear();
  // Throw out the first reading, in case we started reading 
  // in the middle of a string from the sender.
  myString = port.readStringUntil(lf);
  myString = null;
}

void draw() {
  background(255);
  
  image(bat, 50, 50);
  
  while (port.available() > 0) {
    //String inBuffer = port.readString();
    String inBuffer = port.readStringUntil(13);

    if (inBuffer != null) {
      if(inBuffer.indexOf("val=") != -1){
        println("indexAt:" + inBuffer.indexOf("val="));
        println(inBuffer);
        println(inBuffer.substring(5));
        
        //threshold value
      }
    }
  }


}
