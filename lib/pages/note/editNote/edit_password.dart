import 'package:flutter/material.dart';
import 'package:pwdflutter/db/account.model.dart' show Account;
import '../note.service.dart' show NoteService;

class EditPasswordPage extends StatefulWidget {
  final Account _account;

  EditPasswordPage(this._account);
  @override
  State<StatefulWidget> createState() {
    return _EditPassword();
  }
}

class _EditPassword extends State<EditPasswordPage> {
  GlobalKey<FormFieldState> _key = new GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('修改密码'),
        actions: <Widget>[
          FlatButton(
            onPressed: () async {
              if (_key.currentState.validate()) {
                _key.currentState.save();
                await NoteService.updatePassword(widget._account);
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
        decoration: InputDecoration(helperText: '请输入密码', hintText: '请输入密码'),
        onSaved: (val) => widget._account.password = val,
        validator: (val) => val.isEmpty ? '' : null,
      ),
    );
  }
}
