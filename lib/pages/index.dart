import 'package:flutter/material.dart';

import 'package:pwdflutter/pages/gallery/gallery.dart';
import 'package:pwdflutter/pages/note/notes.dart';
import 'package:pwdflutter/pages/animation/animation.dart';

import 'package:pwdflutter/pages/tests/test_state.page.dart';

class IndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _IndexPage();
  }

}


class _IndexPage extends State<IndexPage> with AutomaticKeepAliveClientMixin {
  final List<Widget> _pages = [NotesPage(), GalleryPage(), AnimationPage(), TestSatePage()];
  final PageController _pageController = PageController();
  final List<BottomNavigationBarItem> tabs = [ 
    BottomNavigationBarItem(title: Text('笔记'), backgroundColor: Colors.red, icon: Icon(Icons.assignment)), 
    BottomNavigationBarItem(title: Text('游廊'), backgroundColor: Colors.red, icon: Icon(Icons.collections)),
    BottomNavigationBarItem(title: Text('动画'), backgroundColor: Colors.red, icon: Icon(Icons.gamepad)),
    BottomNavigationBarItem(title: Text('测试'), backgroundColor: Colors.red, icon: Icon(Icons.textsms)),
  ];
  
  int _current = 0;
  DateTime currentBackPressTime;
  
  @override
  bool get  wantKeepAlive => true;

  Future<bool> _onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      // ToastHelper.toast('双击退出');
      return Future.value(false);
    }
    return Future.value(true);
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: PageView(
          controller: _pageController,
          children: _pages,
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (v) {
             _current = v;
              setState(() {});
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _current,
        onTap: (int index) {
           _pageController.jumpToPage(index);
        },
        type: BottomNavigationBarType.fixed, // 大于3 需要设置为fixed 
        fixedColor: Colors.red,
        items: tabs,
      ),
    );
  }
}