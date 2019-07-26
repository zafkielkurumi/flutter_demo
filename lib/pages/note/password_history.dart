import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PasswordHistory extends StatelessWidget {
  List _historys = [];
  PasswordHistory(this._historys);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('密码修改历史'),),
      body: ListView.builder(
        itemCount: _historys.length,
        itemBuilder: (BuildContext context, int index) {
          final history = this._historys[index];
          return ListTile(
            title: Text('${history['password'] ?? ''}'),
            trailing: Text('${history['updateTime'] != null ? DateFormat('yyyy-MM-dd').format(DateTime.fromMillisecondsSinceEpoch(history['updateTime'])) : ''}'),
          );
        },
      ),
    );
  }
}