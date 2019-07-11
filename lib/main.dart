import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:pwdflutter/pages/index.dart';
import 'package:pwdflutter/pages/note/notes.dart';
import 'package:pwdflutter/db/dbHelper.dart';
import 'package:pwdflutter/router/routes.dart';
import './app.dart';

// void  main() => runApp(MyApp());
Future<Null> main() async {
  // 在应用之前做一些初始化
  await DbHelper().initDb();
  runApp(new MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  MyApp() {
    init();
  }

  init() {
    // todo 初始化项目，db http等 
    final Router router = new Router();
     Routes.configRoutes(router);
    App.router = router;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: [                             
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [                                   
        const Locale('zh','CH'),
        const Locale('en','US'),
      ],
      onGenerateRoute: App.router.generator,
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
        primarySwatch: Colors.pink,
      ),
      home: NotesPage(),
    );
  }
}

