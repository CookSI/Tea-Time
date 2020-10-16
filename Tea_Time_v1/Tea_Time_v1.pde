import org.openkinect.freenect.*;
import org.openkinect.processing.*;
import processing.serial.*;

import processing.video.*;

Movie video;


Serial myPort;  // Create object from Serial class
Kinect kinect;

float minThresh;
float maxThresh;
PImage img;

PImage bg;
 float [] xcordinates = {150, 585, 630, 1065, 1114, 1549};
 float [] ycordinates = {640, 726};
 int r = 255;
 int g = 0;
 int b = 0;
char option1 = '1';
char option2 = '1';
char option3 = '1';
 
void setup(){
  size(1680, 1040);
   //Video
  frameRate(30);
  video = new Movie(this, "Tea_Do.mp4");
  video.play();
  
  
  //Kinect
  kinect = new Kinect(this);
  kinect.initDepth();
  kinect.enableMirror(true);
  img = createImage(kinect.width*2+400, kinect.height*2, RGB);
  println(kinect.width, kinect.height);
  
  //Aruino
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
}

void movieEvent(Movie video) {
  video.read();
}

void draw(){
  
  image(video, 0, 0, width, height);
  float timeStamp = video.time();
  fill(255);
  textSize(32);
  text(timeStamp , 680 ,140);
  
    //Game States

    
    if(video.time() >= 36.291 && video.time() <= 40){
      video.pause();
      option1 = '0';
      option2 = '0' ;
      option3 = '1' ;
      println("set 1 option1: "+ option1);
      println("set 1 option2: "+ option2);
      println("set 1 option3: "+ option3);
    }else if(video.time() >= 47.39 && video.time() <= 50){
      video.pause();
      option1 = '0';
      option2 = '1' ;
      option3 = '0' ;
      println("set 1 option1: "+ option1);
      println("set 1 option2: "+ option2);
      println("set 1 option3: "+ option3);
    }else if(video.time() >= 68.4 && video.time() <= 70){
      video.pause();
      option1 = '0';
      option2 = '0' ;
      option3 = '1' ;
      println("set 1 option1: "+ option1);
      println("set 1 option2: "+ option2);
      println("set 1 option3: "+ option3);
    }
    else if(video.time() >= 83 && video.time() <= 90){
      video.pause();
      option1 = '1';
      option2 = '0' ;
      option3 = '0' ;
      println("set 1 option1: "+ option1);
      println("set 1 option2: "+ option2);
      println("set 1 option3: "+ option3);
    }else{
      video.play();
    }
  
  
  //set signal HIGH
  //myPort.write('1');
  
  //option boxes
  //rectMode(CORNER);
  //fill(0,250,232);
  //rect(xcordinates[0], 640, 435, 100);
  //rect(xcordinates[2], 640, 435, 100);
  //rect(xcordinates[4], 640, 435, 100);
  
  
  
  img.loadPixels();
  
 
  float xpixels =0;
  float ypixels =0;
  float totalpixels =0;
  float avgx = 0;
  float avgy = 0;
  
 
  minThresh = 400; 
  maxThresh = 540; 
  //get the depth values by looping through height and width  
  int[] depth = kinect.getRawDepth();
  
  for(int x=0; x < kinect.width; x++){
    for(int y=0; y < kinect.height; y++){
      int offset = x + y * kinect.width;
      int d = depth[offset];
      
      if(d > minThresh && d < maxThresh){
        img.pixels[offset] = color(0, 255, 0);
            xpixels = xpixels + x;
            ypixels = ypixels + y;
            totalpixels++;
            
      } else {
        img.pixels[offset] = color(0, 0, 0);
      }
      avgx = xpixels/totalpixels;
      avgy = ypixels/totalpixels;
    }
  }
  img.updatePixels();
  //image(img,0,0);
  
   //text(avgx + " " + avgy, 10, 64);
  //fill(255);
  //textSize(32);
  //text(minThresh + " " + maxThresh, 10, 64);
   

  //Draw video
  
  //Cursor
  float cursorx = avgx*2.5;
  float cursory = avgy*2.5;
  fill(r,g,b);
  ellipse(avgx*2.5, avgy*2.5,64,64);
  

  //option 1
    if(cursorx >= xcordinates[0] && cursorx <= xcordinates[1] && (cursory >= ycordinates[0] && cursory <= ycordinates[1])){
          r = 0;
          g = 255;
          b = 0;
          //set signal 
          myPort.write(option1);
          if(option1 == '1'){video.play();};
  //option 2
    }else if(cursorx >= xcordinates[2] && cursorx <= xcordinates[3] && (cursory >= ycordinates[0] && cursory <= ycordinates[1])){
          r=0;
          g=0;
          b=255;
          //set signal 
          myPort.write(option2);
          if(option2 == '1'){video.play();};
  //option 3
    }else if(cursorx >= xcordinates[4] && cursorx <= xcordinates[5] && (cursory >= ycordinates[0] && cursory <= ycordinates[1])){
          r=0;
          g=0;
          b=0;
          //set signal 
          myPort.write(option3);
          if(option3 == '1'){video.play();};
    }else{
       r=255;
       g=0;
       b=0;
       //myPort.write('1');
    }
}
