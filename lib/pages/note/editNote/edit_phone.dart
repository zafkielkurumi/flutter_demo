import 'package:flutter/material.dart';

import 'package:pwdflutter/db/account.model.dart' show Account;
import '../note.service.dart';

class EditPhonePage extends StatefulWidget {
  final Account _account;

  EditPhonePage(this._account);
  @override
  State<StatefulWidget> createState() {
    return _EditPhone();
  }
 
}

class _EditPhone extends State<EditPhonePage> {
    GlobalKey<FormFieldState> _key = new GlobalKey<FormFieldState>();
  @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('修改手机号'),
        actions: <Widget>[
          FlatButton(
            onPressed: () async {
              if (_key.currentState.validate()) {
                _key.currentState.save();
                await NoteService.updateAccount(widget._account);
                Navigator.pop(context);
              }
            },
            child: Text('保存', style: TextStyle(color: Colors.white),),
          )
        ],
      ),
      
      body: TextFormField(
        key: _key,
        autofocus: true,
        decoration: InputDecoration(
          helperText: '请输入手机号',
          hintText: '请输入手机号'
        ),
        onSaved: (val) => widget._account.phone = val,
        validator: (val) => val.isEmpty ? '' : null,
      ),
    );
  }
}