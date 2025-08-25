import 'package:beta/abstract/device_repository_base.dart';
import 'package:beta/application/services/theme_service.dart';
import 'package:beta/application/services/tutorial_service.dart';
import 'package:beta/constants/api_constant.dart';
import 'package:beta/constants/arguments.dart';
import 'package:beta/constants/key_value_constant.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/infrastructure/key_value_repository.dart';
import 'package:beta/infrastructure/package_repository.dart';
import 'package:beta/presentation/discussion/add_comment_widget.dart';
import 'package:beta/presentation/discussion/discussion_screen.dart';
import 'package:beta/presentation/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

import '../../common/tests.dart';

class MockKeyValue extends Mock implements KeyValue {}

class MockDeviceRepository extends Mock implements DeviceRepositoryBase {}

class MockPackageRepository extends Mock implements PackageRepository {}

class MockUserService extends Mock {}

class FakeBuildContext extends Fake implements BuildContext {}

void main() async {
  setUpAll(() {
    registerFallbackValue(FakeBuildContext());
  });
  await initTests();
  // final dioAdapter = DioAdapter(dio: NetworkService.dio);

  // Add service mocks
  setUp(() {
    final mockKeyValue = MockKeyValue();
    final mockDeviceRepository = MockDeviceRepository();
    final mockPackageRepository = MockPackageRepository();

    // Mock KeyValue methods for TutorialService
    when(() => mockKeyValue.getStringList(any())).thenReturn(null);
    when(() => mockKeyValue.setStringList(any(), any()))
        .thenAnswer((_) async {});

    // Mock KeyValue methods for ThemeService
    when(() => mockKeyValue.getString(KeyValueConstant.theme, any()))
        .thenReturn(KeyValueConstant.themeDefaultValue);
    when(() => mockKeyValue.getDouble(KeyValueConstant.textScaleFactor, any()))
        .thenReturn(KeyValueConstant.textScaleFactorDefaultValue);
    when(() => mockKeyValue.setString(any(), any())).thenAnswer((_) async {});
    when(() => mockKeyValue.setDouble(any(), any())).thenAnswer((_) async {});

    // Mock DeviceRepository methods
    when(() => mockDeviceRepository.initialise())
        .thenAnswer((_) async => mockDeviceRepository);
    when(() => mockDeviceRepository.getModel()).thenReturn('Test Device');
    when(() => mockDeviceRepository.getAndroidApi()).thenReturn('30');
    when(() => mockDeviceRepository.getIosVersion()).thenReturn('15.0');
    when(() => mockDeviceRepository.isRooted()).thenReturn(0);
    when(() => mockDeviceRepository.isEmulator()).thenReturn(0);
    when(() => mockDeviceRepository.getFullInfo(any()))
        .thenReturn('{"test": "data"}');

    // Mock PackageRepository methods
    when(() => mockPackageRepository.initialise())
        .thenAnswer((_) async => mockPackageRepository);
    when(() => mockPackageRepository.getVersionCode()).thenReturn('1');
    when(() => mockPackageRepository.getVersionName()).thenReturn('1.0.0');
    when(() => mockPackageRepository.getPackageName())
        .thenReturn('com.test.app');
    when(() => mockPackageRepository.getApplicationName())
        .thenReturn('Test App');
    when(() => mockPackageRepository.isInitialised).thenReturn(true);

    Get.put(TutorialService(keyValue: mockKeyValue));
    Get.put(ThemeService(keyValue: mockKeyValue));
    Get.put<DeviceRepositoryBase>(mockDeviceRepository);
    Get.put(mockPackageRepository);
  });

  tearDown(() {
    Get.reset();
  });

  group('DiscussionScreen Widget Tests', () {
    testWidgets('renders correctly with test argument',
        (WidgetTester tester) async {
      // Arrange
      final testArgument = DiscussionScreenArgument(
        itemId: 1,
        itemType: 'video',
        itemName: 'Test Video',
      );

      Get.put(testArgument);

      dioAdapter.onGet(
        ApiConstant.getComments
            .replaceAll('(ITEM_TYPE)', 'video')
            .replaceAll('(ITEM_ID)', '1'),
        (server) => server.reply(
          200,
          '{"result":"success","comments":[]}',
        ),
      );

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: DiscussionScreen(type: 'video', id: '1'),
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(DiscussionScreen), findsOneWidget);
      // Just check that the widget is rendered without errors
    });

    testWidgets('shows add comment widget when commentEnabled is true',
        (WidgetTester tester) async {
      // Arrange
      final testArgument = DiscussionScreenArgument(
        itemId: 1,
        itemType: 'video',
        itemName: 'Test Video',
        commentEnabled: true,
      );

      Get.put(testArgument);

      dioAdapter.onGet(
        ApiConstant.getComments
            .replaceAll('(ITEM_TYPE)', 'video')
            .replaceAll('(ITEM_ID)', '1'),
        (server) => server.reply(
          200,
          '{"result":"success","comments":[]}',
        ),
      );

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: DiscussionScreen(type: 'video', id: '1'),
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(AddCommentWidget), findsOneWidget);
    });

    testWidgets('does not show add comment widget when commentEnabled is false',
        (WidgetTester tester) async {
      // Arrange
      final testArgument = DiscussionScreenArgument(
        itemId: 1,
        itemType: 'video',
        itemName: 'Test Video',
        commentEnabled: false,
      );

      Get.put(testArgument);

      dioAdapter.onGet(
        ApiConstant.getComments
            .replaceAll('(ITEM_TYPE)', 'video')
            .replaceAll('(ITEM_ID)', '1'),
        (server) => server.reply(
          200,
          '{"result":"success","comments":[]}',
        ),
      );

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: DiscussionScreen(type: 'video', id: '1'),
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(AddCommentWidget), findsNothing);
    });

    testWidgets('shows loading widget before API response',
        (WidgetTester tester) async {
      // Arrange
      final testArgument = DiscussionScreenArgument(
        itemId: 1,
        itemType: 'video',
        itemName: 'Test Video',
      );

      Get.put(testArgument);

      // Mock delayed response
      dioAdapter.onGet(
        ApiConstant.getComments
            .replaceAll('(ITEM_TYPE)', 'video')
            .replaceAll('(ITEM_ID)', '1'),
        (server) => server.reply(
          200,
          '{"result":"success","comments":[]}',
          delay: const Duration(milliseconds: 500),
        ),
      );

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: DiscussionScreen(type: 'video', id: '1'),
        ),
      );

      // Assert - loading widget should be visible initially
      expect(find.byType(LoadingWidget), findsOneWidget);

      // Wait for the response
      await tester.pumpAndSettle();

      // Assert - loading widget should be gone after response
      expect(find.byType(LoadingWidget), findsNothing);
    });

    testWidgets('handles no connection error', (WidgetTester tester) async {
      // Arrange
      final testArgument = DiscussionScreenArgument(
        itemId: 1,
        itemType: 'video',
        itemName: 'Test Video',
      );

      Get.put(testArgument);

      // Use the helper function from tests.dart for no connection
      mockNoConnection(
          route: ApiConstant.getComments
              .replaceAll('(ITEM_TYPE)', 'video')
              .replaceAll('(ITEM_ID)', '1'));

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: DiscussionScreen(type: 'video', id: '1'),
        ),
      );
      await tester.pumpAndSettle();

      // Assert - should handle the error gracefully
      expect(find.text(StringConstant.noConnection), findsOneWidget);
      // The error handling should prevent crashes
    });
    testWidgets('handles server error message', (WidgetTester tester) async {
      // Arrange
      final testArgument = DiscussionScreenArgument(
        itemId: 1,
        itemType: 'video',
        itemName: 'Test Video',
      );

      Get.put(testArgument);

      // Mock server error message
      mockMessageRecieved(
          route: ApiConstant.getComments
              .replaceAll('(ITEM_TYPE)', 'video')
              .replaceAll('(ITEM_ID)', '1'));

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: DiscussionScreen(type: 'video', id: '1'),
        ),
      );
      await tester.pumpAndSettle();

      // Assert - should handle the error message gracefully
      expect(find.text("a message recieved"), findsOneWidget);
      // The error handling should prevent crashes and show appropriate feedback
    });
  });
}
