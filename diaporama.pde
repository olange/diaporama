import java.util.Iterator;
import codeanticode.syphon.*;

final String IMAGE_FOLDER = "data/camo-20140921/";
final static int NUM_DMX_CHANNELS_WATCHED = 6;
final boolean SYPHON_OUTPUT = true;
final int resX = 6080; // = 1280 * 2 (Acer+Dell) + 1600 (Panasonic FC-32) + 1920 (AppleTV 1080p)
final int resY = 1024;

ArtNetListener artNetListener;
SyphonServer server;
ImageFileList images;
Iterator imagesIter;

float fitFactor, fitHeightFactor, fitWidthFactor, imgWidth, imgHeight;
String imgPath;  
PImage img;

void setup() {
  println( "Starting ...");

  if( SYPHON_OUTPUT) {
    size( resX, resY, P2D);
    server = new SyphonServer( this, "Processing sketch");
  } else {
    // size( 1540, 1200); Panasonic FC-32
    size( displayWidth, displayHeight);
    if( frame != null) { frame.setResizable( true); }
  }

  artNetListener = new ArtNetListener( 0, 0);

  frameRate( 12);
  textSize( 16);
  imageMode( CENTER);

  images = new ImageFileList( sketchPath( IMAGE_FOLDER));
  printImagesList();
  loadNext();
}

void exit() {
  println( "Exiting ...");
  artNetListener.stopArtNet();
  super.exit();
}

void draw() {
  watchDmxTriggers();
  background( 0);
  image( img, width/2, height/2, imgWidth, imgHeight);
  fill( 255);
  // displayStatus();
  if( SYPHON_OUTPUT) { server.sendScreen(); }
}

void watchDmxTriggers() {
  artNetListener.watchTriggers( NUM_DMX_CHANNELS_WATCHED);
  if( artNetListener.triggeredAt( 1) || artNetListener.triggeredAt( 2)) {
    loadNext();
  }
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

void printImagesList() {
  println( "List of images found in " + images.basePath + ":");
  for( String imagePath: images.filesList) {
    println( imagePath);
  }
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
    imagesIter = images.filesList.iterator();
  }
  String imgPath = (String)imagesIter.next();
  return imgPath;
}
