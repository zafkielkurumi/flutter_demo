import 'package:flutter/material.dart';
import 'package:pwdflutter/db/account.model.dart' show Account;
import './editNote/edit_web_name.dart';
import './editNote/edit_account_name.dart';
import './editNote/edit_phone.dart';
import './editNote/edit_email.dart';
import './editNote/edit_password.dart';
import './password_history.dart';

class NoteDetailPage extends StatefulWidget {
  final Account noteDetail;
  NoteDetailPage(this.noteDetail);
  @override
  State<StatefulWidget> createState() {
    return _NoteDetail();
  }
}

class _NoteDetail extends State<NoteDetailPage> {
  @override
  void initState() {
    super.initState();
  }

  _toEdit(page) {
    return () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => page));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('详情'),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.push(
              context, MaterialPageRoute(builder: (context) => PasswordHistory(widget.noteDetail.historyPassword)));
            },
            child: Text('历史', style: TextStyle(color: Colors.white),),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          NoteListItem('网站', widget.noteDetail.webName, _toEdit(EditWebNamePage(widget.noteDetail))),
          NoteListItem('用户名', widget.noteDetail.account, _toEdit(EditAccountNamePage(widget.noteDetail))),
          NoteListItem('邮箱', widget.noteDetail.email,  _toEdit(EditEmailPage(widget.noteDetail))),
          NoteListItem('手机号', widget.noteDetail.phone, _toEdit(EditPhonePage(widget.noteDetail))),
          NoteListItem('密码', widget.noteDetail.password, _toEdit(EditPasswordPage(widget.noteDetail))),
        ],
      ),
    );
  }
}


class NoteListItem extends StatelessWidget {
  final String title;
  final value;
  final Function ontap;
  NoteListItem(this.title, this.value, [this.ontap]);
  @override
  Widget build(BuildContext context) {
    return InkWell(
            onTap: this.ontap,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(width: 0.15))
              ),
              child: Row(
              children: <Widget>[
                Text(this.title),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(this.value),
                      Icon(Icons.keyboard_arrow_right)
                    ],
                  ),
                )
              ],
            ),
            ),
          );
  }
}
