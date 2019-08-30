import 'package:pwdflutter/models/account.model.dart';
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
