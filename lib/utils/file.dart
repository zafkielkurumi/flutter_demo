import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:ovprogresshud/progresshud.dart';
import 'package:pwdflutter/db/dbHelper.dart';
import 'package:pwdflutter/db/account.model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:pwdflutter/utils/path.dart';

import 'package:flustars/flustars.dart';

class FileUtil {
  copyFile(String path) async {
    File oldFile = new File(path);
    Directory dir = await getExternalStorageDirectory();
    String fileName = path.substring(path.lastIndexOf('/') + 1);
    File newFile = new File(dir.path + '/$fileName');
    List<int> content = oldFile.readAsBytesSync();
    var sink = newFile.openWrite();
    sink.add(content);
    await sink.flush();
    await sink.close();
  }

  exportDb() async {
    String path = await DbHelper().path;
    // Directory dir = await getExternalStorageDirectory();
    String basePath = await Pathhelper().getDownloadDir();
    await Pathhelper().getDownloadDir();
    File db = new File(path);
    File outDb = new File(basePath + '/backageDb.db');
    List<int> content = db.readAsBytesSync();
    var sink = outDb.openWrite();
    sink.add(content);
    await sink.flush();
    await sink.close();
    Progresshud.showSuccessWithStatus('导出路径为${basePath}/backageDb.db');
  }

  importDb(String dbPath) async {
    String suffix = dbPath.substring(dbPath.lastIndexOf('.') + 1);
    if (suffix != 'db') {
      Progresshud.showErrorWithStatus('导入失败,因为sqflite的db文件');
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
        Progresshud.showErrorWithStatus('导入成功');
    } catch (e) {
      print(e);
      print('出哦了');
    }
  }

  writeTest(String path) async {
    DirectoryUtil.getStoragePath();

    Directory dir = await getExternalStorageDirectory();
    File nowDb = new File(path);
    File db = new File(dir.path + '/my.txt');
    // db.writeAsStringSync('我顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶');

    List<int> content = nowDb.readAsBytesSync();
    // await db.writeAsBytes(content, flush: true, mode: FileMode.append);
    // await db.writeAsBytes(content, flush: true, mode: FileMode.append);
    await db.writeAsString('无法圣诞节快乐附件是', flush: true, mode: FileMode.append);
    var sink = db.openWrite(mode: FileMode.append);
    sink.write('上帝就发刷卡积分');
    sink.add(content);
    await sink.flush();
    await sink.close();
  }
}
