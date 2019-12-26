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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(32),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  AwesomeButton(
                    text: "Default",
                    activeOpacity: 0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: AwesomeButton.outline(
                      text: "Outline",
                      activeOpacity: 0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: AwesomeButton.destructive(
                      text: "Destructive",
                      activeOpacity: 0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
