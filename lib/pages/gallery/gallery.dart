import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import './gallery.service.dart';


class GalleryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GalleryPage();
  }
}

class _GalleryPage extends State<GalleryPage> with AutomaticKeepAliveClientMixin {
  final AppBar appBar = AppBar(
    title: Text('游廊'),
  );
  List<File> pics = [];

  bool get wantKeepAlive => true;

  getBattery() async {
    try {
      const platform = MethodChannel('cy.samples.flutter/battery');
      int res = await platform.invokeMethod('getBatteryLevel');
    } catch (e) {
    }
  }

  getPick() async {
      pics = await GalleryService().getPictrues();
      setState(() {
        
      });
  }


  @override
  void initState() {
    super.initState();
    getPick();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: ListView.builder(
        itemCount: pics.length,
        itemBuilder: (BuildContext context, int index) {
                      File file = pics[index];
            return Image.file(file);
        },
      ),
    );
  }
}
