import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/auth_strings.dart';


import 'package:pwdflutter/db/account.model.dart' show Account;

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

  checkBiometrics() async {
    LocalAuthentication localAuth = LocalAuthentication();
    AndroidAuthMessages androidAuthMessages = AndroidAuthMessages(
        fingerprintHint: 'fingerprintHint',
        fingerprintNotRecognized: '不能识别',
        fingerprintSuccess: '验证成功',
        cancelButton: '取消',
        signInTitle: 'signInTitle',
        fingerprintRequiredTitle: 'fingerprintRequiredTitle',
        goToSettingsButton: 'goToSettingsButton',
        goToSettingsDescription: 'goToSettingsDescription',
    );
    const iosStrings = const IOSAuthMessages(
    cancelButton: '取消',
    goToSettingsButton: 'goToSettingsButton',
    goToSettingsDescription: 'goToSettingsDescription',
    lockOut: 'Please reenable your Touch ID');
    try {
      bool checkBiometrics = await  localAuth.canCheckBiometrics;
      print(checkBiometrics);
      bool didAuthenticate =
    await localAuth.authenticateWithBiometrics(
          localizedReason: '验证指纹显示密码',
          useErrorDialogs: false,
          stickyAuth: false,
          iOSAuthStrings: iosStrings,
          androidAuthStrings: androidAuthMessages
        );
    print(didAuthenticate);
    } catch (e) {
      print(e);
      print('指纹出错');
    }
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
              context, '/note_history', arguments: widget.noteDetail.historyPassword);
            },
            child: Text('历史', style: TextStyle(color: Colors.white),),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          NoteListItem('网站', widget.noteDetail.webName, _toEdit('/edit_web_name', widget.noteDetail)),
          NoteListItem('用户名', widget.noteDetail.account, _toEdit('/edit_account_name', widget.noteDetail)),
          NoteListItem('邮箱', widget.noteDetail.email,  _toEdit('/edit_email', widget.noteDetail)),
          NoteListItem('手机号', widget.noteDetail.phone, _toEdit('/edit_phone', widget.noteDetail)),
          NoteListItem('密码', widget.noteDetail.password, _toEdit('/edit_password', widget.noteDetail)),
          RaisedButton(
            onPressed: checkBiometrics,
            child: Text('check'),
          )
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
