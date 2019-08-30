import 'dart:convert';

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