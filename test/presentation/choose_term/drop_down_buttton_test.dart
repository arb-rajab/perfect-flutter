import 'package:beta/domain/multi_select_selection.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/domain/value/title.dart' as t;
import 'package:beta/main.dart';
import 'package:beta/presentation/choose_term/drop_down_button.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../common/tests.dart';

Future main() async {
  await initTests();
  String randomLabel = 'random label';
  List<MultiSelectSelection> randomSelections = [
    MultiSelectSelection(id: const Id(1), title: const t.Title('title 1')),
    MultiSelectSelection(id: const Id(2), title: const t.Title('title 2'))
  ];
  onChanged(dynamic d) {}
  late int randomSelectionId;

  setUp(() {
    randomSelectionId = 1;
  });

  testWidgets('label is visible', (widgetTester) async {
    await widgetTester.pumpWidget(MyApp(
      child: DropDownButton(
          label: randomLabel,
          selectionId: randomSelectionId,
          selections: randomSelections,
          onChanged: onChanged),
    ));
    await widgetTester.pumpAndSettle();
    expect(find.text(randomLabel), findsOneWidget);
  });

  testWidgets('first selection is visible by default', (widgetTester) async {
    await widgetTester.pumpWidget(MyApp(
      child: DropDownButton(
          label: randomLabel,
          selectionId: randomSelectionId,
          selections: randomSelections,
          onChanged: onChanged),
    ));
    await widgetTester.pumpAndSettle();
    expect(find.text(randomSelections[0].title.value!), findsOneWidget);
    expect(find.text(randomSelections[1].title.value!), findsNothing);
  });

  testWidgets('first selection is not visible once changed',
      (widgetTester) async {
    await widgetTester.pumpWidget(MyApp(
      child: StatefulBuilder(builder: (context, setState) {
        return DropDownButton(
            label: randomLabel,
            selectionId: randomSelectionId,
            selections: randomSelections,
            onChanged: (value) {
              setState(() {
                randomSelectionId = value;
              });
            });
      }),
    ));
    await widgetTester.pumpAndSettle();
    await widgetTester.tap(find.text(randomSelections[0].title.value!));
    await widgetTester.pumpAndSettle();
    await widgetTester.tap(find.text(randomSelections[1].title.value!));
    await widgetTester.pumpAndSettle();
    expect(find.text(randomSelections[1].title.value!), findsOneWidget);
    expect(find.text(randomSelections[0].title.value!), findsNothing);
  });

  testWidgets('first selection becomes visible once changed back',
      (widgetTester) async {
    await widgetTester.pumpWidget(MyApp(
      child: StatefulBuilder(builder: (context, setState) {
        return DropDownButton(
            label: randomLabel,
            selectionId: randomSelectionId,
            selections: randomSelections,
            onChanged: (value) {
              setState(() {
                randomSelectionId = value;
              });
            });
      }),
    ));
    await widgetTester.pumpAndSettle();
    await widgetTester.tap(find.text(randomSelections[0].title.value!));
    await widgetTester.pumpAndSettle();
    await widgetTester.tap(find.text(randomSelections[1].title.value!));
    await widgetTester.pumpAndSettle();

    await widgetTester.pumpAndSettle();
    await widgetTester.tap(find.text(randomSelections[1].title.value!));
    await widgetTester.pumpAndSettle();
    await widgetTester.tap(find.text(randomSelections[0].title.value!));
    await widgetTester.pumpAndSettle();
    expect(find.text(randomSelections[0].title.value!), findsOneWidget);
    expect(find.text(randomSelections[1].title.value!), findsNothing);
  });
}
