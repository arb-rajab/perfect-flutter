import 'package:beta/application/services/database_service.dart';
import 'package:beta/constants/arguments.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/infrastructure/screenshot/shared.dart';
import 'package:beta/presentation/ebook/ebook_screen_controller.dart';
import 'package:beta/presentation/media_slider/media_slider_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';

class RecordingScreenshotRepository extends ScreenshotRepository {
  RecordingScreenshotRepository() : super(enabled: true);

  final List<bool> calls = [];

  bool? get platformPrevented => calls.isEmpty ? null : calls.last;

  @override
  Future preventScreenshot() async => calls.add(true);

  @override
  Future allowScreenshot() async => calls.add(false);
}

class TestState extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) => const SizedBox();
}

TermData termData({required int captureable}) => TermData(
  Term(
    id: 1,
    uuid: 'uuid',
    name: 'name',
    type: TermType.ebook,
    creation: '2024-01-01 11:12:13',
    enabled: 1,
    free: 1,
    ordering: 1,
    needsUpdate: 0,
    captureable: captureable,
    textCulumn: '',
    outerNote: '',
  ),
);

void main() {
  late RecordingScreenshotRepository screenshotRepository;
  // Stands in for the screen the tested screen was pushed from.
  final screenBelow = Object();

  setUp(() {
    Get.deleteAll(force: true);
    screenshotRepository = RecordingScreenshotRepository();
    Get.put<ScreenshotRepository>(screenshotRepository);
  });

  group('ebook', () {
    test('a non capturable ebook is protected until it is closed', () async {
      await screenshotRepository.setScreenshotPolicy(
        screenBelow,
        prevent: false,
      );
      Get.put(EbookScreenArgument(term: termData(captureable: 0)));

      final controller = EbookScreenController();
      expect(screenshotRepository.platformPrevented, true);

      controller.dispose();
      expect(screenshotRepository.platformPrevented, false);
    });

    test('closing a capturable ebook keeps the protected screen below it '
        'protected', () async {
      await screenshotRepository.setScreenshotPolicy(
        screenBelow,
        prevent: true,
      );
      Get.put(EbookScreenArgument(term: termData(captureable: 1)));

      final controller = EbookScreenController();
      expect(screenshotRepository.platformPrevented, false);

      controller.dispose();
      expect(screenshotRepository.platformPrevented, true);
    });
  });

  group('media slider', () {
    setUp(() => Get.put(MediaSliderScreenArgument(mediaUrls: ['url'])));

    test(
      'is protected, and closing it restores a capturable screen below it',
      () async {
        await screenshotRepository.setScreenshotPolicy(
          screenBelow,
          prevent: false,
        );

        final controller = MediaSliderController(TestState());
        expect(screenshotRepository.platformPrevented, true);

        controller.dispose();
        expect(screenshotRepository.platformPrevented, false);
      },
    );

    test('closing it keeps a protected screen below it protected', () async {
      await screenshotRepository.setScreenshotPolicy(
        screenBelow,
        prevent: true,
      );

      final controller = MediaSliderController(TestState());
      controller.dispose();
      expect(screenshotRepository.platformPrevented, true);
    });
  });
}
