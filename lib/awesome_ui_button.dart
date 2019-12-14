library awesome_ui_button;

import 'package:flutter/material.dart';
import 'dart:math' show max;

enum _ButtonType {
  DEFAULT,
  OUTLINE,
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

  bool _isForcedOpacity = false;

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
    this._isForcedOpacity = true;
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
      interactMode: _isForcedOpacity ? InteractMode.OPACITY : interactMode,
      text: text,
      key: key,
      onTapUp: onTapUp,
      onTapDown: onTapDown,
      size: size,
      backgroundColor: backgroundColor,
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

  // Animation durations
  int borderAnimDuration = 250;
  int mainAnimDuration = 150;
  double currentOpacity;
  double borderWidth;
  double flareBorderOpacity;

  // Size dimensions
  double horizontalPadding;
  double height;
  double borderWidthNormal = 0;
  double fontSize;

  // Opacity values
  double normalOpacity = 1;
  double activeOpacity;
  double borderOpacityNormal = 0.3;

  // Background colors
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
    switch (size) {
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

    backgroundColorNormal = backgroundColor ?? Color(0xFF1890FF);
    backgroundColorActive = _getActiveColor(backgroundColorNormal);
    _backgroundColor = backgroundColorNormal;
    currentOpacity = normalOpacity;
    activeOpacity = 0.3;
    flareBorderOpacity = borderOpacityNormal;
    borderWidth = borderWidthNormal;
  }

  Widget _renderButtonText(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color:
            buttonType == _ButtonType.DEFAULT ? Colors.white : _backgroundColor,
      ),
    );
  }

  Widget _renderButton(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: borderAnimDuration),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        border: Border.all(
          color: _backgroundColor.withOpacity(flareBorderOpacity),
          width: borderWidth,
        ),
      ),
      child: AnimatedOpacity(
        opacity: currentOpacity,
        duration: Duration(
          milliseconds: mainAnimDuration,
        ),
        child: AnimatedContainer(
          height: height,
          duration: Duration(
            milliseconds: mainAnimDuration,
          ),
          padding: EdgeInsets.only(
            left: horizontalPadding,
            right: horizontalPadding,
          ),
          decoration: BoxDecoration(
            color: buttonType == _ButtonType.DEFAULT
                ? _backgroundColor
                : Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(4)),
            border: Border.all(
              width: buttonType == _ButtonType.DEFAULT ? 0 : 1,
              color: _backgroundColor,
            ),
          ),
          child: Center(
            child: _renderButtonText(context),
            widthFactor: 1,
            heightFactor: 1,
          ),
        ),
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
          if (interactMode == InteractMode.DEFAULT) {
            _backgroundColor = backgroundColorActive;
          } else {
            currentOpacity = activeOpacity;
          }
        });
        if (onTapDown != null) {
          onTapDown(details);
        }
      },
      onTapUp: (TapUpDetails details) {
        if (disabled) {
          return;
        }

        _onTapUp();

        if (onTapUp != null) {
          onTapUp(details);
        }
      },
    );
  }

  void _onTapUp() async {
    setState(() {
      if (interactMode == InteractMode.DEFAULT) {
        _backgroundColor = backgroundColorNormal;
      } else {
        currentOpacity = normalOpacity;
      }
      flareBorderOpacity = 0;
      borderWidth = 10;
    });

    await Future.delayed(Duration(milliseconds: borderAnimDuration));

    setState(() {
      borderWidth = borderWidthNormal;
    });

    await Future.delayed(Duration(milliseconds: borderAnimDuration));

    setState(() {
      flareBorderOpacity = borderOpacityNormal;
    });
  }
}
