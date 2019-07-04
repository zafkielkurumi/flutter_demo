import 'package:flutter/material.dart';

import 'package:pwdflutter/pages/index.dart';
import 'package:pwdflutter/pages/note/notes.dart';

// void  main() => runApp(MyApp());
Future<Null> main() async {
  // await 大概可以在应用之前做一些初始化
  runApp(new MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  MyApp() {
    init();
  }

  init() {
    // todo 初始化项目，db http等 
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: NotesPage(),
    );
  }
}

