import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pwdflutter/utils/file.dart';
import 'package:path_provider/path_provider.dart';


class GalleryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GalleryPage();
  }
}

class _GalleryPage extends State<GalleryPage> {
  final AppBar appBar = AppBar(
    title: Text('游廊'),
  );


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
         
        },
      ),
      body: Stack(
        children: <Widget>[

        ],
      ),
    );
  }
}
