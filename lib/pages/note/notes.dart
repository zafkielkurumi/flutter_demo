import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:pwdflutter/models/account.model.dart';
import 'package:pwdflutter/provider/finger_auth.provider.dart';
import 'package:pwdflutter/provider/notes.provider.dart';
import 'package:pwdflutter/router/note.routes.dart';
import 'package:pwdflutter/services/note.service.dart';
import 'package:pwdflutter/widgets/search.component.dart';
import 'package:radial_button/widget/circle_floating_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:pwdflutter/utils/file.dart';

import 'package:provider/provider.dart';

class NotesPage extends StatefulWidget {
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<NotesPage> with AutomaticKeepAliveClientMixin {
  GlobalKey<CircleFloatingButtonState> floatKey =
      GlobalKey<CircleFloatingButtonState>();
  List<Widget> itemsActionBar;

  @override
  bool get wantKeepAlive => false;

  importDb() async {
    var filePath = await FilePicker.getFilePath(
      type: FileType.ANY,
    );
    if (filePath != null) {
      floatKey.currentState.close();
      FileUtil _f = FileUtil();
      await _f.importDb(filePath);
      _easyRefreshController.callRefresh();
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
    itemsActionBar = [
      FloatingActionButton(
        backgroundColor: Colors.greenAccent,
        heroTag: '0',
        onPressed: () async {
          floatKey.currentState.close();
          var res = await Navigator.pushNamed(context, NoteRoutes.addNote);
          if (res == true) {
            _easyRefreshController.callRefresh();
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

  static Rect getWidgetGlobalRect(GlobalKey key) {
    RenderBox renderBox = key.currentContext.findRenderObject();
    var offset = renderBox.localToGlobal(Offset.zero);
    return Rect.fromLTWH(
        offset.dx, offset.dy, renderBox.size.width, renderBox.size.height);
  }

  EasyRefreshController _easyRefreshController = EasyRefreshController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Provider(
      builder: (_) => FingerModel(),
      dispose: (_, FingerModel model) => model.dispose(),
      child: ChangeNotifierProvider(
        builder: (_) => NotesModel(),
        child: Scaffold(
          appBar: AppBar(
            title: Builder(
              builder: (BuildContext context) {
                NotesModel model =
                    Provider.of<NotesModel>(context, listen: false);
                return CySearch(
                  submit: model.onSearch,
                );
              },
            ),
          ),
          body: Consumer(
            builder: (BuildContext ctx, NotesModel notes, Widget chid) =>
                EasyRefresh(
              firstRefresh: true,
              controller: _easyRefreshController,
              child: ListView.builder(
                itemCount: notes.accountList.length,
                itemBuilder: (BuildContext context, int index) {
                  Account account = notes.accountList[index];
                  return NoteItem(
                    account,
                  );
                },
              ),
              header: MaterialHeader(),
              footer: MaterialFooter(),
              onRefresh: () async {
                notes.refresh();
              },
              // loadMore: () {},
            ),
          ),
          floatingActionButton: CircleFloatingButton.floatingActionButton(
            key: floatKey,
            items: itemsActionBar,
            color: Colors.redAccent,
            icon: Icons.menu,
            duration: Duration(milliseconds: 400),
            curveAnim: Curves.elasticOut,
          ),
        ),
      ),
    );
  }
}

class NoteItem extends StatelessWidget {
  final Account _account;
  GlobalKey _key = GlobalKey();
  NoteItem(this._account);

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
          // onDelete(account);
        }
        break;
      default:
        {}
    }
  }

  @override
  Widget build(BuildContext context) {
    FingerModel model = Provider.of<FingerModel>(context);
    NotesModel noteModel = Provider.of(context, listen: false);
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: '删除',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {},
        ),
      ],
      child: InkWell(
        onTap: () async {
          if (await model.checkFingerAuth()) {
            Navigator.of(context)
                .pushNamed(NoteRoutes.noteDetail, arguments: _account);
          }
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
      ),
    );
  }
}
