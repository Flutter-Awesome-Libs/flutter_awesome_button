/// This library allows you to add a good looking button without having to write code and manage animations yourself.
///
/// Custom types of this library:
///   [InteractMode] - decides the type of interaction the button uses
///     - DEFAULT: The color of the button changes when the user presses it
///     - OPACITY: The opacity of the button changes when the user presses it
///
///   [ButtonSize] - The size of the button
///     - NORMAL
///     - SMALL
///     - LARGE
///     - FULL_WIDTH: The button fills with the width of its parent
///
/// Sample Usage
///
/// - Using the default button
///     ```
///       AwesomeButton(
///         text: "Press me",
///         onTapUp: (_) {
///           // do something after the user has lifted their finger
///         },
///       )
///     ```
///
/// - Using the button with outline instead of background color
///   ```
///     AwesomeButton.outline(
///       text: "Press me",
///       onTapUp: (_) {
///         // do something after the user has lifted their finger
///       },
///     )
///   ```
///
/// - Using the destructive button: This button renders with a reddish color, commonly used to provide negative options like 'cancel'
///     ```
///       AwesomeButton.destructive(
///         text: "close",
///         onTapUp: (_) {
///           // do something after the user has lifted their finger
///         },
///       )
///
///
/// For full documentation visit https://flutterawesome.dev/docs/components/button
library awesome_ui_button;

import 'package:flutter/material.dart';
import 'dart:math' show max;

enum _ButtonType {
  DEFAULT,
  OUTLINE,
}

/// Type for the kind of interaction the button should use when the user interacts with it.
enum InteractMode {
  DEFAULT,
  OPACITY,
}

/// Type for the size of the button
enum ButtonSize {
  SMALL,
  LARGE,
  NORMAL,
  FULL_WIDTH,
}

// ignore: must_be_immutable
class AwesomeButton extends StatefulWidget {
  _ButtonType _buttonType;

  /// This decides whether or not the button should respond to pointer events. When set to true, the button will ignore touches.
  /// false by default.
  final bool disabled;

  /// The type of interaction the button should use when it receives a pointer event. Depending on the value the button will either
  /// change it's background color when pressed or opacity. [InteractMode.DEFAULT] by default.
  final InteractMode interactMode;

  /// (required) This sets the text of the button.
  final String text;

  /// The key that is set to the root widget. null by default.
  final Key key;

  /// This allows you to set the background color of the button.
  /// NOTE: for [InteractMode.DEFAULT] the background color when the user presses the button changes according to the background color
  /// provided.
  final Color backgroundColor;

  /// Callback that is executed when the button receives when the pointer is lifted from the button i.e the user lifts their finger.
  /// Passes [TapUpDetails] as a parameter
  final GestureTapUpCallback onTapUp;

  /// Callback that is executed when the button receives when the button receives a pointer down event i.e the user presses down on it.
  /// Passes [TapDownDetails] as a parameter
  final GestureTapDownCallback onTapDown;

  /// Sets the size of the button, [ButtonSize] value. [ButtonSize.NORMAL] by default.
  final ButtonSize size;

  /// Sets the color of the text
  final Color textColor;

  /// Sets the size of the text in the button
  final double fontSize;

  /// Allows you to customise the padding of the button
  final EdgeInsets padding;

  /// Allows you to change the color of the button when it is disabled
  final Color disabledColor;

  /// Allows you to customise the value of the radius for the border
  final double borderRadius;

  /// Allows you to change the opacity of the button when the user touches it with [InteractMode.OPACITY]
  final double activeOpacity;

  /// Allows you to change the background color of the button when the user touches it with [InteractMode.DEFAULT]
  final Color activeColor;

  bool _isForcedOpacity = false;
  bool _isDestructive = false;

  AwesomeButton({
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
    this.activeColor,
  }) {
    this._buttonType = _ButtonType.DEFAULT;
  }

  AwesomeButton.outline({
    this.disabled = false,
    this.interactMode = InteractMode.OPACITY,
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
    this.activeColor,
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
    this.activeColor,
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
  double borderOpacityNormal = 0;

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
    backgroundColorActive =
        widget.activeColor ?? _getActiveColor(backgroundColorNormal);

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
      _mainBorderColor = widget._buttonType == _ButtonType.OUTLINE
          ? widget.disabledColor ?? Color(0xFFD9D9D9)
          : Color(0xFFD9D9D9);
    } else {
      _backgroundColor = backgroundColorNormal;
      _mainBorderColor = _backgroundColor;
      borderWidth = borderWidthNormal;
      currentOpacity = normalOpacity;
      flareBorderOpacity = borderOpacityNormal;
    }
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
        borderRadius:
            BorderRadius.all(Radius.circular(widget.borderRadius ?? 4)),
        boxShadow: [
          BoxShadow(
            color: _mainBorderColor.withOpacity(flareBorderOpacity),
            spreadRadius: borderWidth,
          ),
        ],
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
      if (widget.interactMode == InteractMode.DEFAULT &&
          !widget._isForcedOpacity) {
        _backgroundColor = backgroundColorNormal;
      } else {
        currentOpacity = normalOpacity;
      }

      if (widget.size != ButtonSize.FULL_WIDTH) {
        flareBorderOpacity = 0.45;
        borderWidth = 10;
      }
    });

    if (widget.size != ButtonSize.FULL_WIDTH) {
      await Future.delayed(
          Duration(milliseconds: (borderAnimDuration / 3).round()));

      setState(() {
        flareBorderOpacity = 0;
      });

      await Future.delayed(
          Duration(milliseconds: (borderAnimDuration * (2 / 3)).round()));

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
