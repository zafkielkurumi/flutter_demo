import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pwdflutter/db/account.provider.dart';
import 'package:pwdflutter/models/account.model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:image_picker/image_picker.dart';

import 'package:pwdflutter/db/dbHelper.dart';
import 'package:pwdflutter/utils/path.dart';
import 'package:oktoast/oktoast.dart' as OkToast;

class FileUtil {
  exportDb() async {
    String path = await DbHelper().path;
    // await db.writeAsBytes(content, flush: true, mode: FileMode.append);
    String basePath = await Pathhelper().getDownloadDir();
    await Pathhelper().getDownloadDir();
    File db = new File(path);
    File outDb = new File(basePath + '/backageDb.db');
    List<int> content = db.readAsBytesSync();
    var sink = outDb.openWrite();
    sink.add(content);
    await sink.flush();
    await sink.close();
    OkToast.showToast('导出路径为${basePath}/backageDb.db');
    // Progresshud.showSuccessWithStatus('导出路径为${basePath}/backageDb.db');
  }

  importDb(String dbPath) async {
    String suffix = dbPath.substring(dbPath.lastIndexOf('.') + 1);
    if (suffix != 'db') {
      // Progresshud.showErrorWithStatus('导入失败,因为sqflite的db文件');
      OkToast.showToast('导入失败,因为sqflite的db文件');
      return;
    }
    File file = new File(dbPath);

    try {
      Database db = await openDatabase(dbPath);
      AccountProvider _accountProvider = new AccountProvider(db);
      List<Account> list = await _accountProvider.getList();
      db.close();
      db = await DbHelper().open();
      _accountProvider = new AccountProvider(db);

      for (var account in list) {
        account.id = null;
        await _accountProvider.insertDb(account);
      }
      db.close();
      // Progresshud.showErrorWithStatus('导入成功');
      OkToast.showToast('导入成功');
    } catch (e) {
      print(e);
      print('出哦了');
    }
  }


  getImage(ImageSource source) async {
    File file = await ImagePicker.pickImage(source: source);
    return file;
  }

  showdialog(BuildContext context) {
    showGeneralDialog(
        context: context,
        barrierLabel: '提示',
        barrierDismissible: true,
        transitionDuration: Duration(milliseconds: 100),
        barrierColor: Colors.black.withOpacity(0.5),
        pageBuilder: (BuildContext context, Animation animation,
            Animation secondaryAnimation) {
          return Center(
            child: Material(
              child: Container(
                width: 300,
                height: 120,
                color: Colors.white,
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('退出登录', style: TextStyle(fontSize: 18)),
                    Text('是否确认退出登录?'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        GestureDetector(
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              '取消',
                              style: TextStyle(color: Color(0XFF1A90FF)),
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Text('确定',
                                style: TextStyle(color: Color(0XFF1A90FF))),
                          ),
                          onTap: () {},
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
