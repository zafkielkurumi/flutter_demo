import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageHeler {
  static String assets(String url) {
    return 'assets/images' + url;
  }

  static Widget placeHoder() {
    return SizedBox(
      child: CupertinoActivityIndicator(
        
      ),
    );
  }

  static Widget error() {
    return Icon(Icons.error);
  } 



}