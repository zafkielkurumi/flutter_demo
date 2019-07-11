import 'package:flutter/material.dart';

// todo something
class Router {
  static push(BuildContext context, page, ) {
    return Navigator.push(
              context, MaterialPageRoute(builder: (context) => page));
  }
}