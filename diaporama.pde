/**
 * This example demonstrates how to use the features of the FileUtils and
 * FileSequenceDescriptor classes to display a file dialog box and to easily
 * load numbered images sequence through means of an standard iterator.
 *
 * Usage:
 * The file chooser automatically is pointed to this sketch's data folder
 * from which you should choose the first image of the sequence. The sketch
 * will then load all images in the identified sequence and display them.
 */

/* 
 * Copyright (c) 2010 Karsten Schmidt
 * 
 * This demo & library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 * 
 * http://creativecommons.org/licenses/LGPL/2.1/
 * 
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 */

// import java.io.FilenameFilter;
import java.io.File;
import java.util.Iterator;

final String IMAGE_FOLDER = "data/";

ArrayList<String> images;
java.util.Iterator imagesIter;
String imgPath;
PImage img;

void setup() {
  size( 720, 720);
  textSize( 9);
  images = filesInFolder( sketchPath( IMAGE_FOLDER));
}

void draw() {
  background( 0);

  imgPath = nextImage(); 
  img = loadImage( imgPath);
  image( img, 0, 0, width, height);

  fill( 255, 0, 0);
  text( imgPath, 10, height-50, width-20, 50);
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
      fname = file.getName();
      if( fname.endsWith( ".jpg") || fname.endsWith( ".png")) {
        filesList.add( fname);
      }
    }
  }
  return( filesList);
}
