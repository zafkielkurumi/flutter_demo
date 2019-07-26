import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './note.service.dart' show NoteService;
import 'package:pwdflutter/db/account.model.dart' show Account;

class AddNotePage extends StatefulWidget {
  AddNotePage({Key key}) : super(key: key);

  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  Account _account = new Account();
  TextEditingController _websiteController = TextEditingController();
  TextEditingController _uNameController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('添加'),
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: ListView(
              // physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text('网站'),
                    Text(' *', style: TextStyle(color: Colors.red))
                  ],
                ),
                TextFormField(
                  controller: _websiteController,
                  decoration: InputDecoration(
                      // errorText: '请输入用户名所属网站名称或地址'
                      ),
                  onSaved: (val) => this._account.webName = val,
                  validator: (val) =>
                      val.isEmpty || val == null ? '请输入用户名所属网站名称或地址' : null,
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
                  onSaved: (val) => this._account.account = val,
                  validator: (val) => val.isEmpty ? '请输入用户名' : null,
                ),
                Text('邮箱'),
                TextFormField(
                  controller: _emailController,
                  onSaved: (val) => this._account.email = val,
                ),
                Text('手机号'),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                      suffixIcon: _phoneController.text.isNotEmpty
                          ? IconButton(
                              icon: Icon(
                                Icons.cancel,
                                color: Colors.black38,
                                size: 16,
                              ),
                              onPressed: () {
                                WidgetsBinding.instance.addPostFrameCallback(
                                    (_) => _phoneController.clear());
                              },
                            )
                          : null),
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.phone,
                  onSaved: (val) {
                    this._account.phone = val;
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
                  obscureText: true,
                  decoration: InputDecoration(),
                  validator: (val) {
                    return val.isEmpty ? '请输入密码' : null;
                  },
                  onSaved: (val) {
                    this._account.password = val;
                  },
                ),
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    var form = _formKey.currentState;
                    if (form.validate()) {
                      form.save();
                      NoteService.addAccount(_account);
                      Navigator.pop(context, true);
                    }
                  },
                  child: Text(
                    '保存',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
