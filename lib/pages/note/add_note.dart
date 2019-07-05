import 'package:flutter/material.dart';

class AddNotePage extends StatefulWidget {
  AddNotePage({Key key}) : super(key: key);

  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  String _webSiteName;
  String _userName;
  String _password;
  TextEditingController _websiteController = TextEditingController();
  TextEditingController _uNameController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormFieldState> _webKey = GlobalKey<FormFieldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('添加'),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text('网站'),
                  Text(' *', style: TextStyle(color: Colors.red))
                ],
              ),
              TextFormField(
                key: _webKey,
                controller: _websiteController,
                decoration: InputDecoration(
                    // errorText: '请输入账号所属网站名称或地址'
                    ),
                onSaved: (val) => this._webSiteName = val,
                validator: (val) {
                  print(val);
                  print('0000000000000000000000');
                  return val.isEmpty || val == null ? '请输入账号所属网站名称或地址' : null;
                },
              ),
              Row(
                children: <Widget>[
                  Text('用户名'),
                  Text(' *', style: TextStyle(color: Colors.red))
                ],
              ),
              TextFormField(
                controller: _uNameController,
                // decoration: InputDecoration(errorText: '请输入用户名'),
                onSaved: (val) => this._userName = val,
                validator: (val) {
                  return val.isEmpty ? '请输入用户名' : null;
                },
              ),
              Row(
                children: <Widget>[
                  Text('密码'),
                  Text(' *', style: TextStyle(color: Colors.red))
                ],
              ),
              TextFormField(
                controller: _pwdController,
                // decoration: InputDecoration(errorText: '请输入密码'),
                onSaved: (val) => this._password = val,
                validator: (val) {
                  return val.isEmpty ? '请输入密码' : null;
                },
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  _formKey.currentState;
                  // _websiteController.
                  _webKey.currentState.save();
                  _formKey.currentState.save();
                },
                child: Text(
                  '保存',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ));
  }
}
