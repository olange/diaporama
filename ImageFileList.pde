import java.io.File;
// import java.io.FilenameFilter;
import java.util.Iterator;

class ImageFileList {

  ArrayList<String> filesList;
  String basePath;

  ImageFileList( String basePath) {
    this.basePath = basePath;
    this.filesList = new ArrayList<String>();
    refreshList();
  }

  void refreshList() {
    this.filesList = filesInFolder( this.basePath);
  }

  ArrayList filesInFolder( String folderPath) {
    ArrayList<String> filesList = new ArrayList<String>();
    String fname, fnameLC;
    File folder = new File( folderPath);
    for (File file : folder.listFiles()) {
      // if( file.isDirectory()) { … we could recurse into file.listFiles() … }
      if( file.isFile()) {
        fname = file.getAbsolutePath();
        fnameLC = fname.toLowerCase();
        if( fnameLC.endsWith( ".jpg") || fnameLC.endsWith( ".jpeg")
            || fnameLC.endsWith( ".png") || fnameLC.endsWith( ".gif")
            || fnameLC.endsWith( ".tif") || fnameLC.endsWith( ".tiff")) {
          filesList.add( fname);
        }
      }
    }
    return( filesList);
  }
}
