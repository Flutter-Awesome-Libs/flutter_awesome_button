library awesome_ui_button;

import 'package:flutter/material.dart';
import 'dart:math' show max;

enum _ButtonType {
  DEFAULT,
  OUTLINE,
}

enum InteractMode {
  DEFAULT,
  OPACITY,
}

enum ButtonSize { SMALL, LARGE, NORMAL, FULL_WIDTH }

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
  final Color textColor;
  final double fontSize;
  final EdgeInsets padding;
  final Color disabledColor;
  final double borderRadius;
  final double activeOpacity;

  bool _isForcedOpacity = false;
  bool _isDestructive = false;

  AwesomeButton({
    this.disabled = false,
    this.interactMode = InteractMode.DEFAULT,
    @required this.text,
    @required this.key,
    this.backgroundColor,
    this.onTapUp,
    this.onTapDown,
    this.size = ButtonSize.NORMAL,
    this.textColor,
    this.fontSize,
    this.padding,
    this.disabledColor,
    this.borderRadius,
    this.activeOpacity,
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
    this.textColor,
    this.fontSize,
    this.padding,
    this.disabledColor,
    this.borderRadius,
    this.activeOpacity,
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
    this.textColor,
    this.fontSize,
    this.padding,
    this.disabledColor,
    this.borderRadius,
    this.activeOpacity,
  }) {
    this._buttonType = _ButtonType.DEFAULT;
    this._isDestructive = true;
  }

  @override
  State<StatefulWidget> createState() {
    return _AwesomeButtonState();
  }
}

class _AwesomeButtonState extends State<AwesomeButton> {
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

  // Colors
  Color backgroundColorActive;
  Color backgroundColorNormal;
  Color _textColor;
  Color _mainBorderColor;

  Color _getActiveColor(Color baseColor) {
    int red = max(baseColor.red - 20, 0);
    int green = max(baseColor.green - 40, 0);
    int blue = max(baseColor.blue - 40, 0);

    return Color.fromRGBO(red, green, blue, 1);
  }

  void _setDimensionsBasedOnSize() {
    switch (widget.size) {
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
      case ButtonSize.FULL_WIDTH:
        horizontalPadding = 15;
        height = 32;
        fontSize = 14;
        break;
    }

    fontSize = widget.fontSize ?? fontSize;
  }

  void _initVars() {
    _setDimensionsBasedOnSize();

    Color previousBgNormal = backgroundColorNormal;
    backgroundColorNormal = widget.backgroundColor ??
        (widget._isDestructive ? Color(0xFFFF4D4F) : Color(0xFF1890FF));
    backgroundColorActive = _getActiveColor(backgroundColorNormal);

    if (backgroundColorNormal != previousBgNormal) {
      _backgroundColor = backgroundColorNormal;
      _mainBorderColor = _backgroundColor;
    }

    _textColor = widget._buttonType == _ButtonType.DEFAULT
        ? Colors.white
        : _backgroundColor;
    _textColor = widget.textColor ?? _textColor;

    activeOpacity = widget.activeOpacity ?? 0.3;

    if (widget.disabled) {
      _backgroundColor = widget.disabledColor ?? Color(0xFFF5F5F5);
      _textColor = Colors.black.withOpacity(0.25);
      _mainBorderColor = Color(0xFFD9D9D9);
    }
  }

  @override
  void initState() {
    super.initState();
    _initVars();
    _backgroundColor = backgroundColorNormal;
    _mainBorderColor = _backgroundColor;
    borderWidth = borderWidthNormal;
    currentOpacity = normalOpacity;
    flareBorderOpacity = borderOpacityNormal;
  }

  Widget _renderButtonText(BuildContext context) {
    return Text(
      widget.text,
      style: TextStyle(
        fontSize: fontSize,
        color: _textColor,
      ),
    );
  }

  EdgeInsets _getButtonPadding() {

    if (widget.padding != null) {
      return widget.padding;
    }

    return EdgeInsets.only(
      left: horizontalPadding,
      right: horizontalPadding,
      top: 6,
      bottom: 6,
    );
  }

  BoxDecoration _getButtonDecoration() {
    return BoxDecoration(
      color: widget._buttonType == _ButtonType.DEFAULT
          ? _backgroundColor
          : Colors.transparent,
      borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius ?? 4)),
      border: Border.all(
        width: widget._buttonType == _ButtonType.DEFAULT ? 0 : 1,
        color: _mainBorderColor,
      ),
    );
  }

  Widget _renderButton(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: borderAnimDuration),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius ?? 4)),
        border: Border.all(
          color: _mainBorderColor.withOpacity(flareBorderOpacity),
          width: borderWidth,
        ),
      ),
      child: AnimatedOpacity(
        opacity: currentOpacity,
        duration: Duration(
          milliseconds: mainAnimDuration,
        ),
        child: AnimatedContainer(
          constraints: BoxConstraints(
            minHeight: height,
          ),
          duration: Duration(
            milliseconds: mainAnimDuration,
          ),
          padding: _getButtonPadding(),
          decoration: _getButtonDecoration(),
          child: Center(
            child: _renderButtonText(context),
            widthFactor: widget.size == ButtonSize.FULL_WIDTH ? null : 1,
            heightFactor: 1,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _initVars();
    return GestureDetector(
      key: widget.key,
      child: _renderButton(context),
      onTapDown: (TapDownDetails details) {
        if (widget.disabled) {
          return;
        }
        setState(() {
          if (widget.interactMode == InteractMode.DEFAULT &&
              !widget._isForcedOpacity) {
            _backgroundColor = backgroundColorActive;
          } else {
            currentOpacity = activeOpacity;
          }
        });
        if (widget.onTapDown != null) {
          widget.onTapDown(details);
        }
      },
      onTapUp: (TapUpDetails details) {
        if (widget.disabled) {
          return;
        }

        _onTapUp();

        if (widget.onTapUp != null) {
          widget.onTapUp(details);
        }
      },
    );
  }

  void _onTapUp() async {
    setState(() {
      if (widget.interactMode == InteractMode.DEFAULT) {
        _backgroundColor = backgroundColorNormal;
      } else {
        currentOpacity = normalOpacity;
      }

      if (widget.size != ButtonSize.FULL_WIDTH) {
        flareBorderOpacity = 0;
        borderWidth = 10;
      }
    });

    if (widget.size != ButtonSize.FULL_WIDTH) {
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
}
