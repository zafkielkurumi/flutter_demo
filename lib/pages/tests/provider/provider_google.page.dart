import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderGooglePage extends StatefulWidget {
  ProviderGooglePage({Key key}) : super(key: key);

  _ProviderGooglePageState createState() => _ProviderGooglePageState();
}

class _ProviderGooglePageState extends State<ProviderGooglePage> {

  int size = 16;
   final counter = CountModel();
  @override
  void initState() {
    //   WidgetsBinding.instance.addPostFrameCallback((callback){
    // });
    // TODO: implement initState
    super.initState();
  }

// 官方的Provider其实就是 Inherited， ChangeNotifierProvider就是包装了的statefulwidget
  @override
  Widget build(BuildContext context) {
    CountModel count = CountModel();
    return Scaffold(
      body: ChangeNotifierProvider<CountModel>.value(
        value: CountModel(),
        child: ListView(
            children: <Widget>[
              Child1(),
              Child2() 
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
  Widget build(BuildContext context) {
    //  Provider.of<String>(context).
    final countModel = Provider.of<CountModel>(context);
    return RaisedButton(
       child: Text('${countModel.count}'),
       onPressed: () {
         countModel.increment();
       },
    );
  }
}


class Child2 extends StatelessWidget {
  const Child2({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CountModel>(
      builder: (BuildContext context, CountModel countModel, Widget child)  => Text('${countModel.count}/data'),
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
    return SizedBox();
  }
}


class CountModel extends ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increment() {
    ++_count;
    notifyListeners();
  } 
}

