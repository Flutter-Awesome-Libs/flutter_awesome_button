import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:math' show max;

// test comment

import 'package:awesome_ui_button/awesome_ui_button.dart';

void main() {
  Color _getActiveColor(Color baseColor) {
    int red = max(baseColor.red - 20, 0);
    int green = max(baseColor.green - 40, 0);
    int blue = max(baseColor.blue - 40, 0);

    return Color.fromRGBO(red, green, blue, 1);
  }

  /**
   * MARK: Test that the UI renders correctly for all situations
   */

  testWidgets("Test that default button renders correctly", (tester) async {
    String text = "Test";
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: AwesomeButton(text: text),
        ),
      ),
    );

    Finder gestureFinder = find.byType(GestureDetector);
    Finder containerFinder = find.byType(AnimatedContainer);
    Finder opacityFinder = find.byType(AnimatedOpacity);
    Finder centerFinder = find.byType(Center);
    Finder textFinder = find.text(text);

    // Check that the right widgets render the right number of times
    expect(gestureFinder, findsOneWidget);
    expect(opacityFinder, findsOneWidget);
    expect(centerFinder, findsOneWidget);
    expect(textFinder, findsOneWidget);
    expect(containerFinder, findsNWidgets(2));

    // Check that background of default button is the default color
    AnimatedContainer container = containerFinder.last.evaluate().single.widget;
    expect((container.decoration as BoxDecoration).color,
        equals(Color(0xFF1890FF)));
  });

  testWidgets(
      "Test that custom background colors are used by the widget instead of defaults",
      (tester) async {
    String text = "Test";
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: AwesomeButton(
            text: text,
            backgroundColor: Colors.red,
          ),
        ),
      ),
    );

    Finder containerFinder = find.byType(AnimatedContainer);
    AnimatedContainer container = containerFinder.last.evaluate().single.widget;
    expect((container.decoration as BoxDecoration).color, equals(Colors.red));
  });

  testWidgets(
      "Test that disabled buttons use the default color when a custom one is not provided",
      (tester) async {
    String text = "Test";
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: AwesomeButton(
            text: text,
            disabled: true,
          ),
        ),
      ),
    );

    Finder containerFinder = find.byType(AnimatedContainer);
    AnimatedContainer container = containerFinder.last.evaluate().single.widget;
    expect((container.decoration as BoxDecoration).color,
        equals(Color(0xFFF5F5F5)));
  });

  testWidgets("Test that key provided is assigned to the root widget",
      (tester) async {
    String text = "Test";
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: AwesomeButton(
            text: text,
            key: Key("TestKey"),
          ),
        ),
      ),
    );

    Finder containerFinder = find.byType(AwesomeButton);
    AwesomeButton root = containerFinder.first.evaluate().single.widget;
    expect(root.key, equals(Key("TestKey")));
  });

  testWidgets("Test that provided font size property is applied",
      (tester) async {
    String text = "Test";
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: AwesomeButton(
            text: text,
            fontSize: 26,
          ),
        ),
      ),
    );

    Finder textFinder = find.text(text);
    Text textWidget = textFinder.first.evaluate().single.widget;
    expect(textWidget.style.fontSize, equals(26));
  });

  testWidgets("Test that provided font color property is applied",
      (tester) async {
    String text = "Test";
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: AwesomeButton(
            text: text,
            textColor: Colors.red,
          ),
        ),
      ),
    );

    Finder textFinder = find.text(text);
    Text textWidget = textFinder.first.evaluate().single.widget;
    expect(textWidget.style.color, equals(Colors.red));
  });

  testWidgets("Test that provided padding property is applied", (tester) async {
    String text = "Test";
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: AwesomeButton(
            text: text,
            padding: EdgeInsets.all(6),
          ),
        ),
      ),
    );

    Finder containerFinder = find.byType(AnimatedContainer);
    AnimatedContainer container = containerFinder.last.evaluate().single.widget;
    expect(container.padding, equals(EdgeInsets.all(6)));
  });

  testWidgets("Test that provided disabled color property is applied",
      (tester) async {
    String text = "Test";
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: AwesomeButton(
            text: text,
            disabled: true,
            disabledColor: Colors.red,
          ),
        ),
      ),
    );

    Finder containerFinder = find.byType(AnimatedContainer);
    AnimatedContainer container = containerFinder.last.evaluate().single.widget;
    expect((container.decoration as BoxDecoration).color, equals(Colors.red));
  });

  testWidgets("Test that provided border radius is applied", (tester) async {
    String text = "Test";
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: AwesomeButton(
            text: text,
            borderRadius: 9,
          ),
        ),
      ),
    );

    Finder containerFinder = find.byType(AnimatedContainer);
    AnimatedContainer container = containerFinder.last.evaluate().single.widget;
    expect((container.decoration as BoxDecoration).borderRadius,
        equals(BorderRadius.all(Radius.circular(9))));
  });

  /**
   * Test that the UI changes correctly when tapping it fpr all interact modes
   */
  testWidgets("Test that on pressing the button the background color changes",
      (tester) async {
    String text = "Test";
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: AwesomeButton(
            text: text,
          ),
        ),
      ),
    );

    await tester.startGesture(tester.getCenter(find.text(text)));
    await tester.pump();

    Finder animatedContainerFinder = find.byType(AnimatedContainer);
    AnimatedContainer container =
        animatedContainerFinder.last.evaluate().single.widget;
    expect((container.decoration as BoxDecoration).color,
        equals(_getActiveColor(Color(0xFF1890FF))));
  });

  testWidgets(
      "Test that given a custom background color, on pressing the button the background color changes accordingly",
      (tester) async {
    String text = "Test";
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: AwesomeButton(
            text: text,
            backgroundColor: Colors.purple,
          ),
        ),
      ),
    );

    await tester.startGesture(tester.getCenter(find.text(text)));
    await tester.pump();

    Finder animatedContainerFinder = find.byType(AnimatedContainer);
    AnimatedContainer container =
        animatedContainerFinder.last.evaluate().single.widget;
    expect((container.decoration as BoxDecoration).color,
        equals(_getActiveColor(Colors.purple)));
  });

  testWidgets(
      "Test that given a custom active color, on pressing the button the background color changes accordingly",
      (tester) async {
    String text = "Test";
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: AwesomeButton(
            text: text,
            activeColor: Colors.purple,
          ),
        ),
      ),
    );

    await tester.startGesture(tester.getCenter(find.text(text)));
    await tester.pump();

    Finder animatedContainerFinder = find.byType(AnimatedContainer);
    AnimatedContainer container =
        animatedContainerFinder.last.evaluate().single.widget;
    expect(
        (container.decoration as BoxDecoration).color, equals(Colors.purple));
  });

  testWidgets(
      "Test that for interact mode opacity, on press the opacity changes accordingly",
      (tester) async {
    String text = "Test";
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: AwesomeButton(
            text: text,
            interactMode: InteractMode.OPACITY,
          ),
        ),
      ),
    );

    await tester.startGesture(tester.getCenter(find.text(text)));
    await tester.pump();

    Finder animatedContainerFinder = find.byType(AnimatedOpacity);
    AnimatedOpacity container =
        animatedContainerFinder.last.evaluate().single.widget;
    expect(container.opacity, equals(0.3));
  });

  testWidgets(
      "Test that given active opacity for interact mode opacity, on press the opacity changes accordingly",
      (tester) async {
    String text = "Test";
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: AwesomeButton(
            text: text,
            interactMode: InteractMode.OPACITY,
            activeOpacity: 0.1,
          ),
        ),
      ),
    );

    await tester.startGesture(tester.getCenter(find.text(text)));
    await tester.pump();

    Finder animatedContainerFinder = find.byType(AnimatedOpacity);
    AnimatedOpacity container =
        animatedContainerFinder.last.evaluate().single.widget;
    expect(container.opacity, equals(0.1));
  });

  testWidgets(
      "Test that on pressing the button the background color does not change when disabled",
      (tester) async {
    String text = "Test";
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: AwesomeButton(
            text: text,
            disabled: true,
          ),
        ),
      ),
    );

    await tester.startGesture(tester.getCenter(find.text(text)));
    await tester.pump();

    Finder animatedContainerFinder = find.byType(AnimatedContainer);
    AnimatedContainer container =
        animatedContainerFinder.last.evaluate().single.widget;
    expect((container.decoration as BoxDecoration).color,
        equals(Color(0xFFF5F5F5)));
  });

  testWidgets(
      "Test that for interact mode opacity, on press the opacity does not change when disabled",
      (tester) async {
    String text = "Test";
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: AwesomeButton(
            text: text,
            interactMode: InteractMode.OPACITY,
            disabled: true,
          ),
        ),
      ),
    );

    await tester.startGesture(tester.getCenter(find.text(text)));
    await tester.pump();

    Finder animatedContainerFinder = find.byType(AnimatedOpacity);
    AnimatedOpacity container =
        animatedContainerFinder.last.evaluate().single.widget;
    expect(container.opacity, equals(1));
  });

  testWidgets("Test that tap down and up are called, and in the correct order", (tester) async {
    // The widget uses futures, without runAsync the test will throw a pending timer error
    await tester.runAsync(() async {
      String text = "Test";
      List<String> tapResult = [];
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: AwesomeButton(
              text: text,
              onTapDown: (_) {
                tapResult.add("down");
              },
              onTapUp: (_) {
                tapResult.add("up");
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text(text));
      await tester.pump();

      expect(tapResult.length, equals(2));
      expect(tapResult[0], equals("down"));
      expect(tapResult[1], equals("up"));
    });
  });

  testWidgets("Test that tap down and up are not called when button is disabled", (tester) async {
    // The widget uses futures, without runAsync the test will throw a pending timer error
    await tester.runAsync(() async {
      String text = "Test";
      List<String> tapResult = [];
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: AwesomeButton(
              text: text,
              disabled: true,
              onTapDown: (_) {
                tapResult.add("down");
              },
              onTapUp: (_) {
                tapResult.add("up");
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text(text));
      await tester.pump();

      expect(tapResult.length, equals(0));
    });
  });
}
