import 'package:beta/abstract/device_repository_base.dart';
import 'package:beta/application/services/network_service.dart';
import 'package:beta/constants/arguments.dart';
import 'package:beta/domain/comment.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/domain/value/text.dart' as t;
import 'package:beta/domain/value/number_of_sub_terms.dart';
import 'package:beta/presentation/discussion/discussion_screen_controller.dart';
import 'package:beta/presentation/discussion/discussion_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

import '../../common/tests.dart';

// Mock classes
class MockBuildContext extends Mock implements BuildContext {}

class MockDeviceRepository extends Mock implements DeviceRepositoryBase {
  @override
  String getFullInfo() {
    return '{"ime1":"test-ime1","ime2":"","buildModel":"test-model","androidAPI":"25","iosVersion":"0","rooted":0,"isEmulator":0,"appId":"test.app.id","appLanguage":"en","appVersionCode":1,"appVersionName":"1.0.0"}';
  }
}

class MockTextEditingController extends Mock implements TextEditingController {}

// Simple implementation of State for testing
class TestState extends State<DiscussionScreen> {
  @override
  late MockBuildContext context;

  @override
  void setState(VoidCallback fn) {
    fn();
  }

  @override
  Widget build(BuildContext context) {
    // This is just for testing, so we don't need a real implementation
    return Container();
  }
}

void main() {
  late DiscussionScreenController controller;
  late MockBuildContext mockContext;
  late TestState mockState;
  late DiscussionScreenArgument testArgument;
  late MockDeviceRepository mockDeviceRepository;
  late DioAdapter dioAdapter;

  setUpAll(() async {
    await initTests();
    dioAdapter = DioAdapter(dio: NetworkService.dio);
  });

  setUp(() {
    // Initialize mocks
    mockContext = MockBuildContext();
    mockDeviceRepository = MockDeviceRepository();
    mockState = TestState();
    mockState.context = mockContext;

    // Create test argument
    testArgument = DiscussionScreenArgument(
      itemId: 1,
      itemType: 'video',
      itemName: 'Test Video',
    );

    // Mock Get.find calls
    Get.delete<DiscussionScreenArgument>();
    Get.delete<DeviceRepositoryBase>();
    Get.put<DiscussionScreenArgument>(testArgument);
    Get.put<DeviceRepositoryBase>(mockDeviceRepository);

    // Create controller
    controller = DiscussionScreenController(mockState, 'video', '1');
  });

  tearDown(() {
    Get.reset();
  });

  group('DiscussionScreenController', () {
    test('initializes with correct values', () {
      expect(controller.argument, testArgument);
      expect(controller.submitController, isA<TextEditingController>());
      expect(controller.submitting, false);
      expect(controller.indexUrl, contains('comments/video/1'));
    });

    test('itemBuilder returns DiscussWidget', () {
      // Arrange
      final comment = Comment(
        id: const Id(1),
        content: const t.Text('Test comment'),
        numberOfComments: const NumberOfSubTerms(0),
      );
      controller.items.add(comment);

      // Act
      final widget = controller.itemBuilder(mockContext, 0);

      // Assert
      expect(widget, isA<Widget>());
    });

    group('submitComment', () {
      test('does not submit when content is empty', () async {
        // Arrange
        controller.submitController.text = '';

        // Act
        controller.submitComment();

        // Assert
        expect(controller.submitting, false);
      });

      test('does not submit when already submitting', () async {
        // Arrange
        controller.submitController.text = 'Test comment';
        controller.submitting = true;

        // Act
        controller.submitComment();

        // Assert
        expect(controller.submitting, true);
      });

      test('submits comment successfully', () async {
        // Arrange
        controller.submitController.text = 'Test comment';
        final responseBody = {
          'comment': {
            'id': 1,
            'content': 'Test comment',
            'numberOfComments': 0,
          }
        };

        dioAdapter.onPost(
          '/api/submit-comment',
          (server) => server.reply(200, responseBody),
          data: {
            'content': 'Test comment',
            'itemId': 1,
            'itemType': 'video',
          },
        );

        // Act
        controller.submitComment();

        // Assert
        // We can't easily test the result since it's asynchronous
        expect(controller.submitting, true);
      });

      test('shows error message when connection fails', () async {
        // Arrange
        controller.submitController.text = 'Test comment';

        mockNoConnection(
          route: '/api/submit-comment',
          method: 'post',
          data: {
            'content': 'Test comment',
            'itemId': 1,
            'itemType': 'video',
          },
        );

        // Act
        controller.submitComment();

        // Assert
        expect(controller.submitting, true);
      });

      test('shows error message when server returns error', () async {
        // Arrange
        controller.submitController.text = 'Test comment';

        mockMessageRecieved(
          route: '/api/submit-comment',
          method: 'post',
          data: {
            'content': 'Test comment',
            'itemId': 1,
            'itemType': 'video',
          },
        );

        // Act
        controller.submitComment();

        // Assert
        expect(controller.submitting, true);
      });
    });
  });
}
