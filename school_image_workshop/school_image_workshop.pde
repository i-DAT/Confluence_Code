import processing.video.*;

//Settings
int fps = 2;
//3/4
int multipler = 1;
int w = 1280;
int h = 720;
int the_alpha = 0;
int the_frames = 0;
MovieMaker mm;

//Uncomment the line for the processing mode you want
//String mode = "alpha";
String mode = "speed";

//change this to the folder you want
//String the_file_path = "/Users/christopherhunt/Desktop/Testimages/";
//String the_file_path = "/Users/christopherhunt/Desktop/PROCESSING/alpha/GROUP4/1b/";
String the_file_path = "/Users/christopherhunt/Desktop/Confluence Project/Testimages/";

File path = new File(the_file_path);
String[] images = path.list();
int current_image_num = 0;
long total_image_num = (images.length - 1);

int [] alphas = new int[154];


void setup() {
  //set size, framerate
  size(w, h);  
  frameRate(fps);
  //sets up the MovieMaker object WARNING: This file will be HUGE. Strongly recomend ecoding the output file after using Quicktime/Handbreak
  mm = new MovieMaker(this, w, h, (the_file_path + "drawing.mov"), fps);
  println(total_image_num);
  println(mode);
  
//Dummy Wave Data for exercise. We could swap this out for an actual stream at a later date, Script is set up in a way so it only relys on the array alphas
alphas[0] = 233;
alphas[1] = 233;
alphas[2] = 199;
alphas[3] = 155;
alphas[4] = 188;
alphas[5] = 173;
alphas[6] = 122;
alphas[7] = 100;
alphas[8] = 90;
alphas[9] = 80; 
alphas[10] = 70;
alphas[11] = 65;
alphas[12] = 50;
alphas[13] = 40;
alphas[14] = 30;
alphas[15] = 20;
alphas[16] = 30;
alphas[17] = 40;
alphas[18] = 50;
alphas[19] = 60;
alphas[20] = 70;
alphas[21] = 80;
alphas[22] = 90;
alphas[23] = 100; 
alphas[24] = 110;
alphas[25] = 120;
alphas[26] = 130;
alphas[27] = 140;
alphas[28] = 150;
alphas[29] = 160;
alphas[30] = 170;
alphas[31] = 180;
alphas[32] = 190; 
alphas[33] = 200;
alphas[34] = 210;
alphas[35] = 220;
alphas[36] = 255;
alphas[37] = 255;
alphas[38] = 233;
alphas[39] = 233;
alphas[40] = 199;
alphas[41] = 155;
alphas[42] = 188;
alphas[43] = 173;
alphas[44] = 122;
alphas[45] = 100;
alphas[46] = 90;
alphas[47] = 80; 
alphas[48] = 70;
alphas[49] = 65;
alphas[50] = 50;
alphas[51] = 40;
alphas[52] = 30;
alphas[53] = 20;
alphas[54] = 30;
alphas[55] = 40;
alphas[56] = 50;
alphas[57] = 60;
alphas[58] = 70;
alphas[59] = 80;
alphas[60] = 90;
alphas[61] = 100; 
alphas[62] = 110;
alphas[63] = 120;
alphas[64] = 130;
alphas[65] = 140;
alphas[66] = 150;
alphas[67] = 160;
alphas[68] = 170;
alphas[69] = 180;
alphas[70] = 190; 
alphas[71] = 200;
alphas[72] = 210;
alphas[73] = 220;
alphas[74] = 255;
alphas[75] = 255;
alphas[76] = 233;
alphas[77] = 233;
alphas[78] = 199;
alphas[79] = 155;
alphas[80] = 188;
alphas[81] = 173;
alphas[82] = 122;
alphas[83] = 100;
alphas[84] = 90;
alphas[85] = 80; 
alphas[86] = 70;
alphas[87] = 65;
alphas[88] = 50;
alphas[89] = 40;
alphas[90] = 30;
alphas[91] = 20;
alphas[92] = 30;
alphas[93] = 40;
alphas[94] = 50;
alphas[95] = 60;
alphas[96] = 70;
alphas[97] = 80;
alphas[98] = 90;
alphas[99] = 100; 
alphas[100] = 110;
alphas[101] = 120;
alphas[102] = 130;
alphas[103] = 140;
alphas[104] = 150;
alphas[105] = 160;
alphas[106] = 170;
alphas[107] = 180;
alphas[108] = 190; 
alphas[109] = 200;
alphas[110] = 210;
alphas[111] = 220;
alphas[112] = 255;
alphas[113] = 255;
alphas[114] = 233;
alphas[115] = 233;
alphas[116] = 199;
alphas[117] = 155;
alphas[118] = 188;
alphas[119] = 173;
alphas[120] = 122;
alphas[121] = 100;
alphas[123] = 90;
alphas[124] = 80; 
alphas[125] = 70;
alphas[126] = 65;
alphas[127] = 50;
alphas[128] = 40;
alphas[129] = 30;
alphas[130] = 20;
alphas[131] = 30;
alphas[132] = 40;
alphas[133] = 50;
alphas[134] = 60;
alphas[135] = 70;
alphas[136] = 80;
alphas[137] = 90;
alphas[138] = 100; 
alphas[140] = 110;
alphas[141] = 120;
alphas[142] = 130;
alphas[143] = 140;
alphas[144] = 150;
alphas[145] = 160;
alphas[146] = 170;
alphas[147] = 180;
alphas[148] = 190; 
alphas[149] = 200;
alphas[150] = 210;
alphas[151] = 220;
alphas[152] = 255;
alphas[153] = 255;
}

void draw() {
  //clear screen
  //background(0);
 
 if (current_image_num > total_image_num){
    //check if we are at the end of the file list, close video, 
    mm.finish();
    println("finished!");
    exit();
 }
 else{
   //ignore .DS-Store (OSX system file) - may need expansion on other OSs
   if (! images[current_image_num].equals(".DS_Store")){
       PImage img;	
       //load next image
       img = loadImage(the_file_path+images[current_image_num]);
       
       if (mode == "alpha"){
         //for(int i=0; i<alphas[current_image_num]; i++){
           //draw next image to the stage with Alpha Value
           tint(255, alphas[current_image_num]);  
           image(img,0,0,w,h);
         //}
         //save frame to video file
         mm.addFrame();
       }
       else if(mode =="speed"){
       //fps speed up, slow down - repeat frame between 1 and 20 times
       
       //draw next image
       image(img,0,0,w,h);
       
             //get a mulitpler value from the alpha value
             multipler = round(alphas[current_image_num] / 50);
            
            if (multipler == 3){
              the_frames = 15;
            }
            else if (multipler == 2){
              the_frames = 7;
            }
            else if (multipler == 1){
              the_frames = 3;
            }
            else if (multipler == 0){
              the_frames = 1;
            }
        
        //loadPixels();
          //multiplys the number of frames saved to the video
          for(int i=0; i<the_frames; i++){ 
            mm.addFrame();
          }

       }
   }
  current_image_num++;
  
 }

  
}
