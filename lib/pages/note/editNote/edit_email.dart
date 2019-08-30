import 'package:flutter/material.dart';
import 'package:pwdflutter/models/account.model.dart';
import 'package:pwdflutter/services/note.service.dart';

class EditEmailPage extends StatefulWidget {
  final Account _account;

  EditEmailPage(this._account);
  @override
  State<StatefulWidget> createState() {
    return _EditEmail();
  }
 
}

class _EditEmail extends State<EditEmailPage> {
    GlobalKey<FormFieldState> _key = new GlobalKey<FormFieldState>();
  @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('修改邮箱'),
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
          helperText: '请输入邮箱',
          hintText: '请输入邮箱'
        ),
        onSaved: (val) => widget._account.email = val,
        validator: (val) => val.isEmpty ? '' : null,
      ),
    );
  }
}