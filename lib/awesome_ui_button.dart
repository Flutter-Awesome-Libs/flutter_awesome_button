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

enum ButtonSize { SMALL, LARGE, NORMAL }

// ignore: must_be_immutable
class AwesomeButton extends StatefulWidget {
  _ButtonType _buttonType;
  final bool disabled;
  final InteractMode interactMode;
  final String text;
  final Key key;
  final Color backgroundColor;
  final GestureTapUpCallback onTapUp;
  final GestureTapDownCallback onTapDown;
  final ButtonSize size;

  AwesomeButton({
    this.disabled = false,
    this.interactMode = InteractMode.DEFAULT,
    @required this.text,
    this.key,
    this.backgroundColor,
    this.onTapUp,
    this.onTapDown,
    this.size = ButtonSize.NORMAL,
  }) {
    this._buttonType = _ButtonType.DEFAULT;
  }

  AwesomeButton.outline({
    this.disabled = false,
    this.interactMode = InteractMode.DEFAULT,
    @required this.text,
    this.key,
    this.backgroundColor,
    this.onTapUp,
    this.onTapDown,
    this.size = ButtonSize.NORMAL,
  }) {
    this._buttonType = _ButtonType.OUTLINE;
  }

  AwesomeButton.dashed({
    this.disabled = false,
    this.interactMode = InteractMode.DEFAULT,
    @required this.text,
    this.key,
    this.backgroundColor,
    this.onTapUp,
    this.onTapDown,
    this.size = ButtonSize.NORMAL,
  }) {
    this._buttonType = _ButtonType.DASHED;
  }

  AwesomeButton.destructive({
    this.disabled = false,
    this.interactMode = InteractMode.DEFAULT,
    @required this.text,
    this.key,
    this.backgroundColor,
    this.onTapUp,
    this.onTapDown,
    this.size = ButtonSize.NORMAL,
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
      onTapUp: onTapUp,
      onTapDown: onTapDown,
      size: size,
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
  final GestureTapUpCallback onTapUp;
  final GestureTapDownCallback onTapDown;
  final ButtonSize size;

  // State Vars
  Color _backgroundColor;

  // Other vars
  double horizontalPadding;
  double height;
  double fontSize;
  Color backgroundColorActive;
  Color backgroundColorNormal;

  _AwesomeButtonState({
    this.buttonType,
    this.disabled = false,
    this.interactMode = InteractMode.DEFAULT,
    @required this.text,
    this.key,
    this.backgroundColor,
    this.onTapUp,
    this.onTapDown,
    this.size,
  });

  Color _getActiveColor(Color baseColor) {
    int red = max(baseColor.red - 20, 0);
    int green = max(baseColor.green - 40, 0);
    int blue = max(baseColor.blue - 40, 0);

    return Color.fromRGBO(red, green, blue, 1);
  }

  void _setDimensionsBasedOnSize() {
    print(size);
    switch(size) {
      case ButtonSize.SMALL:
        horizontalPadding = 7;
        height = 24;
        fontSize = 12;
        break;
      case ButtonSize.LARGE:
        horizontalPadding = 15;
        height = 40;
        fontSize = 16;
        break;
      case ButtonSize.NORMAL:
        horizontalPadding = 15;
        height = 32;
        fontSize = 14;
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _setDimensionsBasedOnSize();

    // TODO: init all vars
    switch (buttonType) {
      case _ButtonType.DEFAULT:
        backgroundColorNormal = backgroundColor ?? Color(0xFF1890FF);
        backgroundColorActive = _getActiveColor(backgroundColorNormal);
        _backgroundColor = backgroundColorNormal;
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

  Widget _renderButtonText(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: Colors.white,
      ),
    );
  }

  Widget _renderButton(BuildContext context) {
    return AnimatedContainer(
      height: height,
      duration: Duration(
        milliseconds: 200,
      ),
      padding: EdgeInsets.only(
        left: horizontalPadding,
        right: horizontalPadding,
      ),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Center(
        child: _renderButtonText(context),
        widthFactor: 1,
        heightFactor: 1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: _renderButton(context),
      onTapDown: (TapDownDetails details) {
        if (disabled) {
          return;
        }
        setState(() {
          _backgroundColor = backgroundColorActive;
        });
        if (onTapDown != null) {
          onTapDown(details);
        }
      },
      onTapUp: (TapUpDetails details) {
        if (disabled) {
          return;
        }
        setState(() {
          _backgroundColor = backgroundColorNormal;
        });
        // TODO: perform post click flare if any
        if (onTapUp != null) {
          onTapUp(details);
        }
      },
    );
  }
}
