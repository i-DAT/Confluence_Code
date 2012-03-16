class EcoidReport {
  int sensor0,sensor1,sensor2,sensor3;
  String ID,Report;
  EcoidReport (String in_ID,String in_report,int in_sensor0,int in_sensor1,int in_sensor2,int in_sensor3){
    ID = in_ID;
    Report = in_report;
    sensor0 = in_sensor0;
    sensor1 = in_sensor1;
    sensor2 = in_sensor2;
    sensor3 = in_sensor3;
    println("added report " + ID + Report + str(sensor0) + str(sensor1) + str(sensor2) + str(sensor3));
  }
  public void PrintReport(){
    println("This Report " + ID + Report + str(sensor0) + str(sensor1) + str(sensor2) + str(sensor3));
  }
  
  public void DrawCircles(int X, int Y){
    float bar1_values = (((float)sensor0/1023) * 100);
    float bar2_values = (((float)sensor1/1023) * 100);
    float bar3_values = (((float)sensor2/1023) * 100);
    float bar4_values = (((float)sensor3/1023) * 100);
    
    
    fill(0);
    noFill();
    stroke(0, 255, 255);
    ellipse(X, Y, bar1_values, bar1_values);
    stroke(255, 0, 0);
    ellipse(X, Y, bar2_values, bar2_values);
    stroke(0, 255, 0);
    ellipse(X, Y, bar3_values, bar3_values);
    stroke(0, 0, 255);
    ellipse(X, Y, bar4_values, bar4_values);  
    stroke(0);
    
    fill(255, 237, 0);
    text("#:" + ID, X + 50, Y);
    text("humid:" + str(sensor0), X + 50, Y + 14);
    text("temp:" + str(sensor1), X + 50, Y + (14 * 2));
    text("light:" + str(sensor2), X + 50, Y + (14 * 3));
    text("stretch:" + str(sensor3), X + 50, Y + (14 * 4));
    text("Report:" + Report, X + 50, Y + (14 * 5));
    fill(250);
    
  }
  
}
