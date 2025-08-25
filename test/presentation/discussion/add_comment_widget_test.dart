import 'package:beta/application/services/user_service.dart';
import 'package:beta/constants/api_constant.dart';
import 'package:beta/constants/arguments.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/infrastructure/key_value_repository.dart';
import 'package:beta/main.dart';
import 'package:beta/presentation/discussion/add_comment_widget.dart';
import 'package:beta/presentation/discussion/discussion_screen.dart';
import 'package:beta/presentation/discussion/discussion_screen_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';
import 'package:mocktail/mocktail.dart';

import '../../common/tests.dart';

class MockKeyValue extends Mock implements KeyValue {}

void main() {
  late MockKeyValue mockKeyValue;
  setUp(() async {
    await initTests();
    mockKeyValue = MockKeyValue();
    Get.put(DiscussionScreenArgument(
        itemId: 1, itemType: 'video', itemName: 'video name'));

    dioAdapter.onGet(
        ApiConstant.getComments
            .replaceFirst('(ITEM_TYPE)', 'video')
            .replaceFirst('(ITEM_ID)', '1'), (server) {
      server.reply(200, r'''{"comments":[],"result","success","message":""}''');
    });

    // Mock KeyValue methods
    when(() => mockKeyValue.getString(any())).thenReturn('123');
    when(() => mockKeyValue.getBool(any(), any())).thenReturn(false);
    when(() => mockKeyValue.setString(any(), any())).thenAnswer((_) async {});
    when(() => mockKeyValue.setBool(any(), any())).thenAnswer((_) async {});

    Get.put(UserService(keyValue: mockKeyValue));
  });

  Future loadScreen(WidgetTester tester) async {
    await tester.pumpWidget(MyApp(
      defaultRoute: DiscussionScreen.route
          .replaceAll(':itemType', 'video')
          .replaceAll(':itemId', '1'),
    ));
    await tester.pumpAndSettle();
  }

  group('AddCommentWidget Tests', () {
    testWidgets('renders correctly with text field and submit button',
        (WidgetTester tester) async {
      // Act
      await loadScreen(tester);

      // Assert
      expect(find.byType(AddCommentWidget), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.byType(IconButton), findsOneWidget);
      expect(find.byIcon(Icons.send), findsOneWidget);
    });

    testWidgets('shows loading indicator when submitting',
        (WidgetTester tester) async {
      // Act
      await loadScreen(tester);

      await tester.enterText(find.byType(TextFormField), 'text');

      await tester.tap(find.byIcon(Icons.send));
      await tester.pump();
      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byIcon(Icons.send), findsNothing);

      await tester.pumpAndSettle();
    });

    testWidgets('does not show loading indicator text is empty',
        (WidgetTester tester) async {
      // Act
      await loadScreen(tester);

      await tester.tap(find.byIcon(Icons.send));
      await tester.pump();
      // Assert
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byIcon(Icons.send), findsOneWidget);
    });

    testWidgets('shows error when no connection on submit',
        (WidgetTester tester) async {
      // Use existing mockNoConnection helper to simulate no connection
      mockNoConnection(
          route: ApiConstant.submitComment,
          method: 'post',
          data: FormData.fromMap(
              {'content': 'text', 'itemId': '1', 'itemType': 'video'}));

      // Act
      await loadScreen(tester);

      await tester.enterText(find.byType(TextFormField), 'text');

      await tester.tap(find.byIcon(Icons.send));
      await tester.pumpAndSettle();

      DiscussionScreenController discussionScreenController =
          Get.find(tag: 'video1');

      expect(
          discussionScreenController.messageTest, StringConstant.noConnection);
    });

    testWidgets('shows message when a message is recieved',
        (WidgetTester tester) async {
      mockMessageRecieved(
          route: ApiConstant.submitComment,
          method: 'post',
          data: FormData.fromMap(
              {'content': 'text', 'itemId': '1', 'itemType': 'video'}));

      // Act
      await loadScreen(tester);

      DiscussionScreenController discussionScreenController =
          Get.find(tag: 'video1');

      expect(discussionScreenController.messageTest, '');

      await tester.enterText(find.byType(TextFormField), 'text');

      await tester.tap(find.byIcon(Icons.send));
      await tester.pumpAndSettle();

      expect(discussionScreenController.messageTest, "a message recieved");
    });

    testWidgets('text field accepts input correctly',
        (WidgetTester tester) async {
      // Act
      await loadScreen(tester);

      // Enter text in the text field
      await tester.enterText(find.byType(TextFormField), 'Test comment');
      await tester.pumpAndSettle();

      DiscussionScreenController discussionScreenController =
          Get.find(tag: 'video1');

      TextEditingController textEditingController =
          discussionScreenController.submitController;

      // Assert
      expect(textEditingController.text, equals('Test comment'));
    });

    testWidgets('shows send icon when not submitting',
        (WidgetTester tester) async {
      // Act
      await loadScreen(tester);

      // Assert
      expect(find.byIcon(Icons.send), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('recieved comment is added', (WidgetTester tester) async {
      dioAdapter.onPost(ApiConstant.submitComment, (server) {
        server.reply(200,
            r'''{"comment":{"id":1,"content":"comment","numberOfComments":0,"device":{"name":{"name":"random"}}},"result":"success","message":""}''');
      },
          data: FormData.fromMap(
              {'content': 'comment', 'itemId': '1', 'itemType': 'video'}));

      // Act
      await loadScreen(tester);

      await tester.enterText(find.byType(TextFormField), 'comment');

      // Simulate receiving a message after submit
      await tester.tap(find.byIcon(Icons.send));
      await tester.pumpAndSettle();

      DiscussionScreenController discussionScreenController =
          Get.find(tag: 'video1');

      expect(discussionScreenController.items.length, 1);
    });
  });
}
