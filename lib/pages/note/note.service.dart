import 'package:pwdflutter/db/account.model.dart';
import 'package:pwdflutter/db/dbHelper.dart';
import 'package:sqflite/sqlite_api.dart';

class NoteService {
  static Future<List<Account>> getList() async {
    Database db = await DbHelper().open();
    AccountProvider accountProvider = AccountProvider(db);
    List<Account> list = await accountProvider.getList();
    accountProvider.clear();
    return list;
  }

  static addAccount( Account account) async {
    Database db = await DbHelper().open();
    AccountProvider accountProvider = AccountProvider(db);
    await accountProvider.insertDb(account);
    await db.close();
    return;
  }

  static updateAccount(Account account) async {
    Database db = await DbHelper().open();
    AccountProvider accountProvider = AccountProvider(db);
    await accountProvider.updateAccount(account);
    db.close();
    return;
  }

  static updatePassword(Account account) async {
    Database db = await DbHelper().open();
    AccountProvider accountProvider = AccountProvider(db);
    await accountProvider.getDetail(account.id);
    account.historyPassword.add({'password': account.password, 'updateTime':  DateTime.now()});
    await accountProvider.updateAccount(account);
    db.close();
    return;
  }
}
