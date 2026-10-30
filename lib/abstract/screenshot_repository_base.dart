import 'package:beta/constants/other_constants.dart';

class _ScreenshotRequest {
  final Object owner;
  bool prevent;
  _ScreenshotRequest(this.owner, this.prevent);
}

/// Screenshot prevention is a single global platform switch, so screens must
/// not toggle it directly: a screen being disposed after the screen below it
/// was revealed would otherwise undo that screen's setting. Instead every
/// screen registers its requirement here and the topmost (most recently
/// registered) screen decides.
///
/// When [enabled] is false (the default is [kScreenCaptureProtectionEnabled])
/// no requirement is recorded and the platform is never asked to block capture.
abstract class ScreenshotRepositoryBase {
  ScreenshotRepositoryBase({this.enabled = kScreenCaptureProtectionEnabled});

  final bool enabled;
  final List<_ScreenshotRequest> _requests = [];
  bool? _applied;

  /// Platform toggles. Only called by [_apply].
  Future preventScreenshot();
  Future allowScreenshot();

  /// Registers [owner] as the topmost screen with the given requirement, or
  /// updates its requirement in place if it is already registered (so a
  /// screen finishing an async load doesn't jump above screens pushed since).
  Future setScreenshotPolicy(Object owner, {required bool prevent}) {
    if (!enabled) return Future.value();
    final index = _requests.indexWhere((r) => identical(r.owner, owner));
    if (index == -1) {
      _requests.add(_ScreenshotRequest(owner, prevent));
    } else {
      _requests[index].prevent = prevent;
    }
    return _apply();
  }

  /// Removes [owner]'s requirement; the screen now on top decides again.
  Future releaseScreenshotPolicy(Object owner) {
    if (!enabled) return Future.value();
    _requests.removeWhere((r) => identical(r.owner, owner));
    return _apply();
  }

  bool get screenshotsPrevented =>
      _requests.isNotEmpty && _requests.last.prevent;

  Future _apply() {
    final prevent = screenshotsPrevented;
    if (_applied == prevent) return Future.value();
    _applied = prevent;
    return prevent ? preventScreenshot() : allowScreenshot();
  }
}
