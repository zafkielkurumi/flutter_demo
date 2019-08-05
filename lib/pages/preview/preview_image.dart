import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PreviewImagePage extends StatefulWidget {
  final List images;
  final int initialIndex;
  PreviewImagePage({@required this.images, @required this.initialIndex});
  @override
  State<StatefulWidget> createState() {
    return _PreviewImagePage();
  }
}


class _PreviewImagePage extends State<PreviewImagePage> {
  int currentIndex;
  PageController _pageController;
  @override
  void initState() {
    currentIndex = widget.initialIndex;
    _pageController = new PageController(initialPage: currentIndex);
    super.initState();
  }

  void onPageChanged(index) {
    setState(() {
     currentIndex = index; 
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: PhotoViewGallery.builder(
          scrollPhysics: const BouncingScrollPhysics(),
          backgroundDecoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor
          ),
          builder: (BuildContext context, int index) {
            var image = widget.images[index];
            return PhotoViewGalleryPageOptions(
              
              imageProvider:  FileImage(image),
              initialScale: PhotoViewComputedScale.contained * 0.9,
              heroTag: image.path,
            );
          },
          itemCount: widget.images.length,
          pageController: _pageController,
          onPageChanged: onPageChanged,
        ),
      ),
    );
  }
}