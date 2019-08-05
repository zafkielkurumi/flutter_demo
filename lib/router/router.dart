import 'package:flutter/material.dart';
import './note.routes.dart';
import './gallery.routes.dart';

Map<String, Function>  routes = {...noteRoutes, ...galleryRoutes};
// todo something
var onGenerateRoute = (RouteSettings settings) {
  final String name = settings.name;
  final Function routerBuilder =  routes[name];
  Route route = MaterialPageRoute(builder: (context) => routerBuilder(context, arguments: settings.arguments));
  return route;
};
