
// import java.io.FilenameFilter;
import java.io.File;
import java.util.Iterator;

final String IMAGE_FOLDER = "data/set-01/";

ArrayList<String> images;
java.util.Iterator imagesIter;
float fitFactor, fitHeightFactor, fitWidthFactor, imgWidth, imgHeight;
String imgPath;  
PImage img;

void setup() {
  // size( 1540, 1200); Panasonic FC-32
  size( displayWidth, displayHeight);
  textSize( 16);
  imageMode( CENTER);
  images = filesInFolder( sketchPath( IMAGE_FOLDER));
  loadNext();
}

void draw() {
  background( 0);
  image( img, width/2, height/2, imgWidth, imgHeight);
  fill( 255);
  text( str( displayWidth) + " x " + str( displayHeight) + "px (" + str( int( frameRate)) + " fps)\n"
        + "(" + width + " x " + height + "px actually used)", 50, height-100);
}

void mousePressed() {
  loadNext();
}

void loadNext() {
  imgPath = nextImage(); 
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
