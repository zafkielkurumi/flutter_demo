import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:io';
import 'dart:math' as math;

import 'package:image_picker/image_picker.dart';

import 'package:pwdflutter/utils/file.dart';
import './canvas.service.dart';
import './star.dart';

class AnimationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AnimationPage();
  }
}

class _AnimationPage extends State<AnimationPage>
    with SingleTickerProviderStateMixin {
  PersistentBottomSheetController controller;
  double r = 80;
  AnimationController _animationController;
  CurvedAnimation _curve;
  Tween _tween = new Tween(begin: 75.0, end: 90.0);
  Animation<double> animation;
  var image;
  String txt = 'start';
  @override
  void initState() {
    // Tween 要使用需要使用 animate 方法传入controller
    _animationController =
        new AnimationController(duration: Duration(seconds: 2), vsync: this);
    // _curve = new CurvedAnimation(parent: _animationController, curve: Curves.easeInCirc)..addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     _animationController.reverse();
    //   } else if (status == AnimationStatus.dismissed) {
    //     _animationController.forward();
    //   }
    // });

    animation = Tween(begin: 120.0, end: 75.0).animate(
        CurveTween(curve: Curves.linear).animate(_animationController)
          ..addListener(() {
            setState(() {
              r = animation.value;
            });
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
                setState(() {
                 txt = 'start'; 
                });
              _animationController.reverse();
            } else if (status == AnimationStatus.dismissed) {
              setState(() {
               txt = 'end'; 
              });
              _animationController.forward();
            }
          }));
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
          onPressed: () async {
            _animationController.forward();
          },
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
                        painter: StartPanter(image: image, wr: r),
                      ),
                    ),
                  )
                : RaisedButton(
                    child: Text('选择图片'),
                    onPressed: () {
                      choseImage();
                    },
                  ),
            StarView(),
            Container(
              height: animation.value,
              width: animation.value,
              color: Colors.pink,
            ),
            AnimatedSwitcher(
              duration: Duration(seconds: 1),
              child: Text('$txt', 
              key: ValueKey(txt),),
              // Flutter API提供的关于AnimatedWidget的示例包括：AnimatedBuilder、AnimatedModalBarrier、DecoratedBoxTransition、
              // FadeTransition、PositionedTransition、
              // RelativePositionedTransition、RotationTransition、ScaleTransition、SizeTransition、SlideTransition。
               transitionBuilder: (child, anim) {
                      return RotationTransition(child: child, turns: anim);
              },
              
            ),
            AnimeView()
          ],
        ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

// CustomPainter demo
class StartPanter extends CustomPainter {
  ui.Image image;
  double wr;
  StartPanter({this.image, this.wr = 75});

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
      canvas.drawPath(nStarPath(num: 5, r: 30, R: wr), paint);
      canvas.translate(width - 160, 0);
      canvas.drawPath(nStarPath(num: 5, r: 30, R: wr), paint);
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
        duration: const Duration(milliseconds: 2000), vsync: this)..repeat();
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
          // child: FadeTransition(
          //   opacity: curve,
          //   child: Icon(Icons.ac_unit),
          // ),
          child: Spinning(controller: controller,),
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

// AnimatedWidget demo
class Spinning extends AnimatedWidget {
   const Spinning({Key key, AnimationController controller})
       : super(key: key, listenable: controller);

  Animation<double> get _progress => listenable;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Transform.rotate(
      angle: _progress.value * 2 * math.pi,
      child: Container(
        width: 100,
        height: 100,
        color: Colors.pink,
      ),
    );
  }
}
