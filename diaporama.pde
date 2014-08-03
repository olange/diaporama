// import java.io.FilenameFilter;
import java.io.File;
import java.util.Iterator;
import codeanticode.syphon.*;

final String IMAGE_FOLDER = "data/set-04/";
final boolean SYPHON_OUTPUT = true;
final int resX = 6080; // 1280 * 2 + 1600 + 1920
final int resY = 1024;

SyphonServer server;
ArrayList<String> images;
java.util.Iterator imagesIter;
float fitFactor, fitHeightFactor, fitWidthFactor, imgWidth, imgHeight;
String imgPath;  
PImage img;

void setup() {
  if( SYPHON_OUTPUT) {
    size( resX, resY, P2D);
    server = new SyphonServer( this, "Processing sketch");
  } else {
    // size( 1540, 1200); Panasonic FC-32
    size( displayWidth, displayHeight);
    if( frame != null) { frame.setResizable( true); }
  }
  frameRate( 12);
  textSize( 16);
  imageMode( CENTER);
  images = filesInFolder( sketchPath( IMAGE_FOLDER));
  loadNext();
}

void draw() {
  background( 0);
  image( img, width/2, height/2, imgWidth, imgHeight);
  fill( 255);
  displayStatus();
  if( SYPHON_OUTPUT) { server.sendScreen(); }
}

void mousePressed() {
  loadNext();
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == RIGHT) {
      loadNext();
    } 
  } else if( key == ' ') {
      loadNext();
  }
}

void displayStatus() {
  text( str( displayWidth) + " x " + str( displayHeight) + "px (" + str( int( frameRate)) + " fps)\n"
        + "(" + width + " x " + height + "px actually used)\n"
        + imgPath, 50, 50);
}

void loadNext() {
  imgPath = nextImage();
  println( "Next: " + imgPath);
  img = loadImage( imgPath);
  imgWidth = (float)img.width;
  imgHeight = (float)img.height;
  fitWidthFactor = width / imgWidth;
  fitHeightFactor = height / fitHeightFactor;
  fitFactor = max( fitHeightFactor, fitWidthFactor);
  imgWidth = img.width * fitFactor;
  imgHeight = img.height * fitFactor;
}

String nextImage() {
  if( imagesIter == null || !imagesIter.hasNext()) {
    imagesIter = images.iterator();
  }
  String imgPath = (String)imagesIter.next();
  return imgPath;
}

ArrayList filesInFolder( String folderPath) {
  ArrayList<String> filesList = new ArrayList<String>();
  String fname;
  File folder = new File( folderPath);
  for (File file : folder.listFiles()) {
    if( file.isFile()) {
      fname = file.getAbsolutePath();
      if( fname.endsWith( ".jpg") || fname.endsWith( ".png")) {
        filesList.add( fname);
      }
    }
  }
  return( filesList);
}
