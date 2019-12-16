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
              Row(
                children: <Widget>[
                  AwesomeButton(
                    text: "Small",
                    interactMode: InteractMode.OPACITY,
                    activeOpacity: 0,
                    size: ButtonSize.SMALL,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: AwesomeButton(
                      text: "Normal",
                      interactMode: InteractMode.OPACITY,
                      activeOpacity: 0,
                      backgroundColor: Colors.pinkAccent,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: AwesomeButton(
                      text: "Large",
                      interactMode: InteractMode.OPACITY,
                      activeOpacity: 0,
                      size: ButtonSize.LARGE,
                      backgroundColor: Colors.redAccent,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 16,
                ),
                child: Row(
                  children: <Widget>[
                    AwesomeButton(
                      text: "Small",
                      interactMode: InteractMode.OPACITY,
                      activeOpacity: 0,
                      size: ButtonSize.SMALL,
                      disabled: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: AwesomeButton(
                        text: "Normal",
                        interactMode: InteractMode.OPACITY,
                        activeOpacity: 0,
                        disabled: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: AwesomeButton(
                        text: "Large",
                        interactMode: InteractMode.OPACITY,
                        activeOpacity: 0,
                        size: ButtonSize.LARGE,
                        disabled: true,
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
