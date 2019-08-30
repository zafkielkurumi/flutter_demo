import 'package:flutter/material.dart';
import 'package:pwdflutter/models/account.model.dart';

import 'package:pwdflutter/router/note.routes.dart';

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

  _toEdit(String page, Object arguments) {
    return () => Navigator.pushNamed(
              context, page, arguments: arguments);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('详情'),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.pushNamed(
              context, NoteRoutes.noteHistory, arguments: widget.noteDetail.historyPassword);
            },
            child: Text('历史', style: TextStyle(color: Colors.white),),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          NoteListItem('网站', widget.noteDetail.webName, _toEdit(NoteRoutes.editWebName, widget.noteDetail)),
          NoteListItem('用户名', widget.noteDetail.account, _toEdit(NoteRoutes.editAccountName, widget.noteDetail)),
          NoteListItem('邮箱', widget.noteDetail.email,  _toEdit(NoteRoutes.editEmail, widget.noteDetail)),
          NoteListItem('手机号', widget.noteDetail.phone, _toEdit(NoteRoutes.editPhone, widget.noteDetail)),
          NoteListItem('密码', widget.noteDetail.password, _toEdit(NoteRoutes.editPassword, widget.noteDetail)),
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
                Text('${this.title ?? ''}'),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text('${this.value ?? ''}'),
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
