//class for grabing XBee packets from the Co-Ord. Pre-Supplied
public int[] getPacket() {
    boolean gotAPacket = false;    // whether the first byte was 0x7E
    int packetLength = -1;         // length of the dataArray
    int[] thisdataArray = null;    // the dataArray to return
    int checksum = -1;             // the checksum as received
    int localChecksum = -1;        // the chacksum as we calculate it

    // read bytes until you get a 0x7E
    port.clear(); // flush the buffer so that no old data comes in

    while (port.available() < 1) {
      ; // do nothing while we wait for the buffer to fill
    }

    // this is a good header. Get ready to read a packet
    if (port.read() == 0x7E) {
      gotAPacket = true;
      println("got packet!");
    }

    // if the header byte is good, try the rest:
    if (gotAPacket) {
      // read two bytes
      while (port.available() < 2) {
        ; // wait until you get two bytes of length
      }
      int lengthMSB = port.read(); // high byte for length of packet
      int lengthLSB = port.read(); // low byte for length of packet

      // convert to length value
      packetLength = (lengthLSB + (lengthMSB << 8));
      if (DEBUG) System.out.println("length: " + packetLength);

      // read bytes until you've reached the length
      while (port.available() < packetLength) {
        ; // do nothing while we wait for the buffer to fill
      }
      // make an array to hold the data frame:
      thisdataArray = new int[packetLength];

      // read all the bytes except the last one into the dataArray array:
      for (int thisByte = 0; thisByte < packetLength; thisByte++) {
        thisdataArray[thisByte] = port.read(); 
        //if (DEBUG) System.out.print(parent.hex(thisdataArray[thisByte], 2) + " ");
      }
      //println("data: " + thisdataArray);
      
      while (port.available() < 1) {
        ; // do nothing while we wait for the buffer to fill
      }
      // get the checksum:
      checksum = port.read();
      //println("checksum: " + checksum);
      
      
      // calculate the checksum of the received dataArray:
      localChecksum = checkSum(thisdataArray);
      //println("localchecksum:" + localChecksum);
      // if they're not the same, we have bad data:
      if ( localChecksum != checksum) {
       // if (DEBUG) System.out.println("bad checksum. Local: " + parent.hex(localChecksum%256));
       // if (DEBUG) System.out.println("  remote: " + parent.hex(checksum));
        // if the checksums don't add up, clear the dataArray array:
        //println("WRONG!!!");
        thisdataArray = null;
      } 
    }
    // makes a nice printing for debugging:
    if (DEBUG) System.out.println();

    // return the data frame.  If it's null, you got a bad packet.
    return thisdataArray;
  }
  
  
  ////////////////////////////
  
  
   // calculate the checksum
  private int checkSum(int[] thisArray) {
    byte ck = 0;
    // add all the bytes:
    for (int i = 0; i < thisArray.length; i++) {
      ck += (byte)(thisArray[i]);
    } 
    // subtract the result from 0xFF.
    // note that it should be only one byte, that's why we 
    // convert it to a byte. then back to an int to return it

    ck = (byte)(0xFF - ck);
    //println("LOCALchecksum:" + int(ck));
    int rv = int(ck);
    return rv;
  }

  
  
  
