import 'dart:convert';
import 'package:sqflite/sqflite.dart';

final tableName = 'account';
final colId = 'id';
final colWebName = 'webName';
final colAccount = 'account';
final colPassword = 'password';
final colSalt = 'salt';
final colGenTime = 'genTime';
final colHistoryPassword = 'historyPassword';
final colEmail = 'email';
final colPhone = 'phone';
final colUpdateTime = 'updateTime';

class Account {
  int id;
  String webName;
  String account;
  String password;
  String salt;
  String email;
  String phone;
  DateTime updateTime;
  DateTime genTime;
  List<dynamic> historyPassword;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      colWebName: webName,
      colAccount: account,
      colPassword: password,
      colEmail: email,
      colPhone: phone,
      colUpdateTime: DateTime.now().millisecondsSinceEpoch,
      colSalt: salt
    };
    map[colHistoryPassword] =  json.encode(historyPassword ?? []);
    map[colGenTime] = genTime != null ? genTime.millisecondsSinceEpoch : DateTime.now().millisecondsSinceEpoch;
    return map;
  }

  Account();

  Account.fromMap(Map<String, dynamic> map) {
    id = map[colId];
    account = map[colAccount].toString();
    password = map[colPassword].toString();
    webName = map[colWebName].toString();
    email = map[colEmail].toString();
    phone =  map[colPhone].toString(); // 不知道为啥纯数字的字符串查出来是int
    updateTime = map[colUpdateTime] != null ? DateTime.fromMillisecondsSinceEpoch(map[colUpdateTime]) : null;
    salt = map[colSalt].toString();
    genTime = DateTime.fromMillisecondsSinceEpoch(map[colGenTime]);
    if (map[colHistoryPassword] != null) {
      historyPassword = json.decode(map[colHistoryPassword]);
      // historyPassword = historyPassword.reversed;
    }
  }
}

class AccountProvider {
  Database db;

  AccountProvider(this.db);

  static createTabel() {
    return '''
      create table $tableName ( 
        $colId INTEGER PRIMARY KEY AUTOINCREMENT, 
        $colWebName TEXT not null,
        $colPassword TEXT not null,
        $colSalt TEXT,
        $colHistoryPassword String,
        $colEmail String,
        $colPhone String,
        $colUpdateTime INTEGER,
        $colGenTime INTEGER not null,
        $colAccount TEXT not null)
        ''';
  }

  Future<Account> insertDb(Account account) async {
    account.id = await db.insert(tableName, account.toMap());
    return account;
  }

  Future<List> rawInsert(List accounts) async {
   int id = await  db.rawInsert('insert into $tableName', accounts);
   return accounts;
  }

  Future<int> updateAccount(Account account) async {
    return await db.update(tableName, account.toMap(), where: '$colId = ?', whereArgs: [account.id]);
  }


  Future<List<Account>> getList({limit = 10, page = 1, searchKey = ''}) async {
    final offset = (page - 1) * limit;
    List<Map> list = await db.query(tableName,
      where: '$colWebName like ? or $colAccount like ?',
      whereArgs: ['%$searchKey%', '%$searchKey%']
    );

    return List.generate(list.length, (i){
      return Account.fromMap(list[i]);
    });
  }

  Future<Account> getDetail(int id) async {
    var res = await db.query(tableName, where: '$colId = ?', whereArgs: [id]);
    return res.isNotEmpty ? Account.fromMap(res.first) : null;
  }

  Future<int> deleteAccount(int id) async {
    var res = await db.delete(tableName,  where: '$colId = ?', whereArgs: [id]);
    return res;
  }

  void clear() async => await db.close();
}
