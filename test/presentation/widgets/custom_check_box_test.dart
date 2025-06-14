import 'package:beta/main.dart';
import 'package:beta/presentation/widgets/custom_check_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../common/tests.dart';

Future main() async {
  await initTests();
  testWidgets('Renders correctly with label text', (WidgetTester tester) async {
    bool isChecked = false;
    const label = 'Test Checkbox';

    await tester.pumpWidget(
      MyApp(
        child: CustomCheckbox(
          label: label,
          checked: isChecked,
          onChanged: (value) => isChecked = value!,
        ),
      ),
    );

    expect(find.text(label), findsOneWidget);
    expect(find.byType(Checkbox), findsOneWidget);
    final checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
    expect(checkbox.value, isChecked);
    await tester.pumpAndSettle();
  });

  testWidgets('Renders correctly with label widget',
      (WidgetTester tester) async {
    bool isChecked = false;
    const labelWidget = Text('Custom Label Widget');

    await tester.pumpWidget(
      MyApp(
        child: CustomCheckbox(
          labelWidget: labelWidget,
          checked: isChecked,
          onChanged: (value) => isChecked = value!,
        ),
      ),
    );

    expect(find.byWidget(labelWidget), findsOneWidget);
    expect(find.byType(Checkbox), findsOneWidget);

    await tester.pumpAndSettle();
  });

  testWidgets('Toggles value when checkbox is tapped',
      (WidgetTester tester) async {
    bool isChecked = false;
    const label = 'Test Checkbox';

    await tester.pumpWidget(
      MyApp(
        child: CustomCheckbox(
          label: label,
          checked: isChecked,
          onChanged: (value) => isChecked = value!,
        ),
      ),
    );

    await tester.tap(find.byType(Checkbox));
    await tester.pump();

    expect(isChecked, isTrue);
    await tester.pumpAndSettle();
  });

  testWidgets('Toggles value when label is tapped',
      (WidgetTester tester) async {
    bool isChecked = false;
    const label = 'Test Checkbox';

    await tester.pumpWidget(
      MyApp(
        child: CustomCheckbox(
          label: label,
          checked: isChecked,
          onChanged: (value) => isChecked = value!,
        ),
      ),
    );

    await tester.tap(find.text(label));
    await tester.pump();

    expect(isChecked, isTrue);
    await tester.pumpAndSettle();
  });

  testWidgets('Uses Flexible for label widget', (WidgetTester tester) async {
    bool isChecked = false;
    const labelWidget = Text('Custom Label Widget');

    await tester.pumpWidget(
      MyApp(
        child: CustomCheckbox(
          labelWidget: labelWidget,
          checked: isChecked,
          onChanged: (value) => isChecked = value!,
        ),
      ),
    );

    expect(find.byType(Flexible), findsOneWidget);
    await tester.pumpAndSettle();
  });
}
