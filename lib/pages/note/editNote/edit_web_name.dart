import 'package:flutter/material.dart';

import 'package:pwdflutter/db/account.model.dart' show Account;
import '../note.service.dart';

class EditWebNamePage extends StatefulWidget {
  final Account _account;

  EditWebNamePage(this._account);
  @override
  State<StatefulWidget> createState() {
    return _EditWebName();
  }
 
}

class _EditWebName extends State<EditWebNamePage> {
    GlobalKey<FormFieldState> _key = new GlobalKey<FormFieldState>();
  @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('修改所属网站'),
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
          helperText: '请输入网站',
          hintText: '请输入网站'
        ),
        onSaved: (val) => widget._account.webName = val,
        validator: (val) => val.isEmpty ? '' : null,
      ),
    );
  }
}