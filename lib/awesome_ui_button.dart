library awesome_ui_button;

import 'package:flutter/material.dart';
import 'dart:math' show max;

enum _ButtonType {
  DEFAULT,
  OUTLINE,
  DASHED,
  DESTRUCTIVE,
}

enum InteractMode {
  DEFAULT,
  OPACITY,
}

// ignore: must_be_immutable
class AwesomeButton extends StatefulWidget {
  _ButtonType _buttonType;
  final bool disabled;
  final InteractMode interactMode;
  final String text;
  final Key key;
  final Color backgroundColor;

  AwesomeButton({
    this.disabled = false,
    this.interactMode = InteractMode.DEFAULT,
    @required this.text,
    this.key,
    this.backgroundColor,
  }) {
    this._buttonType = _ButtonType.DEFAULT;
  }

  AwesomeButton.outline({
    this.disabled = false,
    this.interactMode = InteractMode.DEFAULT,
    @required this.text,
    this.key,
    this.backgroundColor,
  }) {
    this._buttonType = _ButtonType.OUTLINE;
  }

  AwesomeButton.dashed({
    this.disabled = false,
    this.interactMode = InteractMode.DEFAULT,
    @required this.text,
    this.key,
    this.backgroundColor,
  }) {
    this._buttonType = _ButtonType.DASHED;
  }

  AwesomeButton.destructive({
    this.disabled = false,
    this.interactMode = InteractMode.DEFAULT,
    @required this.text,
    this.key,
    this.backgroundColor,
  }) {
    this._buttonType = _ButtonType.DESTRUCTIVE;
  }

  @override
  State<StatefulWidget> createState() {
    return _AwesomeButtonState(
      buttonType: _buttonType,
      disabled: disabled,
      interactMode: interactMode,
      text: text,
      key: key,
    );
  }
}

class _AwesomeButtonState extends State<AwesomeButton> {
  final _ButtonType buttonType;
  final bool disabled;
  final InteractMode interactMode;
  final String text;
  final Key key;
  final Color backgroundColor;

  // State Vars
  Color backgroundColorActive;
  Color backgroundColorNormal;

  _AwesomeButtonState({
    this.buttonType,
    this.disabled = false,
    this.interactMode = InteractMode.DEFAULT,
    @required this.text,
    this.key,
    this.backgroundColor,
  });

  Color _getActiveColor(Color baseColor) {
    int red = max(baseColor.red - 20, 0);
    int green = max(baseColor.green - 40, 0);
    int blue = max(baseColor.blue - 40, 0);

    return Color.fromRGBO(red, green, blue, 1);
  }

  @override
  void initState() {
    super.initState();

    // TODO: init all vars
    switch (buttonType) {
      case _ButtonType.DEFAULT:
        backgroundColorNormal = backgroundColor ?? Color(0xFF1890FF);
        backgroundColorActive = _getActiveColor(backgroundColorNormal);
        break;
      case _ButtonType.OUTLINE:
        // TODO: Handle this case.
        break;
      case _ButtonType.DASHED:
        // TODO: Handle this case.
        break;
      case _ButtonType.DESTRUCTIVE:
        // TODO: Handle this case.
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}
