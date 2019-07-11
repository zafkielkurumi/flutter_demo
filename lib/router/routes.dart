import 'package:fluro/fluro.dart';
import './note.routes.dart';
import 'package:flutter/material.dart';

final List routes = []..addAll(noteRoutes);

class Routes {
  static void configRoutes(Router router) {
    // router.notFoundHandler = new Handler(
    //     handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    //   print("ROUTE WAS NOT FOUND !!!");
    // });
    routes.forEach((route) {
      router.define(
          route['url'],
          handler: route['handler'],
          transitionType: route['transitionType'] != null ?  route['transitionType'] : TransitionType.inFromRight
        );
    });
  }
}


