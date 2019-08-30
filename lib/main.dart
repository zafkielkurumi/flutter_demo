
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:jpush_flutter/jpush_flutter.dart';

import 'package:pwdflutter/pages/index.dart';
import 'package:pwdflutter/db/dbHelper.dart';
import 'package:pwdflutter/router/router.dart';
import 'package:pwdflutter/utils/chineseCupertinoLocalizations.dart';
import './app.dart';
import 'package:oktoast/oktoast.dart';

void _startupJpush()  {
    print("初始化jpush");
    JPush jPush = new JPush();
     jPush.setup(
      appKey: '9a7e2240d284a6ff015b946a',
      channel: 'developer-default'
    );
    print("初始化jpush成功");
 }

// void  main() => runApp(MyApp());
Future<Null> main() async {
  // 在应用之前做一些初始化
  await DbHelper().initDb();
 _startupJpush();
 runZoned((){

  runApp(new MyApp());
 }, onError: (Object obj, StackTrace stack) {
   print(obj);
   print(stack);
   print('出错了');
 });
  // runApp(new MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  MyApp() {
    init();
  }

  init() {
    // // todo 初始化项目，db http等 
    //    PaintingBinding.instance.imageCache.maximumSize = 100;

    // PaintingBinding.instance.imageCache.maximumSizeBytes = 100 << 20;

  }

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
      title: '笔记',
      navigatorKey: App.navigatorKey,
        localizationsDelegates: [
          ChineseCupertinoLocalizations.delegate,
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
  //           Brightness brightness, //深色还是浅色
  // MaterialColor primarySwatch, //主题颜色样本，见下面介绍
  // Color primaryColor, //主色，决定导航栏颜色
  // Color accentColor, //次级色，决定大多数Widget的颜色，如进度条、开关等。
  // Color cardColor, //卡片颜色
  // Color dividerColor, //分割线颜色
  // ButtonThemeData buttonTheme, //按钮主题
  // Color cursorColor, //输入框光标颜色
  // Color dialogBackgroundColor,//对话框背景颜色
  // String fontFamily, //文字字体
  // TextTheme textTheme,// 字体主题，包括标题、body等文字样式
  // IconThemeData iconTheme, // Icon的默认样式
  // TargetPlatform platform, //指定平台，应用特定平台控件风格
        ),
      onGenerateRoute: onGenerateRoute,
      home: IndexPage(),
    ),
    );
  }
}

