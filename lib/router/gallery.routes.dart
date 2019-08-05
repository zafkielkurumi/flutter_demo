
import 'package:flutter/material.dart';
import 'package:pwdflutter/pages/preview/preview_image.dart';


Map<String, Function> galleryRoutes = {
'/preview_image' : (BuildContext context , {Map arguments}) => PreviewImagePage(initialIndex: arguments['initialIndex'], images: arguments['images'],),
};
