import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderWidget<T extends ChangeNotifier> extends StatefulWidget {
  ProviderWidget({
    Key key, 
    @required this.model,
    this.onInit,
    this.child,
    this.builder
  }) : super(key: key);

  final Function onInit;

  final Widget Function(BuildContext context, T model, Widget child) builder;

  T model;
  Widget child;

  _ProviderWidgetState createState() => _ProviderWidgetState<T>();
}

class _ProviderWidgetState<T extends ChangeNotifier> extends State<ProviderWidget> {

  @override
  void initState() { 
    if (widget.onInit != null) {
      widget.onInit();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (_) => widget.model,
      child: Consumer<T>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}