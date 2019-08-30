
import 'package:flutter/material.dart';

import 'package:pwdflutter/router/test.routes.dart';

class TestSatePage extends StatelessWidget {
  TestSatePage({Key key}) : super(key: key);


// translate 1.0.0
  @override
  Widget build(BuildContext context) {
    return ListView(
         children: <Widget>[
           ListTile(
             title: Text('providerMe'),
             onTap: () {
               Navigator.of(context).pushNamed(TestRoutes.testProviderMe);
             },
           ),
           ListTile(
             title: Text('form'),
             onTap: () {
               Navigator.of(context).pushNamed(TestRoutes.testForm);
             },
           ),
             ListTile(
             title: Text('providerGoogle'),
             onTap: () {
               Navigator.of(context).pushNamed(TestRoutes.testProviderGoogle);
             },
           ),
         ]
       );
  }
}


//     print('视图树装载过程
// StatelessWidget
// 首先它会调用StatelessWidget的 createElement 方法，并根据这个widget生成StatelesseElement对象。
// 将这个StatelesseElement对象挂载到element树上。
// StatelesseElement对象调用widget的build方法，并将element自身作为BuildContext传入。
// StatefulWidget

// 首先同样也是调用StatefulWidget的 createElement方法，并根据这个widget生成StatefulElement对象，并保留widget引用。
// 将这个StatefulElement挂载到Element树上。
// 根据widget的 createState 方法创建State。
// StatefulElement对象调用state的build方法，并将element自身作为BuildContext传入。

// 所以我们在build函数中所使用的context，正是当前widget所创建的Element对象。
// ');


