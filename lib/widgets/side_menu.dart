import 'package:flutter/material.dart';
import 'package:radial_button/widget/circle_floating_button.dart';

class SideMenu extends StatefulWidget {
  SideMenu({Key key, @required this.child, this.leftMenuItems, this.rightMenuItems}) : super(key: key);

  final Widget child;
  final List<Widget> leftMenuItems;
  final List<Widget> rightMenuItems;

  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _animation;

  @override
  void initState() { 
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animation = Tween(begin: Offset(0, 0), end: Offset(0.1, 0)).animate(CurveTween(curve: Curves.linear).animate(_controller));
  }
  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: widget.child,
    );
  }
}