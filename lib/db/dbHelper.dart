import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import './db_config.dart';
import './account.model.dart';


class DbHelper {
  Database _db;
  factory DbHelper() {
    return _getInstence();
  }

  static DbHelper _instence;

  DbHelper._internal() {
    print('database 实例化');
  }

  get  path async => await _initPath();
  static _getInstence() {
    if (_instence != null) {
      return _instence;
    }
    _instence = DbHelper._internal();
    return _instence;
  }

  Future<String> _initPath() async {
    final dbPath = await getDatabasesPath();
    return join(dbPath, dbName);
  }

  initDb() async {
    final path = await _initPath();
    bool isHasDb = await databaseExists(path);
    if (!isHasDb) {
      try {
        _db = await openDatabase(path, version: version,
            onCreate: (Database db, int version) async {
          // 建表
          
          await db.execute(AccountProvider.createTabel());
          print('数据库创建成功');
        });
      } catch (e) {
        print('数据库创建失败');
      }
      _db.close();
    } else {
      print('数据库存在');
    }
  }



  open() async {
     _db =  await openDatabase(await _initPath());
    return _db;
  }

  close() async {
    _db.close();
  }
}
