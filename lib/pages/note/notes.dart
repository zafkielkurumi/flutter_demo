import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:popup_menu/popup_menu.dart';

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

  static Rect getWidgetGlobalRect(GlobalKey key) {
    RenderBox renderBox = key.currentContext.findRenderObject();
    var offset = renderBox.localToGlobal(Offset.zero);
    return Rect.fromLTWH(
        offset.dx, offset.dy, renderBox.size.width, renderBox.size.height);
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
            Account account = this.noteList[index];
            return index.isEven
                ? Dismissible(
                    key: Key('$index'),
                    child: NoteItem(account),
                    onDismissed: (d) {
                      this.noteList.removeAt(index);
                    },
                  )
                : NoteItem(account);
            // return NoteItem(this.noteList[index]);
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
          var res = await Navigator.push(
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
  final Account _account;
  GlobalKey _key = GlobalKey();
  NoteItem(this._account);

  _showmenu(GlobalKey key, BuildContext context) {
    final RenderBox button = key.currentContext.findRenderObject();
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero),
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );
    showMenu(context: context, position: position, items: <PopupMenuEntry>[
      PopupMenuItem(
        child: Text('删除'),
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        _showmenu(_key, context);
      },
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => NoteDetailPage(_account)));
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
                          this._account.webName,
                          style: TextStyle(color: Colors.pink),
                        ),
                        Text(
                          DateFormat('yyyy-MM-dd')
                              .format(this._account.genTime),
                          key: _key,
                        )
                      ],
                    ),
                    Text(this._account.account),
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
