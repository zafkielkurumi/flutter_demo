import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:pwdflutter/utils/file.dart';
import './canvas.service.dart';

class AnimationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AnimationPage();
  }
}

class _AnimationPage extends State<AnimationPage> {
  PersistentBottomSheetController controller;
  var image;
  @override
  void initState() {
    super.initState();
  }

  choseImage() {
    controller = showBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 120,
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text('相机'),
                  onTap: () async {
                    File file = await FileUtil().getImage(ImageSource.camera);
                    controller.close();
                    if (file != null) {
                      image = await _loadImage(file);
                      setState(() {});
                    }
                  },
                ),
                ListTile(
                  leading: Icon(Icons.add_photo_alternate),
                  title: Text('相册'),
                  onTap: () async {
                    File file = await FileUtil().getImage(ImageSource.gallery);
                    controller.close();
                    if (file != null) {
                      image = await _loadImage(file);
                      setState(() {});
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  Future<ui.Image> _loadImage(File file) async {
    final data = await file.readAsBytes();
    return await decodeImageFromList(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {},
        ),
        body: ListView(
          children: <Widget>[
            image != null
                ? FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: image != null ? image.width.toDouble() : 300,
                      height: image != null ? image.height.toDouble() : 300,
                      child: CustomPaint(
                        painter: StartPanter(image: image),
                      ),
                    ),
                  )
                : RaisedButton(
                    child: Text('选择图片'),
                    onPressed: () {
                      choseImage();
                    },
                  ),
            AnimeView(),
            FittedBox(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                    // valueColor: ,
                    ),
              ),
            ),
            Opacity(
              opacity: 0.6,
              child: Text('data'),
            )
          ],
        ));
  }
}

class StartPanter extends CustomPainter {
  ui.Image image;
  StartPanter({this.image});

  @override
  void paint(Canvas canvas, Size size) {
    if (image != null) {
      double width = image.width.toDouble();
      double height = image.height.toDouble();
      Paint paint = new Paint()
        ..style = PaintingStyle.fill
        ..color = Colors.pink
        ..strokeWidth = 1;
      canvas.drawImage(image, Offset(0, 0), paint);
      canvas.drawCircle(Offset(75, 75), 50, paint);
      canvas.translate(80, height / 2);
      canvas.drawPath(nStarPath(5, 30, 80), paint);
      canvas.translate(width - 160, 0);
      canvas.drawPath(nStarPath(5, 30, 80), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: 通过判断是否需要更新
    return true;
  }
}

class AnimeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AnimeView();
  }
}

class _AnimeView extends State<AnimeView> with TickerProviderStateMixin {
  AnimationController controller;
  CurvedAnimation curve;
  Tween colorTween;
  @override
  void initState() {
    controller = new AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    curve = new CurvedAnimation(parent: controller, curve: Curves.easeIn);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: <Widget>[
        Container(
          // width: 100,
          // height: 100,
          child: FadeTransition(
            opacity: curve,
            child: Icon(Icons.ac_unit),
          ),
        ),
        RaisedButton(
          onPressed: () {
            controller.forward();
          },
          child: Icon(Icons.ac_unit),
        )
      ],
    );
  }
}
