import 'package:flutter/material.dart';

import './note/notes.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('小笔记'),
      ),
      body: NotesPage(),
    );
  }
}