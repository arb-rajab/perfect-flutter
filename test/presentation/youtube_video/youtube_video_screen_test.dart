import 'package:beta/constants/arguments.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/domain/value/deleted_at.dart';
import 'package:beta/domain/value/visible.dart';
import 'package:beta/main.dart';
import 'package:beta/presentation/discussion/discussion_screen.dart';
import 'package:beta/presentation/youtube_video/youtube_video_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:beta/application/services/database_service.dart';
import '../../common/tests.dart';

void main() async {
  await initTests();

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

  group('YoutubeVideoScreen Widget Tests', () {
    testWidgets('renders correctly with test argument',
        (WidgetTester tester) async {
      // Arrange
      final testArgument = YoutubeVideoScreenArgument(
        videoId: 'testVideoId',
        termData: createTestTermData(),
      );

      Get.put(testArgument);

      // Act
      await tester.pumpWidget(
        const MyApp(
          defaultRoute: YoutubeVideoScreen.route,
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(YoutubeVideoScreen), findsOneWidget);
      expect(find.text('Test Term'), findsOneWidget);
    });

    testWidgets('shows show comments button', (WidgetTester tester) async {
      // Arrange
      final testArgument = YoutubeVideoScreenArgument(
        videoId: 'testVideoId',
        termData: createTestTermData(),
      );

      Get.put(testArgument);

      // Act
      await tester.pumpWidget(
        const MyApp(
          defaultRoute: YoutubeVideoScreen.route,
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.text(StringConstant.showComments), findsOneWidget);
    });

    testWidgets('show comments button navigates to comments screen',
        (WidgetTester tester) async {
      // Arrange
      final testArgument = YoutubeVideoScreenArgument(
        videoId: 'testVideoId',
        termData: createTestTermData(),
      );

      Get.put(testArgument);

      // Act
      await tester.pumpWidget(
        const MyApp(
          defaultRoute: YoutubeVideoScreen.route,
        ),
      );
      await tester.pumpAndSettle();

      // tap the button
      await tester.tap(find.text(StringConstant.showComments));
      await tester.pumpAndSettle();

      expect(find.byType(DiscussionScreen), findsOneWidget);
    });
  });
}
