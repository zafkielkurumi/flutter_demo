import 'package:flutter/material.dart';
import 'package:pwdflutter/pages/tests/design_mode/Inherited/share_inherited.dart';

class InheritedPage extends StatefulWidget {
  InheritedPage({Key key}) : super(key: key);

  _InheritedPageState createState() => _InheritedPageState();
}

class _InheritedPageState extends State<InheritedPage> {

  int count = 5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inherited'),),
      body: ShareInherited(
        data: count,
        child: ListView(
          children: <Widget>[
            Child1(),
            Child2(),
            Child3(),
            RaisedButton(
              child: Text('change'),
              onPressed: () {
                ++count;
                setState(() {
                  
                });
              },
            )
          ],
        ),
      ),
    );
  }
}


class Child1 extends StatelessWidget {
  const Child1({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('build child1');
    return Container(
      child: Text('${ShareInherited.of(context).data}'),
    );
  }
}


class Child2 extends StatefulWidget {
  Child2({Key key}) : super(key: key);

  _Child2State createState() => _Child2State();
}

class _Child2State extends State<Child2> {


  @override
  void didUpdateWidget(Child2 oldWidget) {
    print('Child2 didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }



    @override
  void didChangeDependencies() {
    print('Child2 didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print('build child2');
    var data = ShareInherited.of(context, listen: false).data;
    return Container(
       child:  Text('${data}'),
    );
  }
}


class Child3 extends StatefulWidget {
  Child3({Key key}) : super(key: key);

  _Child3State createState() => _Child3State();
}

class _Child3State extends State<Child3> {




  @override
  void didChangeDependencies() {
     print('Child3 didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print('build child3');
    return Container(
       child: Text('chi;d3'),
    );
  }
}