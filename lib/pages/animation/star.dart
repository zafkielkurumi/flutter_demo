import 'package:flutter/material.dart';
import './canvas.service.dart';

class StarView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _StarView();
  }
}

class _StarView extends State<StarView> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  Animation<Color> _animationColor;
  int startCount = 5;
  double ir = 30;
  double er = 75;
  Color color = Colors.pink;
  @override
  void initState() {
    // TODO: implement initState
    _controller =
        new AnimationController(duration: Duration(seconds: 3), vsync: this);
    _animation = new Tween(begin: 50.0, end: 150.0)
        .animate(CurveTween(curve: Curves.linear).animate(_controller))
          ..addListener(() {
            if (_animation.status == AnimationStatus.forward) {
              ++startCount;
            } else if (_animation.status == AnimationStatus.reverse) {
              --startCount;
            }
            ir = _animation.value - 10;
              er = _animation.value;
            setState(() {
             
            });
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _controller.reverse();
            } else if (status == AnimationStatus.dismissed) {
              _controller.forward();
            }
          });
    _animationColor = new ColorTween(begin: Colors.pink, end: Colors.yellow).animate(CurveTween(curve: Curves.linear).animate(_controller))
       ..addListener(() {

            setState(() {
             color = _animationColor.value;
            });
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _controller.reverse();
            } else if (status == AnimationStatus.dismissed) {
              _controller.forward();
            }
          });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
        child: CustomPaint(
          painter: StarPainter(
              context: context, starCount: startCount, ir: ir, er: er, color: color),
              child: RaisedButton(
                child: Text('start'),
                onPressed: () {
                  _controller.forward();
                },
              ),
        ),
      );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class StarPainter extends CustomPainter {
  BuildContext context;
  int starCount;
  double ir; // 内径
  double er; // 外径
  Color color;
  StarPainter(
      {@required this.context, this.starCount = 5, this.ir = 20, this.er = 75, this.color =  Colors.pink});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeWidth = 3;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    canvas.translate(width / 2, height / 2);
    canvas.drawPath(nStarPath(num: starCount, r: ir, R: er), paint);
  }

  @override
  bool shouldRepaint(StarPainter oldDelegate) {
    // TODO: 通过判断是否需要更新
    return true;
  }

  // @override
  // bool shouldRebuildSemantics(StarPainter oldDelegate) {
  //   return false;
  // }
}
