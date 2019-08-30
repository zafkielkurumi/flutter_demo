import 'package:flutter/material.dart';
import 'package:pwdflutter/models/account.model.dart';
import 'package:pwdflutter/services/note.service.dart';

class NotesModel extends ChangeNotifier {
  List<Account> _list = [];

  List<Account> get accountList => _list;

  String _keyword = '';

  void refresh() async {
    var res = await loadData();
    _list = res;
    notifyListeners();
  } 

  void loadMore() async {
    var res = await loadData();
    _list.addAll(res);
    notifyListeners();
  }


  Future<List<Account>> loadData() async {
     var res = await NoteService.getList(searchkey: _keyword);
     return res;
  }

  onSearch(String searchkey) async {
    _keyword = searchkey;
    var res =  await loadData();
    _list = res;
    notifyListeners();
  }

  void deleteNote(int index) {
    _list.removeAt(index);
    notifyListeners();
  }
}

