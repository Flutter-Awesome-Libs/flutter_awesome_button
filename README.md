# awesome_ui_button

![](https://github.com/Flutter-Awesome-Libs/flutter_awesome_button/workflows/build/badge.svg)
[![License: MIT](https://img.shields.io/badge/License-MIT-brightgreen.svg)](https://github.com/Flutter-Awesome-Libs/flutter_awesome_button/blob/master/LICENSE)

This package allows you to add a good looking button to your application easily and without having to write a lot of code yourself, simply import and start using.

## Add the dependency

Add this to your pubspec.yaml
```
dependencies:
  awesome_ui_button: ^1.0.2
```

## Installing

Run the following command

```
flutter pub get
```

## Import the package

```
import 'package:awesome_ui_button/awesome_ui_button.dart';
```

## Add the button to your application

```dart
AwesomeButton(
  text: "Default",
),

OR

AwesomeButton.outline(
  text: "Outline",
),


OR

AwesomeButton.destructive(
  text: "Destructive",
),
```

For full documentation visit [flutterawesome.dev](https://flutterawesome.dev/docs/components/button)
