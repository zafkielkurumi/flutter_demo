import 'package:flutter/material.dart';
import './view_state.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

abstract class ViewListState<T> extends ViewStateModel {

  int pageIndex = 1;
  static int pageFirst = 1;
  List<T> _list = [];

  int pageSize = 10;

  EasyRefreshController  _easyRefreshController = EasyRefreshController();

  EasyRefreshController get easyRefreshController => _easyRefreshController;
  List<T> get list => _list;

   refresh() async {
    try {
      var res = await loadData(pageIndex: pageFirst);
      if (res.isEmpty) {
        setEmpty();
      } else {
        _list = res;
      }
    } catch (e) {
    }
  }




  // 加载数据
  Future<List<T>> loadData({int pageIndex, int pageSize, String searchKey});

}