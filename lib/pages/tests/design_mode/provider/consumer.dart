import 'package:flutter/material.dart';
import 'package:pwdflutter/pages/tests/design_mode/provider/share_provider.dart';

class Consumer<T> extends StatelessWidget {
  const Consumer({Key key, @required this.builder, this.child}) : super(key: key);
  final Widget Function(BuildContext context, T value) builder;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return builder(
      context,
       ChangeNotifierProvider.of<T>(context),
    );
  }
}