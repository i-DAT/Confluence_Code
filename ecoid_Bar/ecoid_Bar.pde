// Example by Tom Igoe
import java.util.ArrayList;
import processing.serial.*;

//proxy
import java.net.*;

PFont humidity;
PFont stretch;
PFont temp;
PFont light;
FileWriter writer;

PImage logo;

int width = 800;
int height = 600;

//int bar_width = 70;
//int bar_height = 400;
int bar_width = 70;
int bar_height = 400;
int bar_Y = 95;
int bar_gap = 20;

int bar_unit = (400 / 1023);

int bar1_X = bar_gap;
int bar2_X = bar1_X + bar_width + bar_gap;
int bar3_X = bar2_X + bar_width + bar_gap;
int bar4_X = bar3_X + bar_width + bar_gap;

int text_Y = 85;
int value_Y = 510;

PFont theFont = createFont("FFScala", 12);


int lf = 10;    // Linefeed in ASCII
String myString = null;
Serial port;  // The serial port

boolean DEBUG = false;
int[] dataArray;
int[][] finalPacket;
String[] sensorArray;

int[] ECOIDS;
int[] ECOPACKET;

void setup() {
  frameRate(1);
  //size(320, 440);
  size(width, height);
  textFont(theFont);
  logo = loadImage("ConfluenceLogo.png");
  try {
    //Change this
    writer = new FileWriter("log.txt", true);
  } catch(IOException ioe) {
  }

    //change this
   System.setProperty("http.proxyHost","proxy.swgfl.org.uk");
   System.setProperty("http.proxyPort","8080");





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

  digitalSamples = new ArrayList();
  analogSamples = new ArrayList();

  finalPacket = new int[2][4]; 
  ECOIDS = new int[2];

  //ECOIDS[0] = 19761;
  //ECOIDS[1] = 2;

  sensorArray = new String[4];

  sensorArray[2] = "_light";
  sensorArray[3] = "_stretch";
  sensorArray[0] = "_humidity";
  sensorArray[1] = "_temp";
}

void draw() {
  /*  while (port.available() > 0) {
   myString = port.readStringUntil(lf);
   if (myString != null) {
   println(myString);
   }
   }
   */

  background(0);
  
  fill(255, 237, 0);
  //humidity = createFont("FFScala", 10);
  //textFont(humidity);
  text("humidity", bar1_X, text_Y);
  
  //temp = createFont("FFScala", 10);
  //textFont(temp);
  text("temp", bar2_X, text_Y);


  //light = createFont("FFScala", 10);
  //textFont(light);
  text("light", bar3_X, text_Y);



  //stretch = createFont("FFScala", 10);
  //textFont(stretch);
  text("stretch", bar4_X, text_Y);
  
 image(logo, bar1_X + 400, text_Y);
 //image(logo, 0, 0);


  fill(0);
  
  //change colour, size
  stroke(0, 255, 255);
  //rect(17, 95, 60, 255);
  rect(bar1_X, bar_Y, bar_width, bar_height);
  //rect(92, 95, 60, 255);
  stroke(255, 0, 0);
  rect(bar2_X, bar_Y, bar_width, bar_height);
  //rect(168, 95, 60, 255);
  stroke(0, 255, 0);
  rect(bar3_X, bar_Y, bar_width, bar_height);
  //rect(244, 95, 60, 255);
  stroke(0, 0, 255);
  rect(bar4_X, bar_Y, bar_width, bar_height);
  stroke(0);

  dataArray = getPacket();
  while (dataArray == null) dataArray = getPacket();
  //  println("dataArray size: "+ dataArray.length);
  parseZNetFrame();
}

