
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:pwdflutter/pages/index.dart';
import 'package:pwdflutter/db/dbHelper.dart';
import 'package:pwdflutter/router/router.dart';

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
       theme: ThemeData(
          scaffoldBackgroundColor: Color(0xffF2F2F2),
          primaryColor: Colors.pink,
          textTheme: TextTheme(),
          appBarTheme: AppBarTheme(
            textTheme: TextTheme(
              title: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      onGenerateRoute: onGenerateRoute,
      home: IndexPage(),
    );
  }
}

