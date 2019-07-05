import 'package:flutter/material.dart';

class NoteDetailPage extends StatefulWidget {
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('详情'),
      ),
      body: ListView(
        children: <Widget>[
          NoteListItem('网站', '缺B乐'),
          ListTile(title: Text('网站'), trailing: Text('缺B乐'),),
          Divider(),
          NoteListItem('账号', '563693600@qq.com'),
          NoteListItem('邮箱', '563693600@qq.com'),
          NoteListItem('手机号', '563693600@qq.com'),
          NoteListItem('密码', '563693600@qq.com'),
        ],
      ),
    );
  }
}


class NoteListItem extends StatelessWidget {
  final String title;
  final value;
  final Function ontap;
  NoteListItem(this.title, this.value, {this.ontap});
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
