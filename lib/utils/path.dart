import 'dart:io';
import 'dart:async';

import 'package:flutter/services.dart';

class Pathhelper {
  static final String CHANNEL = "cy.samples.flutter/battery";
  final _channel = MethodChannel(CHANNEL);

  Future<String> getBasePath() async {
    try {
      final String basePath = await _channel.invokeMethod('getBasePath');
      return basePath;
    } catch (e) {
      print(e);
      return null;
    }
  }

  getDownloadDir() async {
    try {
      final String basePath = await getBasePath();
      Directory dir = new Directory(basePath + '/Download/com.cy');
      bool exist =  dir.existsSync();
      if (!exist) {
        dir.createSync(recursive: true);
      }
      return dir.path;
    } catch (e) {
      print('出错了');
      
    }
  }

  getPath(String path) async {
    try {
       final String basePath = await getBasePath();
        Directory dir = new Directory(basePath + '/$path');
        bool exist = dir.existsSync();
        if (!exist) {
          dir.createSync(recursive: true);
        }
        return dir.path;
    } catch (e) {
    }
  }
}
