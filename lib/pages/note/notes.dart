import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_easyrefresh/material_footer.dart';

import './note_detail.dart';
import './add_note.dart';
import 'package:pwdflutter/db/account.model.dart' show Account;
import './note.service.dart' show NoteService;
import 'package:pwdflutter/app.dart';

class NotesPage extends StatefulWidget {
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<NotesPage> {
  List noteList = [];
  GlobalKey<RefreshHeaderState> _headerKey = GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();
  @override
  void initState() {
    _getList().then((res) {
      noteList = res;
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  _getList() async {
    return await NoteService.getList();
  }

  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('小笔记'),
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
          key: this._headerKey,
        ),
        refreshFooter: MaterialFooter(key: _footerKey),
        onRefresh: () async {
         try {
            List list = await _getList();
          setState(() {
            this.noteList = list;
          });
         } catch (e) {
           _easyRefreshKey.currentState.callLoadMoreFinish();
         }
        },
        loadMore: () {},
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
         var res =  await Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddNotePage()));
          // App.router.navigateTo(context, '/addNote');
          if (res == true) {
          _easyRefreshKey.currentState.callRefresh();

          }
        },
      ),
    );
  }
}

class NoteItem extends StatelessWidget {
  final Account noteItem;
  NoteItem(this.noteItem);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NoteDetailPage(this.noteItem)));
      },
      child: Container(
        padding: EdgeInsets.all(5),
        decoration:
            BoxDecoration(border: Border(bottom: BorderSide(width: 0.15))),
        child: Row(
          children: <Widget>[
            CircleAvatar(),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          this.noteItem.webName,
                          style: TextStyle(color: Colors.pink),
                        ),
                        Text(DateFormat('yyyy-MM-dd')
                            .format(this.noteItem.genTime))
                      ],
                    ),
                    Text(this.noteItem.account),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
