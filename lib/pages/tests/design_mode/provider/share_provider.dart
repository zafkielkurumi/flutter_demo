import 'package:flutter/material.dart';

// 一个通用的InheritedWidget，保存任需要跨组件共享的状态
class InheritedProvider<T> extends InheritedWidget {
  InheritedProvider({@required this.data, Widget child}) : super(child: child);

  //共享状态使用泛型
  final T data;

  @override
  bool updateShouldNotify(InheritedProvider<T> old) {
    //在此简单返回true，则每次更新都会调用依赖其的子孙节点的`didChangeDependencies`。
    return true;
  }
}
Type _typeOf<T>() => T;


// 内部还是使用InheritedWidget, 只不过是data是一个model
class ChangeNotifierProvider< T extends ChangeNotifier> extends StatefulWidget {
  ChangeNotifierProvider({ @required this.child, this.data});
  final Widget child;
  final T data;

  static T of<T>(BuildContext context, {bool listen = true}) {
    final type = _typeOf<InheritedProvider<T>>();
    final provider = listen ? context.inheritFromWidgetOfExactType(type) as InheritedProvider<T> 
    : context.ancestorInheritedElementForWidgetOfExactType(type).widget as InheritedProvider<T>;
    return provider.data;
  }


  _ChangeNotifierProviderState createState() => _ChangeNotifierProviderState<T>();
}

class _ChangeNotifierProviderState<T extends ChangeNotifier> extends State<ChangeNotifierProvider<T>> {
  void update() {
    //如果数据发生变化（model类调用了notifyListeners），重新构建InheritedProvider
    // 就算在这里重新setState 会引起重新build，但是因为child是外部传入,如果不是外部重新build，这个child就似乎不变的，但是由于InheritedWidget
    setState(() => {});
  }

  @override
  void didUpdateWidget(ChangeNotifierProvider<T> oldWidget) {
    //当Provider更新时，如果新旧数据不"=="，则解绑旧数据监听，同时添加新数据监听
    if (widget.data != oldWidget.data) {
      oldWidget.data.removeListener(update);
      widget.data.addListener(update);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    // 给model添加监听器
    widget.data.addListener(update);
    super.initState();
  }

  @override
  void dispose() {
    // 移除model的监听器
    widget.data.removeListener(update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('build parent');
    return InheritedProvider<T>(
      data: widget.data,
      child: widget.child,
    );
  }
}