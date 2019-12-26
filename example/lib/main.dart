import 'package:flutter/material.dart';
import 'default_sized_buttons.dart';
import 'sized_buttons.dart';
import 'interactions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (settings){
        switch(settings.name) {
          case "/":
            return DefaultSized.route();
          case "/sized":
            return Sized.route();
          case "/interact":
            return Interaction.route();
          default:
            return DefaultSized.route();
            break;
        }
      },
      initialRoute: "/",
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[

        ],
      )
    );
  }
}
