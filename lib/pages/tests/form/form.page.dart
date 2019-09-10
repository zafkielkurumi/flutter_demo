import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FormPage extends StatefulWidget {
  FormPage({Key key}) : super(key: key);

  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> with SingleTickerProviderStateMixin {

   TabController _tabController;
  List _tabs = ['1', '2', '3', ];

  @override
  void initState() { 
    super.initState();
      _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
      ),
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
            width: double.infinity,
            child: TabBar(
                controller: _tabController,
                labelColor: Color(0xffFC9612),
                isScrollable: true,
                unselectedLabelColor: Color(0xff787878),
                indicatorColor: Color(0xffFC9612),
                // indicatorSize: TabBarIndicatorSize.tab,
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
              // children: List.generate(_tabs.length, (i) {
              //   return Builder(
                  
              //     builder: (BuildContext context) {
              //       // 可以使用index和indexIsChanging判断
              //       // index一直是要跳转的那一个
              //       print(_tabController.indexIsChanging);
              //       print(_tabController.index);
              //       print('build${_tabs[i]}');
              //       return  Text('${_tabs[i]}');
              //     },
              //   );
              // }),
              children: <Widget>[
                Child1(),
                  Child2(),
                  Child3(),
              ],
            ),
          )
          ],
        ),
      ),
    );
  }
}


class Child1 extends StatefulWidget {
  Child1({Key key}) : super(key: key);

  _Child1State createState() => _Child1State();
}

class _Child1State extends State<Child1> {
  @override
  void initState() {
    print('chidl1 init');
    super.initState();
  }

  @override
  void dispose() {
    print('chidl1 dis');
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Text('child1'),
    );
  }
}


class Child2 extends StatefulWidget {
  Child2({Key key}) : super(key: key);

  _Child2State createState() => _Child2State();
}

class _Child2State extends State<Child2> {

  @override
  void initState() {
    print('chidl2 init');
    super.initState();
  }

  @override
  void dispose() {
    print('chidl2 dis');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       child: Text('child2'),
    );
  }
}


class Child3 extends StatefulWidget {
  Child3({Key key}) : super(key: key);

  _Child3State createState() => _Child3State();
}

class _Child3State extends State<Child3> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Text('child3'),
    );
  }
}
