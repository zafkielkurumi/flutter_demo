import 'package:flutter/material.dart';
import 'package:pwdflutter/pages/tests/design_mode/provider/consumer.dart';
import './share_provider.dart';
import './provider.model.dart';

class ProviderPage extends StatefulWidget {
  ProviderPage({Key key}) : super(key: key);

  _ProviderPageState createState() => _ProviderPageState();
}

class _ProviderPageState extends State<ProviderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('provider'),
      ),
      body: ChangeNotifierProvider<ProviderModel>(
        data: ProviderModel(),
        child: Builder(
          builder: (BuildContext context) {
            print('build ppp');
            ProviderModel model = ChangeNotifierProvider.of<ProviderModel>(context, listen: false);
            return Column(
              children: <Widget>[
                Child1(),
                Child2(),
                Builder(
                  builder: (BuildContext context) {
                    print('button build');
                    return RaisedButton(
                      child: Text('添加'),
                      onPressed: () {
                        ProviderModel model =  ChangeNotifierProvider.of<ProviderModel>(context, listen: false);
                        model.add('str');
                      },
                    );
                  },
                ),
                Builder(
                  builder: (BuildContext context) {
                    print('build');
                    return Text('${model.count}');
                  },
                ),
                Consumer<ProviderModel>(
                  builder: (context, model) {
                    return Text('${model.count}');
                  },
                ),
                Expanded(
                  child: Builder(
                    builder: (BuildContext context) {
                      print('build list');
                      ProviderModel model = ChangeNotifierProvider.of<ProviderModel>(context);
                      return ListView.builder(
                        itemCount: model.count,
                        itemBuilder: (BuildContext context, int i) {
                          return ListTile(
                            title: Text('${model.list[i]}'),
                          );
                        },
                      );
                    },
                  ),
                )
              ],
            );
          },
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
    ProviderModel model = ChangeNotifierProvider.of(context);
    return Container(
      child: Text('${model.count}'),
    );
  }
}


class Child2 extends StatelessWidget {
  const Child2({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('build child2');
    return Container(
      child: Text('child2'),
    );
  }
}
