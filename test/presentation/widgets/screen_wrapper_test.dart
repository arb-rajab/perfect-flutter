import 'package:beta/application/services/theme_service.dart';
import 'package:beta/application/services/tutorial_service.dart';
import 'package:beta/presentation/widgets/screen_wrapper.dart';
import 'package:beta/presentation/widgets/screen_wrapper_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../common/tests.dart';

class MockTutorialService extends Mock implements TutorialService {}

class MockThemeService extends Mock implements ThemeService {}

void main() {
  late MockTutorialService mockTutorialService;
  late MockThemeService mockThemeService;

  setUp(() async {
    await initTests();
    mockTutorialService = MockTutorialService();
    mockThemeService = MockThemeService();

    Get.put<TutorialService>(mockTutorialService);
    Get.put<ThemeService>(mockThemeService);

    when(() => mockThemeService.getScaleFactor()).thenReturn(1.0);
  });

  tearDown(() {
    Get.reset();
  });

  Widget createTestWidget({
    Widget? child,
    String? titleText,
    Widget? title,
    IconData? icon,
    Widget? bottomNavigationBar,
    Widget? drawer,
    List<Widget>? actions,
    Widget? floatingActionButton,
    List<TargetFocus> targets = const [],
    List<Tab> tabs = const [],
  }) {
    return MaterialApp(
      onGenerateRoute: (settings) => MaterialPageRoute(
        settings: settings,
        builder: (_) => ScreenWrapper(
          titleText: titleText,
          title: title,
          icon: icon,
          bottomNavigationBar: bottomNavigationBar,
          drawer: drawer,
          actions: actions,
          floatingActionButton: floatingActionButton,
          targets: targets,
          tabs: tabs,
          child: child ?? const SizedBox(),
        ),
      ),
      initialRoute: '/test',
    );
  }

  group('ScreenWrapper', () {
    testWidgets('renders basic structure without app bar', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.byType(SafeArea), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBar), findsNothing);
    });

    testWidgets('shows app bar when titleText is provided', (tester) async {
      await tester.pumpWidget(createTestWidget(titleText: 'Test Title'));
      await tester.pumpAndSettle();

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Test Title'), findsOneWidget);
    });

    testWidgets('shows app bar when title widget is provided', (tester) async {
      await tester.pumpWidget(createTestWidget(
        title: const Text('Custom Title Widget'),
      ));
      await tester.pumpAndSettle();

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Custom Title Widget'), findsOneWidget);
    });

    testWidgets('shows app bar when drawer is provided', (tester) async {
      await tester.pumpWidget(createTestWidget(
        drawer: const Drawer(child: Text('Drawer Content')),
      ));
      await tester.pumpAndSettle();

      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('shows app bar when actions are provided', (tester) async {
      await tester.pumpWidget(createTestWidget(
        actions: [IconButton(icon: const Icon(Icons.add), onPressed: () {})],
      ));
      await tester.pumpAndSettle();

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('shows tabs when provided', (tester) async {
      await tester.pumpWidget(createTestWidget(
        titleText: 'Test Title', // This ensures AppBar is shown
        tabs: [
          const Tab(text: 'Tab 1'),
          const Tab(text: 'Tab 2'),
        ],
      ));
      await tester.pumpAndSettle();

      expect(find.byType(TabBar), findsOneWidget);
      expect(find.text('Tab 1'), findsOneWidget);
      expect(find.text('Tab 2'), findsOneWidget);
    });

    testWidgets('shows bottom navigation bar when provided', (tester) async {
      await tester.pumpWidget(createTestWidget(
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
      ));
      await tester.pumpAndSettle();

      expect(find.byType(BottomNavigationBar), findsOneWidget);
    });

    testWidgets('shows floating action button when provided', (tester) async {
      await tester.pumpWidget(createTestWidget(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
      ));
      await tester.pumpAndSettle();

      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets('disposes controller correctly', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      final route = MaterialPageRoute(builder: (_) => Container());
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Navigator(
            onGenerateRoute: (_) => route,
          ),
        ),
      ));
      await tester.pumpAndSettle();

      // Verify controller is disposed when route is popped
      expect(Get.isRegistered<ScreenWrapperController>(), isFalse);
    });
  });
}
