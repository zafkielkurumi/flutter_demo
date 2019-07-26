import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:radial_button/widget/circle_floating_button.dart';
import 'package:file_picker/file_picker.dart';

import './note_detail.dart';
import './add_note.dart';
import 'package:pwdflutter/db/account.model.dart' show Account;
import './note.service.dart' show NoteService;
import 'package:pwdflutter/utils/file.dart';

class NotesPage extends StatefulWidget {
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<NotesPage> {
  List noteList = [];
  final AppBar appBar = AppBar(
    title: Text('小笔记'),
  );
  GlobalKey<RefreshHeaderState> _headerKey = GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();
  GlobalKey _contextKey = GlobalKey();
  GlobalKey<CircleFloatingButtonState> floatKey =
      GlobalKey<CircleFloatingButtonState>();
  List<Widget> itemsActionBar;

  importDb() async {
       var filePath = await FilePicker.getFilePath(
      type: FileType.ANY,
    );
    if (filePath != null) {
      print(filePath);
      floatKey.currentState.close();
      FileUtil _f = FileUtil();
      _f.importDb(filePath);
    }
  }

  copyFile() async {
    FileUtil _f = FileUtil();
    var filePath = await FilePicker.getFilePath(
      type: FileType.ANY,
    );
    if (filePath != null) {
      _f.copyFile(filePath);
      floatKey.currentState.close();
    }
  }

  exportDb() {
    // todo 导出
    FileUtil _f = FileUtil();
    _f.exportDb();
    floatKey.currentState.close();
  }

  @override
  void initState() {
    _getList().then((res) {
      noteList = res;
      if (mounted) {
        setState(() {});
      }
    });
    itemsActionBar = [
      FloatingActionButton(
        backgroundColor: Colors.greenAccent,
        heroTag: '0',
        onPressed: () async {
          floatKey.currentState.close();
          var res = await Navigator.pushNamed(context, '/add_note');
          if (res == true) {
            _easyRefreshKey.currentState.callRefresh();
          }
        },
        child: Icon(Icons.add),
      ),
      FloatingActionButton(
        backgroundColor: Colors.indigoAccent,
        heroTag: '1',
        onPressed: importDb,
        child: Icon(Icons.arrow_downward),
      ),
      FloatingActionButton(
        backgroundColor: Colors.orangeAccent,
        heroTag: '3',
        onPressed: exportDb,
        child: Icon(Icons.arrow_upward),
      ),
    ];
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

  onDelete(Account account) {
    this.noteList.remove(account);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      key: _contextKey,
      body: EasyRefresh(
        key: _easyRefreshKey,
        child: ListView.builder(
          itemCount: this.noteList.length,
          itemBuilder: (BuildContext context, int index) {
            Account account = this.noteList[index];
            return NoteItem(account, onDelete: onDelete);
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
      floatingActionButton: CircleFloatingButton.floatingActionButton(
        key: floatKey,
        items: itemsActionBar,
        color: Colors.redAccent,
        icon: Icons.menu,
        duration: Duration(milliseconds: 400),
        curveAnim: Curves.elasticOut,
      ),
    );
  }
}

class NoteItem extends StatelessWidget {
  final Account _account;
  Function onDelete = () {};
  GlobalKey _key = GlobalKey();
  NoteItem(this._account, {this.onDelete});

  _showmenu(GlobalKey key, BuildContext context, [Account account]) async {
    final RenderBox button = key.currentContext.findRenderObject();
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
    var container = Offset.zero & overlay.size;
    var rect = Rect.fromPoints(
      button.localToGlobal(Offset.zero, ancestor: overlay),
      button.localToGlobal(button.size.bottomRight(Offset.zero),
          ancestor: overlay),
    );
    final RelativeRect position = RelativeRect.fromLTRB(
      rect.left - container.left,
      rect.top - container.top + rect.size.height,
      container.right - rect.right,
      container.bottom - rect.bottom,
    );
    // final RelativeRect position = RelativeRect.fromRect(
    //   Rect.fromPoints(
    //     button.localToGlobal(Offset.zero, ancestor: overlay),
    //     button.localToGlobal(button.size.bottomRight(Offset.zero),
    //         ancestor: overlay),
    //   ),
    //   Offset.zero & overlay.size,
    // );
    var res = await showMenu(
        context: context,
        position: position,
        items: <PopupMenuEntry>[
          PopupMenuItem(
            value: 1,
            child: Text('删除'),
            // height: 50,
          )
        ]);
    onMenuSelect(res, account);
  }

  onMenuSelect(val, [Account account]) {
    switch (val) {
      case 1:
        {
          NoteService.deleteAccount(account);
          onDelete(account);
        }
        break;
      default:
        {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        _showmenu(_key, context, _account);
      },
      onTap: () {
        Navigator.of(context).pushNamed('/note_detail', arguments: _account);
      },
      child: Container(
        padding: EdgeInsets.all(5),
        decoration:
            BoxDecoration(border: Border(bottom: BorderSide(width: 0.15))),
        child: Row(
          children: <Widget>[
            // CircleAvatar(),
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
                          '网站名：${this._account.webName ?? ''}',
                          style: TextStyle(color: Colors.pink),
                        ),
                        Text(
                          DateFormat('yyyy-MM-dd')
                              .format(this._account.genTime),
                          key: _key,
                        )
                      ],
                    ),
                    Text('账号：${this._account.account ?? ''}'),
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
