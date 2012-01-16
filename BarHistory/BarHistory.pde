ArrayList<String> history = new ArrayList<String>();
int scrollPosition = 0;

void setup()
{
  size(320, 440);
  PFont font = createFont("FFScala", 10);
  textFont(font);
  try {
    BufferedReader reader = new BufferedReader(new FileReader("C:/Users/ecoA/Desktop/log.txt"));
    String nextLine = reader.readLine();
    while(nextLine != null) {
      history.add(nextLine);
      nextLine = reader.readLine();
    }
  } catch(IOException ioe) {
  }
}

void draw()
{
  background(0);
  int readingNumber = (int)((((float)history.size())/((float)width)) * ((float)scrollPosition));
  if(readingNumber >= history.size()) readingNumber = history.size()-1;
//  println(readingNumber + "/" + history.size());
  String[] stringADC = split(history.get(readingNumber),'\t');
  int[] dataADC = new int[5];
  for(int i=0; i<stringADC.length ;i++) dataADC[i] = int(stringADC[i]);

  fill(180);
  text("temp", 105, 85);
  text("humidity", 27, 85);
  text("light", 187, 85);
  text("stretch", 262, 85);
  text(dataADC[1], 40, 368);
  text(dataADC[2], 115, 368);
  text(dataADC[3], 190, 368);
  text(dataADC[4], 267, 368);
  
  fill(0);
  stroke(180);
  rect(17, 95, 60, 255);
  rect(92, 95, 60, 255);
  rect(168, 95, 60, 255);
  rect(244, 95, 60, 255);
  
  fill(180);
  rect(17, 95 + 255 - dataADC[1]/10, 60, dataADC[1]/10);
  rect(92, 95 + 255 - dataADC[2]/7, 60, dataADC[2]/7);
  rect(168, 95 + 255 - dataADC[3]/5, 60, dataADC[3]/5);
  rect(244, 95 + 255 - dataADC[4]/5, 60, dataADC[4]/5);
  
  text(stringADC[0],width-235,height-30);
  rect(1,height-21,width-3,20);
  fill(0);
  rect(scrollPosition-4,height-20,6,18);
}

void mouseDragged()
{
  if(mouseY > height-20) {
    if(mouseX < 0) scrollPosition = 0;
    else if(mouseX > width) scrollPosition = width;
    else scrollPosition = mouseX;
  }
}

void mousePressed()
{
  if(mouseY > height-20) {
    if(mouseX < 0) scrollPosition = 0;
    else if(mouseX > width) scrollPosition = width;
    else scrollPosition = mouseX;
  }
}

