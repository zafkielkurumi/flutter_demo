import 'package:flutter/material.dart';

class StudyPage extends StatefulWidget {
  StudyPage({Key key}) : super(key: key);

  _StudyPageState createState() => _StudyPageState();
}

class _StudyPageState extends State<StudyPage> with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<String> tabs = ['豆知识', '原理'];

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: tabs.length);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TabBar(
              controller: _tabController,
              tabs: <Widget>[for (var tab in tabs) Tab(text: tab,)],
            ),
        Expanded(
            child: TabBarView(
            controller: _tabController,
            children: <Widget>[],
          ),
        )
      ],
    );
  }
}