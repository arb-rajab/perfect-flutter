import 'package:beta/application/services/term_last_access_service.dart';
import 'package:beta/constants/arguments.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/domain/value/deleted_at.dart';
import 'package:beta/domain/value/visible.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/infrastructure/screenshot/shared.dart';
import 'package:beta/presentation/youtube_video/youtube_video_screen_controller.dart';
import 'package:beta/presentation/youtube_video/youtube_video_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

// Import the database service to access TermsLastAccess and Term
import 'package:beta/application/services/database_service.dart';

import '../../common/tests.dart';

// Mock classes
class MockTermLastAccessService extends Mock implements TermLastAccessService {
  @override
  Future<int> addTermLastAccessed(Id termId, int childId) => Future.value(1);
}

class MockScreenshotRepository extends ScreenshotRepository {
  @override
  Future preventScreenshot() => Future.value();

  @override
  Future allowScreenshot() => Future.value();
}

class MockInAppWebViewController extends Mock
    implements InAppWebViewController {
  @override
  Future<void> loadUrl(
          {required URLRequest urlRequest,
          WebUri? allowingReadAccessTo,
          Uri? iosAllowingReadAccessTo}) =>
      Future.value();

  @override
  Future<dynamic> evaluateJavascript(
          {required String source, ContentWorld? contentWorld}) =>
      Future.value('');
}

class MockBuildContext extends Mock implements BuildContext {}

class MockTermsLastAccess extends Mock implements TermsLastAccess {}

// Simple implementation of State for testing
class TestState extends State<YoutubeVideoScreen> {
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

// Fake class for Id
class FakeId extends Fake implements Id {}

void main() {
  late YoutubeVideoScreenController controller;
  late MockTermLastAccessService mockTermLastAccessService;
  late MockScreenshotRepository mockScreenshotRepository;
  late TestState mockState;
  late MockBuildContext mockContext;
  late YoutubeVideoScreenArgument testArgument;

  // Helper function to create test TermData
  TermData createTestTermData() {
    return TermData(
      const Term(
        id: 1,
        uuid: 'test-uuid',
        name: 'Test Term',
        type: 4, // youtubeVideos type
        creation: '2023-01-01 00:00:00',
        enabled: 1,
        free: 1,
        ordering: 1,
        needsUpdate: 0,
        captureable: 1,
        textCulumn: '',
        outerNote: '',
      ),
      deletedAt: const DeletedAt(null),
      visible: const Visible(1),
    );
  }

  setUpAll(() {
    registerFallbackValue(FakeId());
  });

  setUp(() async {
    await initTests();
    // Initialize mocks
    mockTermLastAccessService = MockTermLastAccessService();
    mockScreenshotRepository = MockScreenshotRepository();
    mockContext = MockBuildContext();
    mockState = TestState();
    mockState.context = mockContext;

    // Create test argument
    testArgument = YoutubeVideoScreenArgument(
      videoId: 'testVideoId',
      termData: createTestTermData(),
    );

    // Mock Get.find calls
    Get.delete<TermLastAccessService>();
    Get.delete<ScreenshotRepository>();
    Get.delete<YoutubeVideoScreenArgument>();
    Get.put<TermLastAccessService>(mockTermLastAccessService);
    Get.put<ScreenshotRepository>(mockScreenshotRepository);
    Get.put<YoutubeVideoScreenArgument>(testArgument);

    // Create controller
    controller = YoutubeVideoScreenController(mockState);
  });

  tearDown(() {
    Get.reset();
  });

  group('YoutubeVideoScreenController', () {
    test('initializes with correct values', () {
      expect(controller.argument, testArgument);
      expect(controller.screenshotRepository, mockScreenshotRepository);
      expect(controller.termLastAccessService, mockTermLastAccessService);
      expect(controller.visible, false);
      expect(controller.finishedLoading, false);
    });

    group('getLastSecond', () {
      test('loads video at last watched time when available', () async {
        // Arrange
        final mockTermsLastAccess = MockTermsLastAccess();
        when(() => mockTermsLastAccess.childId).thenReturn(30);
        when(() => mockTermLastAccessService
                .getTermLastAccess(testArgument.termData.term.id))
            .thenAnswer((_) async => mockTermsLastAccess);

        // Create a mock controller for testing
        final mockController = MockInAppWebViewController();
        controller.controller = mockController;

        // Act
        await controller.getLastSecond();

        // Assert
        verify(() => mockTermLastAccessService
            .getTermLastAccess(testArgument.termData.term.id)).called(1);
      });

      test('loads video from beginning when no last watched time', () async {
        // Arrange
        when(() => mockTermLastAccessService.getTermLastAccess(
            testArgument.termData.term.id)).thenAnswer((_) async => null);

        // Create a mock controller for testing
        final mockController = MockInAppWebViewController();
        controller.controller = mockController;

        // Act
        await controller.getLastSecond();

        // Assert
        verify(() => mockTermLastAccessService
            .getTermLastAccess(testArgument.termData.term.id)).called(1);
      });
    });

    group('onProgressChanged', () {
      test('updates state when progress reaches 100%', () {
        // Arrange
        final mockController = MockInAppWebViewController();
        controller.finishedLoading = false;

        // Act
        controller.onProgressChanged(mockController, 100);

        // Assert
        expect(controller.finishedLoading, true);
        expect(controller.visible, true);
      });
    });
  });
}
