import 'package:flutter/material.dart';
import 'package:awesome_ui_button/awesome_ui_button.dart';

class Interaction extends StatelessWidget {
  static MaterialPageRoute route() {
    return MaterialPageRoute(builder: (_) {
      return Interaction();
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
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: AwesomeButton.outline(
                      text: "Outline",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: AwesomeButton.destructive(
                      text: "Destructive",
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: <Widget>[
                    AwesomeButton(
                      text: "Default opacity",
                      interactMode: InteractMode.OPACITY,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: AwesomeButton.outline(
                        text: "Outline opacity",
                        interactMode: InteractMode.OPACITY,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: AwesomeButton.destructive(
                        text: "Destructive opacity",
                        interactMode: InteractMode.OPACITY,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
