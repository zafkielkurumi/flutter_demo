import 'package:flutter/material.dart';
enum ViewState {
  idle,
  content,
  empty,
  loading,
  error,
  unAuth
}

class ViewStateModel extends ChangeNotifier {
  ViewState _viewState = ViewState.loading;
  bool _dispose = false;

  ViewState get viewState => _viewState;

  set viewState(ViewState viewState) {
    _viewState = viewState;
    notifyListeners();
  }

  ViewState get idle => ViewState.idle;
  ViewState get content => ViewState.content;
  ViewState get empty => ViewState.empty;
  ViewState get loading => ViewState.loading;
  ViewState get error => ViewState.error;
  ViewState get unAuth => ViewState.unAuth;

  setIdel() {
    viewState = idle;
  }

  setContent() {
    viewState = content;
  }

  setEmpty() {
    viewState = empty;
  }

  setLoading() {
    viewState = loading;
  }

  setError() {
    viewState = error;
  }

  setUnAuth() {
    viewState = unAuth;
  }

  @override
  void notifyListeners() {
    if (!_dispose) {
       super.notifyListeners();
    }
   
  }

  @override
  void dispose() {
    _dispose = true;
    super.dispose();
  }
}
