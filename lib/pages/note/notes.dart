import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_easyrefresh/material_footer.dart';

import 'package:pwdflutter/db/model.dart' show noteListTest;

class NotesPage extends StatefulWidget {
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<NotesPage> {
  List noteList = [];
  GlobalKey<RefreshHeaderState> _headerKey = GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();
  @override
  void initState() {
    super.initState();
  }


  GlobalKey<EasyRefreshState> _easyRefreshKey =  new GlobalKey<EasyRefreshState>();
  @override
  Widget build(BuildContext context) {
    this.noteList = noteListTest;
    return Scaffold(
      appBar: AppBar(
        title: Text('data'),
      ),
      body: EasyRefresh(
        key: _easyRefreshKey,
        child: ListView.builder(
          itemCount: this.noteList.length,
          itemBuilder: (BuildContext context, int index) {
            return NoteItem(this.noteList[index]);
          },
        ),
        refreshHeader: MaterialHeader(
            key: this._headerKey,),
        refreshFooter: MaterialFooter(key: _footerKey),
        onRefresh: () {},
        loadMore: () {},
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // this.noteList.add('3');
          // setState(() {});
        },
      ),
    );
  }
}

class NoteItem extends StatelessWidget {
  final noteItem;
  NoteItem(this.noteItem);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Row(
        children: <Widget>[
          CircleAvatar(),
          Expanded(
            child: Container(
              decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 0.15))),
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        this.noteItem['name'],
                        style: TextStyle(color: Colors.pink),
                      ),
                      Text(this.noteItem['createDate'])
                    ],
                  ),
                  Text(this.noteItem['account']),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
