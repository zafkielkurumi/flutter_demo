import 'package:flutter/material.dart';
import 'package:pwdflutter/models/account.model.dart';
import 'package:pwdflutter/services/note.service.dart';


class EditAccountNamePage extends StatefulWidget {
  final Account _account;

  EditAccountNamePage(this._account);
  @override
  State<StatefulWidget> createState() {
    return _EditAccountName();
  }
 
}

class _EditAccountName extends State<EditAccountNamePage> {
    GlobalKey<FormFieldState> _key = new GlobalKey<FormFieldState>();
  @override
   Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(),
      appBar: AppBar(
        title: Text('修改用户名'),
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
          helperText: '请输入用户名',
          hintText: '请输入用户名'
        ),
        onSaved: (val) => widget._account.account = val,
        validator: (val) => val.isEmpty ? '' : null,
      ),
    );
  }
}