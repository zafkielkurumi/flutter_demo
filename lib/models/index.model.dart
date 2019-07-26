import 'package:flutter/material.dart';
class TabItem {
  String title;
  Widget icon;
  Widget activeIcon;

  TabItem({
    @required this.title, 
    @required this.icon, 
    Widget activeIcon}): activeIcon = activeIcon ?? icon,
     assert(title != null, icon != null,);
}