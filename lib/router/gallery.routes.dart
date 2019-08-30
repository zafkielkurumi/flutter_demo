
import 'package:flutter/material.dart';
import 'package:pwdflutter/pages/preview/preview_image.dart';


abstract class GalleryRoutes {
  static String previewImage = '/preview_image';
}

Map<String, Function> galleryRoutes = {
'/preview_image' : (BuildContext context , {Map arguments}) => PreviewImagePage(initialIndex: arguments['initialIndex'], images: arguments['images'],),
};
