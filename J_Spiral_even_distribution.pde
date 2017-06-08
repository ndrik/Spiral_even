import geomerative.*;

int totalSegments = 1200; // length of the spiral
int stepLength = 15;
PVector[] points;
float innerBoundary = 100;
float outerBoundary = 1000;
RShape mySpiral;
RShape cleanSpiral;
RShape myLimits;

//////////////////EXPORTS///////////////////
import processing.dxf.*;
import processing.pdf.*;
import java.util.Calendar;
boolean savePDF = false;
boolean saveDXF = false;
boolean record = false;
String cadSoftware, ext;

void setup(){
  size(1000,1000);
  smooth();
  
  RG.init(this);
  
  myLimits = new RShape();
  initBoundaries(innerBoundary, outerBoundary);
  myLimits.translate(width/2, height/2);

  
  mySpiral = new RShape();
  points = getTheodorus(totalSegments,stepLength);
  theodorusSpiralInit(points, innerBoundary, outerBoundary);
  cleanSpiral = removeOverlaps(mySpiral);
  mySpiral.translate(width/2, height/2);

}

void draw(){

  //////////////////EXPORTS///////////////////
  if (record) beginRaw("superCAD."+cadSoftware, timestamp()+"."+ext);
  if (saveDXF) beginRaw(DXF, timestamp()+".dxf");
  if (savePDF) beginRecord(PDF, timestamp()+".pdf");
  //////////////////EXPORTS///////////////////
  
  background(155);
  //mySpiral.draw();
  cleanSpiral.draw();
  myLimits.draw();
  //drawAxis();

  //////////////////EXPORTS///////////////////
  if (savePDF) {
    savePDF = false;
    endRecord();
    println ("pdf saved...");
  }
  if (saveDXF) {
    saveDXF = false;
    endRaw();
    println ("dxf saved...");
  }  
  if (record) {
    endRaw();
    record = false;
  }
  //////////////////EXPORTS///////////////////
}


RShape removeOverlaps(RShape spiral){
  RShape cleanSpiral = new RShape();
  for(int i =0; i < spiral.children.length-1; i++){
    RShape shapeToCut = spiral.children[i];
    RShape cuttingShape = spiral.children[i+1];
    RShape cutShape = RG.diff(shapeToCut,cuttingShape);
    cleanSpiral.addChild(cutShape);
  }
  return cleanSpiral;
}

void drawAxis(){
  strokeWeight(1);
  stroke(255);
  line(width/2, 0, width/2, height);
  line(0, height/2, width, height/2);  
}


void initBoundaries(float inner, float outer){

  myLimits.addChild(RShape.createCircle(0, 0, inner));
  myLimits.addChild(RShape.createCircle(0, 0, outer));
  myLimits.setAlpha(0);
  myLimits.setStroke(2);
  myLimits.setStrokeWeight(2);  
}