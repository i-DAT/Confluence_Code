import java.util.*;

// if you get a ZNet XBeeDataFrame, pull the parts out:

public int apiId = -1;
public int   sourceAddress16 = -1;
public long  sourceAddress64 = -1;

public int rssi = -1;

public boolean addressBroadcast;
public boolean panBroadcast;

int totalSamples = -1;

ArrayList digitalSamples;
ArrayList analogSamples;

String sendString;


String LastReport;




public void parseZNetFrame() {

  //if (DEBUG) System.out.print("  API ID: " + (int) apiId);

  // Looping to get 64-bit address
  long address = 0;
  for (int i = 8; i >= 1; i--) {
    long currentByte = dataArray[i];
    address += currentByte << i*8;
  }
  setAddress64(address);
  //println(address);
  // Get the 16 BIT address
  int addrMSB = dataArray[9];  // high byte of sender's 16-bit address
  int addrLSB = dataArray[10];  // low byte of sender's 16-bit address
  //int addr = (addrMSB << 8) + addrLSB;
  int addr=5;
  setAddress16(addr);

  println(addr);
  // Reading the options
  int options = dataArray[11];
  // DO NOTHING WITH OPTIONS FOR NOW

  // now we get to the ADC data itself
  int totalSamples = dataArray[12]; // this is the number of sample packages that we're receiving
  setTotalSamples(totalSamples);

  if (totalSamples > 1) {
    System.out.println("This preliminary version of the XBee API library only works with a sample size of 1.");
    System.out.println("Set ATIT to 1 on your transmitting radio(s).");

    // you need to quit out here. Figure out how.
    //quit();
    //return null;
  }

  if (DEBUG) System.out.print("  Total Samples: " + (int) totalSamples);
  int digitalChannelIndicatorHigh = dataArray[13]; // this tells us which analog channels (pins) are in use (and one digital channel)
  int digitalChannelIndicatorLow = dataArray[14];  // this tells us which digital channels (pins) are in use.
  int analogChannelIndicator = dataArray[15];


  for (int n = 0; n < totalSamples; n++) {
    // Process Digital
    int[] dataD = {
      -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
    };
    int digitalChannels = (digitalChannelIndicatorHigh << 8) + digitalChannelIndicatorLow;
    boolean digital = false;

    // Is Digital on in any of the 8 bits?
    for (int i=0; i < dataD.length; i++) { // add up the active channel indicators
      if ((digitalChannels & 1) == 1) { // by masking so we only see the last bit
        dataD[i] = 0;  // 0 means it's on, unlike -1 it's off
        digital = true;
      }
      digitalChannels = digitalChannels >> 1;
    }

    //System.out.println(digital);

    if (digital) {
      int digMSB = dataArray[16];
      int digLSB = dataArray[17];
      // Rob: what is int dig all about?
      int dig = (int)((digMSB << 8) + digLSB);
      for (int i = 0; i < dataD.length; i++) {
        if (dataD[i] == 0) {
          dataD[i] = dig & 1;
        }
        dig = dig >> 1;
      }
    }

    // Put Digital Data in object
    //addDigital(dataD);
    /*  print("Digital: ");
     for(int i=0; i<dataD.length; i++){
     print(dataD[i]); 
     print(" ,");
     }
     println();
     */
    // Process Analog 
    int[] dataADC = {
      -1, -1, -1, -1
    };
    int analogChannels = analogChannelIndicator; // Before, we shifted out a bit so just renaming var here

    for (int i=0; i < dataADC.length; i++) { // add up the active channel indicators
      if (i==0) {
        if ((analogChannels & 1) == 1) { // by masking so we only see the last bit
          int dataADCMSB = dataArray[dataArray.length-8];
          int dataADCLSB = dataArray[dataArray.length-7];
          dataADC[i] = int((dataADCMSB << 8) + dataADCLSB);
        }
      }
      if (i==1) {
        if ((analogChannels & 1) == 1) { // by masking so we only see the last bit
          int dataADCMSB = dataArray[dataArray.length-6];
          int dataADCLSB = dataArray[dataArray.length-5];
          dataADC[i] = int((dataADCMSB << 8) + dataADCLSB);
        }
      }

      if (i==2) {
        if ((analogChannels & 1) == 1) { // by masking so we only see the last bit
          int dataADCMSB = dataArray[dataArray.length-4];
          int dataADCLSB = dataArray[dataArray.length-3];
          dataADC[i] = int((dataADCMSB << 8) + dataADCLSB);
        }
      }

      if (i==3) {
        if ((analogChannels & 1) == 1) { // by masking so we only see the last bit
          int dataADCMSB = dataArray[dataArray.length-2];
          int dataADCLSB = dataArray[dataArray.length-1];
          dataADC[i] = int((dataADCMSB << 8) + dataADCLSB);
        }
      }

      analogChannels = analogChannels >> 1; // then shifting over one bit at a time as we go
    }

    //draw rectangles
     /*colours
 stroke(0, 255, 255);
 stroke(255, 0, 0);
  stroke(0, 255, 0);
  stroke(0, 0, 255);
 */
 
    //fill(255, 237, 0);
    fill(0, 255, 255);
    stroke(0, 255, 255);
    //rect(bar1_X, bar_Y + bar_height - dataADC[0]/10, bar_width, dataADC[0]/10);
    float bar1_values = (((float)dataADC[0]/1023) * 100) * 4;
    float bar2_values = (((float)dataADC[1]/1023) * 100) * 4;
    float bar3_values = (((float)dataADC[2]/1023) * 100) * 4;
    float bar4_values = (((float)dataADC[3]/1023) * 100) * 4;
    //bar1_values = (float)dataADC[0] / 1024;
    println(bar1_values);
    rect(bar1_X, bar_Y + bar_height - bar1_values, bar_width, bar1_values);
    
    fill(255, 0, 0);
    stroke(255, 0, 0);
    rect(bar2_X, bar_Y + bar_height - bar2_values, bar_width, bar2_values);
    
    fill(0, 255, 0);
    stroke(0, 255, 0);
    rect(bar3_X, bar_Y + bar_height - bar3_values, bar_width, bar3_values);
    
    fill(0, 0, 255);
    stroke(0, 0, 255);
    rect(bar4_X, bar_Y + bar_height - bar4_values, bar_width, bar4_values);
    
    fill(0);
    stroke(0);

    try {
      String time = Calendar.getInstance().getTime().toString();
      writer.write(time + "\t" + dataADC[0] + "\t" + dataADC[1] + "\t" + dataADC[2] + "\t" + dataADC[3] + "\n");
      writer.flush();
    } catch(IOException ioe) {
    }

    //Write values to screen
    
    fill(255, 237, 0);
    //humidityData = createFont("FFScala", 10);
    //textFont(humidityData);
    text(dataADC[0], bar1_X, value_Y);

    //tempData = createFont("FFScala", 10);
    //textFont(tempData);
    text(dataADC[1], bar2_X, value_Y);

    //lightData = createFont("FFScala", 10);
    //textFont(lightData);
    text(dataADC[2], bar3_X, value_Y);

    //stretchData = createFont("FFScala", 10);
    //textFont(stretchData);
    text(dataADC[3], bar4_X, value_Y);
    
    text("Last Report from " + addr + ":" +  LastReport, bar1_X, value_Y + 20);
    
    fill(250);


    for (int i=0; i<dataADC.length; i++) {
      print(dataADC[i]); 
      print(" ,");
    }
    println();

    if (addr == ECOIDS[0]) {
      for (int i=0; i<dataADC.length; i++) {
        finalPacket[0][i]=dataADC[i];
      }
    }

    if (addr == ECOIDS[1]) {
      for (int i=0; i<dataADC.length; i++) {
        finalPacket[1][i]=dataADC[i];
      }
    }

    println("addr = " + addr);
    for (int j=0; j<4; j++) {

      /*sendString = "http://www.eco-os.org/ecoidCollect.php?name=" + addr + sensorArray[j] + "&value=" + dataADC[j];
      println(sendString);
      String[] s = loadStrings(sendString);*/
    }

    for (int i=0; i<2; i++) {
      print("ecoid" + i);
      print(ECOIDS[i]);
      print(": ");
      for (int j=0; j<4; j++) {

        /*sendString = "http://www.eco-os.org/ecoidCollect.php?name=" + addr + sensorArray[j] + "&value=" + dataADC[j];
        println(sendString);
        String[] v = loadStrings(sendString)*/
        print(finalPacket[i][j]);
        print(", ");
      }
      println();
      LastReport = Calendar.getInstance().getTime().toString();
    } 
    // Put Analog in object
    //addAnalog(dataADC);
  }
}

