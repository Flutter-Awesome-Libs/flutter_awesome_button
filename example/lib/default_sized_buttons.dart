import 'package:flutter/material.dart';
import 'package:awesome_ui_button/awesome_ui_button.dart';

class DefaultSized extends StatelessWidget {
  static MaterialPageRoute route() {
    return MaterialPageRoute(builder: (_) {
      return DefaultSized();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(32),
          child: Column(
            children: <Widget>[
              AwesomeButton(
                text: "Click me",
                interactMode: InteractMode.OPACITY,
                activeOpacity: 0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
