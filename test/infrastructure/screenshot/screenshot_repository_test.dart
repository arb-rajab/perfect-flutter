import 'package:beta/abstract/screenshot_repository_base.dart';
import 'package:beta/constants/other_constants.dart';
import 'package:flutter_test/flutter_test.dart';

class RecordingScreenshotRepository extends ScreenshotRepositoryBase {
  RecordingScreenshotRepository({super.enabled = true});

  final List<bool> calls = [];

  bool? get platformPrevented => calls.isEmpty ? null : calls.last;

  @override
  Future preventScreenshot() async => calls.add(true);

  @override
  Future allowScreenshot() async => calls.add(false);
}

void main() {
  late RecordingScreenshotRepository repository;
  final a = Object(), b = Object(), c = Object();

  setUp(() => repository = RecordingScreenshotRepository());

  test('the topmost screen decides', () async {
    await repository.setScreenshotPolicy(a, prevent: true);
    expect(repository.platformPrevented, true);

    await repository.setScreenshotPolicy(b, prevent: false);
    expect(repository.platformPrevented, false);
  });

  test('popping a capturable screen restores protection for the protected '
      'screens below it', () async {
    await repository.setScreenshotPolicy(a, prevent: true);
    await repository.setScreenshotPolicy(b, prevent: true);
    await repository.setScreenshotPolicy(c, prevent: false);
    expect(repository.platformPrevented, false);

    await repository.releaseScreenshotPolicy(c);
    expect(repository.platformPrevented, true);

    await repository.releaseScreenshotPolicy(b);
    expect(repository.platformPrevented, true);

    await repository.releaseScreenshotPolicy(a);
    expect(repository.platformPrevented, false);
  });

  test('re-applying the revealed screen\'s policy before the popped screen is '
      'released keeps protection', () async {
    await repository.setScreenshotPolicy(b, prevent: true);
    await repository.setScreenshotPolicy(c, prevent: false);

    // The revealed screen reconfigures at the start of the pop transition,
    // and the popped screen is only disposed once the transition ends.
    await repository.setScreenshotPolicy(b, prevent: true);
    await repository.releaseScreenshotPolicy(c);

    expect(repository.platformPrevented, true);
  });

  test('updating a screen\'s policy keeps its position in the stack', () async {
    await repository.setScreenshotPolicy(a, prevent: true);
    await repository.setScreenshotPolicy(b, prevent: false);

    // e.g. a finishes loading its term after b was pushed.
    await repository.setScreenshotPolicy(a, prevent: true);
    expect(repository.platformPrevented, false);
  });

  test('releasing a screen that is not on top changes nothing', () async {
    await repository.setScreenshotPolicy(a, prevent: false);
    await repository.setScreenshotPolicy(b, prevent: true);
    repository.calls.clear();

    await repository.releaseScreenshotPolicy(a);
    expect(repository.calls, isEmpty);
    expect(repository.screenshotsPrevented, true);
  });

  test('releasing an unknown screen is a no-op', () async {
    await repository.setScreenshotPolicy(a, prevent: true);
    repository.calls.clear();

    await repository.releaseScreenshotPolicy(b);
    expect(repository.calls, isEmpty);
  });

  test('screenshots are allowed when no screen requires protection', () {
    expect(repository.screenshotsPrevented, false);
  });

  group('protection disabled', () {
    test('is the app default', () {
      expect(kScreenCaptureProtectionEnabled, false);
    });

    test('policies never reach the platform', () async {
      final disabled = RecordingScreenshotRepository(enabled: false);

      await disabled.setScreenshotPolicy(a, prevent: true);
      await disabled.setScreenshotPolicy(b, prevent: true);
      await disabled.releaseScreenshotPolicy(b);
      await disabled.releaseScreenshotPolicy(a);

      expect(disabled.calls, isEmpty);
      expect(disabled.screenshotsPrevented, false);
    });
  });
}