public void setAddress16(int address) {
  sourceAddress16 = address;
}

public void setAddress64(long address) {
  sourceAddress64 = address;
}


public void setRSSI(int r) {
  rssi = -r;
}

public void setAddressBroadcast(boolean a) {
  addressBroadcast = a;
}

public void setPanBroadcast(boolean pan) {
  panBroadcast = pan;
}

public void setTotalSamples(int ts) {
  totalSamples = ts;
}

public void addDigital(int[] d) {
  digitalSamples.add(d);
  //digital = d;
}

public void addAnalog(int[] a) {
  analogSamples.add(a);
  //analog = a;
}

public void setApiID(int api_id) {
  apiId = api_id;
}

public int getApiID() {
  return apiId;
}

public int getAddress16() {
  // TODO Auto-generated method stub
  return sourceAddress16;
}

public long getAddress64() {
  // TODO Auto-generated method stub
  return sourceAddress64;
}

public int getRSSI() {
  return rssi;
}

public int[] getDigital() {
  return getDigital(0);
}

public int[] getAnalog() {
  return getAnalog(0);
}

public int[] getDigital(int index) {
  if (index < digitalSamples.size()) {
    return (int[]) digitalSamples.get(index);
  } 
  else {
    return null;
  }
}

public int[] getAnalog(int index) {
  if (index < analogSamples.size()) {
    return (int[]) analogSamples.get(index);
  } 
  else {
    return null;
  }
}
public int getTotalSamples() {
  return totalSamples;
}




//-----------------------------20673775781295449861861645291
//Content-Disposition: form-data; name="Item.Attachment.unused"

//0  

