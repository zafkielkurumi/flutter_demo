import 'dart:io';

import 'package:pwdflutter/utils/path.dart';



class GalleryService {
  static final String picPath = '狂三';
  getPictrues() async {
    var path = await Pathhelper().getPath(picPath);
    Directory dir = new Directory(path);
     List<FileSystemEntity> fileSystemEntity = dir.listSync();
     List<File> pic = [];
     for (var item  in fileSystemEntity)  {
       bool isFile = FileSystemEntity.isFileSync(item.path);
       if (isFile) {
         pic.add(new File(item.path));
       }
     }
     return pic;
  }
}