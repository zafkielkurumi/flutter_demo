import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FormPage extends StatefulWidget {
  FormPage({Key key}) : super(key: key);

  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> with SingleTickerProviderStateMixin {

   TabController _tabController;
  List _tabs = ['1', '2', '3'];

  @override
  void initState() { 
    super.initState();
      _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Column(
          children: <Widget>[
            Shimmer.fromColors(
                baseColor: Colors.red,
    highlightColor: Colors.yellow,
              child: Container(
              height: 100,
              color: Colors.pink,
            ),
            ),
            TextFormField(
              decoration:
                  InputDecoration(helperText: '请输入用户名', hintText: '请输入用户名'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Offstage(
                  offstage: false,
                  child: Text('offstate'),
                ),
                Text('data')
              ],
            ),
             Container(
            color: Colors.white,
            child: TabBar(
                controller: _tabController,
                labelColor: Color(0xffFC9612),
                // isScrollable: true,
                unselectedLabelColor: Color(0xff787878),
                indicatorColor: Color(0xffFC9612),
                indicatorWeight: 2,
                indicatorPadding: EdgeInsets.symmetric(horizontal: 70),
                tabs: List.generate(_tabs.length, (i) {
                  final r = _tabs[i];
                  return Tab(
                    text: '${_tabs[i]}',
                  );
                })
              
                ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: List.generate(_tabs.length, (i) {
                return Builder(
                  
                  builder: (BuildContext context) {
                    // 可以使用index和indexIsChanging判断
                    // index一直是要跳转的那一个
                    print(_tabController.indexIsChanging);
                    print(_tabController.index);
                    print('build${_tabs[i]}');
                    return  Text('${_tabs[i]}');
                  },
                );
              }),
            ),
          )
          ],
        ),
      ),
    );
  }
}
