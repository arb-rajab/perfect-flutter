import 'package:beta/application/services/user_service.dart';
import 'package:beta/constants/arguments.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/admin.dart';
import 'package:beta/domain/comment.dart';
import 'package:beta/domain/device.dart';
import 'package:beta/domain/name.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/domain/value/number_of_sub_terms.dart';
import 'package:beta/domain/value/text.dart' as domain_text;
import 'package:beta/domain/value/title.dart' as domain_title;
import 'package:beta/infrastructure/key_value_repository.dart';
import 'package:beta/main.dart';
import 'package:beta/presentation/discussion/discuss_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

import '../../common/tests.dart';

class MockKeyValue extends Mock implements KeyValue {}

class FakeBuildContext extends Fake implements BuildContext {}

void main() async {
  setUpAll(() {
    registerFallbackValue(FakeBuildContext());
  });

  setUp(() async {
    await initTests();
    final mockKeyValue = MockKeyValue();

    // Mock KeyValue methods
    when(() => mockKeyValue.getString(any())).thenReturn('123');
    when(() => mockKeyValue.getBool(any(), any())).thenReturn(false);
    when(() => mockKeyValue.setString(any(), any())).thenAnswer((_) async {});
    when(() => mockKeyValue.setBool(any(), any())).thenAnswer((_) async {});

    Get.delete<UserService>();
    Get.put(UserService(keyValue: mockKeyValue));
  });

  tearDown(() {
    Get.reset();
  });

  group('DiscussWidget Tests', () {
    testWidgets('renders comment from device owner correctly',
        (WidgetTester tester) async {
      // Arrange
      final comment = Comment(
        id: const Id(1),
        content: const domain_text.Text('Test comment content'),
        device: Device(
          id: const Id(123), // Same as user ID
          name: Name(name: const domain_title.Title('Test Device')),
        ),
        admin: null,
        numberOfComments: const NumberOfSubTerms(5),
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DiscussWidget(comment: comment),
          ),
        ),
      );

      // Assert
      expect(find.text('Test comment content'), findsOneWidget);
      expect(find.text(StringConstant.you), findsOneWidget);
      expect(find.textContaining(StringConstant.numberOfSubcomments),
          findsOneWidget);
    });

    testWidgets('renders comment from other device correctly',
        (WidgetTester tester) async {
      // Arrange
      final comment = Comment(
        id: const Id(1),
        content: const domain_text.Text('Another user comment'),
        device: Device(
          id: const Id(456), // Different from user ID
          name: Name(name: const domain_title.Title('Other Device')),
        ),
        admin: null,
        numberOfComments: const NumberOfSubTerms(3),
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DiscussWidget(comment: comment),
          ),
        ),
      );

      // Assert
      expect(find.text('Another user comment'), findsOneWidget);
      expect(find.text('Other Device'), findsOneWidget);
      expect(find.textContaining(StringConstant.numberOfSubcomments),
          findsOneWidget);
    });

    testWidgets('renders admin comment correctly', (WidgetTester tester) async {
      // Arrange
      final comment = Comment(
        id: const Id(1),
        content: const domain_text.Text('Admin comment'),
        device: null,
        admin: const Admin(
          id: Id(999),
          username: domain_title.Title('AdminUser'),
        ),
        numberOfComments: const NumberOfSubTerms(0),
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DiscussWidget(comment: comment),
          ),
        ),
      );

      // Assert
      expect(find.text('Admin comment'), findsOneWidget);
      expect(find.text('AdminUser'), findsOneWidget);
      expect(find.textContaining(StringConstant.numberOfSubcomments),
          findsOneWidget);
    });

    testWidgets('handles tap on subcomments correctly',
        (WidgetTester tester) async {
      // Arrange
      final comment = Comment(
        id: const Id(1),
        content: const domain_text.Text('Test comment'),
        device: Device(
          id: const Id(123),
          name: Name(name: const domain_title.Title('Test Device')),
        ),
        admin: null,
        numberOfComments: const NumberOfSubTerms(2),
      );

      // Act
      await tester.pumpWidget(
        MyApp(
          child: Scaffold(
            body: DiscussWidget(comment: comment),
          ),
        ),
      );

      // Find and tap the subcomments text
      final subcommentsText =
          find.textContaining(StringConstant.numberOfSubcomments);
      expect(subcommentsText, findsOneWidget);

      await tester.tap(subcommentsText);
      await tester.pumpAndSettle();

      // Assert - Check that DiscussionScreenArgument was created
      expect(Get.isRegistered<DiscussionScreenArgument>(), isTrue);
      final argument = Get.find<DiscussionScreenArgument>();
      expect(argument.itemId, equals(1));
      expect(argument.itemType, equals('comment'));
      expect(argument.itemName, equals('Test comment'));
      expect(argument.commentEnabled, isFalse);
    });
  });
}
