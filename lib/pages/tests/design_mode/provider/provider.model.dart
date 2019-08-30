import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

// model 只是用来存储数据, 因为继承ChangeNotifier ， 可以使用notifyListeners
class ProviderModel extends ChangeNotifier {
  final List<String> _list = [];



  int get count => _list.length;


   UnmodifiableListView<String>  get list => UnmodifiableListView(_list);

  void add(String str) {
    _list.add(str);
    notifyListeners();
  }

}