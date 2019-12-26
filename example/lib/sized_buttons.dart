import 'package:flutter/material.dart';
import 'package:awesome_ui_button/awesome_ui_button.dart';

class Sized extends StatelessWidget {
  static MaterialPageRoute route() {
    return MaterialPageRoute(builder: (_) {
      return Sized();
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
                    text: "Default Small",
                    size: ButtonSize.SMALL,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: AwesomeButton.outline(
                      text: "Outline small",
                      size: ButtonSize.SMALL,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: AwesomeButton.destructive(
                      text: "Destructive Small",
                      size: ButtonSize.SMALL,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
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
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: <Widget>[
                    AwesomeButton(
                      text: "Default Large",
                      size: ButtonSize.LARGE,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: AwesomeButton.outline(
                        text: "Outline Large",
                        size: ButtonSize.LARGE,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: AwesomeButton.destructive(
                        text: "Destructive Large",
                        size: ButtonSize.LARGE,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      child: AwesomeButton(
                        text: "Default Full Width",
                        size: ButtonSize.FULL_WIDTH,
                      ),
                      width: 500,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      child: AwesomeButton.outline(
                        text: "Outline Full Width",
                        size: ButtonSize.FULL_WIDTH,
                      ),
                      width: 500,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      child: AwesomeButton.destructive(
                        text: "Detructive Full Width",
                        size: ButtonSize.FULL_WIDTH,
                      ),
                      width: 500,
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
