import 'package:flutter/material.dart';
class ShareInherited extends InheritedWidget {
  final int data;
  ShareInherited({@required this.data, Widget child}): super(child: child);

  static ShareInherited of (BuildContext context, {bool listen = true}) {
    // return context.ancestorInheritedElementForWidgetOfExactType(ShareInherited).widget; // 不会进行注册
    return listen ? context.inheritFromWidgetOfExactType(ShareInherited) : context.ancestorInheritedElementForWidgetOfExactType(ShareInherited).widget;
  }

  @override
  bool updateShouldNotify(ShareInherited oldWidget) {
    // TODO: implement updateShouldNotify
    return oldWidget.data != data;
  }
}