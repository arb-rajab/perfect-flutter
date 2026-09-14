# Building for Android API 23 (Android 6.0)

This branch (`legacy/api23-build`) is a snapshot of the changes needed to produce an APK
that actually installs *and runs* on an API 23 device. It's not meant to be merged into
`main` — rebase it onto `main` and re-apply/re-resolve when you need another API 23 build.

## Why this needs its own branch instead of a flag

Two independent things break API 23 support as Flutter/packages move forward, and neither
is fixable with Gradle config alone:

1. **Flutter's own Gradle plugin enforces a minimum `minSdkVersion`.** Newer Flutter
   versions refuse to build below a certain floor (it was fine at `minSdkVersion 21` with
   Flutter 3.24.5, but Flutter 3.47.1 hard-fails below `minSdkVersion 23`, with a warning
   that even 23 "will soon be dropped"). This one's just a build-time check —
   `android/app/build.gradle`'s `minSdkVersion` needs to be `23`.

2. **The prebuilt Flutter engine (`libflutter.so`) itself stops running on API 23.** This
   is the real wall. At some point between Flutter 3.38.3 (confirmed working) and 3.41.0
   (confirmed broken), the engine binary started requiring bionic libc symbols
   (`__fwrite_chk`) that don't exist in Android 6.0's libc. The app installs fine but
   crashes instantly on launch with:
   ```
   UnsatisfiedLinkError: dlopen failed: cannot locate symbol "__fwrite_chk"
   ```
   No `minSdkVersion`/Gradle setting can work around this — it requires pinning an older
   Flutter SDK. **Flutter 3.38.3 is the newest version confirmed to still work on API 23.**
   If you're revisiting this later, it's worth bisecting between 3.38.3 and 3.41.0 to see
   if a slightly newer version still works before assuming 3.38.3 is still the ceiling.

## The recipe

1. **Pin Flutter via fvm**: `.fvmrc` → `3.38.3` (`fvm use 3.38.3`). Don't use the machine's
   global Flutter install for this.
2. **`android/app/build.gradle`**:
   - `minSdkVersion '23'`
   - Add `id "org.jetbrains.kotlin.android"` to the `plugins {}` block. Flutter 3.38.3
     predates the "Built-in Kotlin" auto-configuration that newer Flutter versions have, so
     the Kotlin Gradle plugin has to be applied explicitly or the `kotlin { compilerOptions
     {...} }` block later in the file fails with "Could not find method kotlin()".
3. **Downgrade packages** that had been bumped past what Flutter 3.38.3's older Dart SDK
   (3.10.1) can resolve. These were the ones that conflicted as of 2026-09; if `main` has
   moved further, expect more:
   - `flutter_stripe: ^12.6.0` (not `^14.0.0` — `^14` pulls in `flutter_stripe_web ^8.2.0`,
     which requires Flutter ≥3.41.0)
   - `flutter_stripe_web: ^7.6.0` (not `^8.2.0`)
   - `file_selector: ^1.0.3` (not `^1.1.0`, which needs Dart ^3.9.0+)
   - `share_plus: ^10.1.4` (not `^13.3.0`) — **API change**, see below
   - `package_info_plus: ^9.0.0` (not `^10.2.1`)
   - `device_info_plus: ^11.5.0` (not `^13.2.0`)
   - `mobile_scanner: ^7.2.0` (not `^7.4.0`)
   - `upgrader: ^11.4.0` (not `^13.7.0`)
   - `in_app_review: ^2.0.11` (not `^2.0.12`)
   - `pdftron_flutter: ^1.0.1-55` (not `^1.0.1-59`)
   - `file_saver: ^0.2.14` (not `^0.4.0`, which needs Dart ^3.11.0) — **API change**, see below
4. **Disable dev-only tooling** in `pubspec.yaml`'s `dev_dependencies` (comment out, don't
   delete): `build_runner`, `freezed`, `json_serializable`, `drift_dev`, `test`, `patrol`,
   `http_mock_adapter`. These aren't needed to build or run the app — generated `.g.dart`
   files are already committed — but their version floors were unsatisfiable alongside
   each other on this older Dart SDK (`freezed ^3.2.5`'s analyzer requirement doesn't
   overlap with what `flutter_test`'s pinned `test_api`/`matcher` + `drift_dev` + `test`
   can jointly resolve, regardless of which Flutter 3.3x/3.4x patch you pick). If you need
   codegen or tests, do that on `main` with the normal toolchain, then bring the generated
   files over — don't try to re-enable these here.
5. **Fix call sites broken by the `share_plus`/`file_saver` downgrades** — these packages
   changed their public API between the versions above and what `main` currently uses:
   - `share_plus` ^13.x uses `SharePlus.instance.share(ShareParams(...))`; ^10.1.4 uses the
     older static API: `Share.share(text)` / `Share.shareXFiles(files, subject: ...)`.
     Affected: `lib/application/services/share_service.dart`,
     `lib/presentation/home/drawer_widget.dart`,
     `lib/application/services/database/native.dart`.
   - `file_saver` ^0.4.x's `saveAs()` takes `fileExtension:`; ^0.2.14's takes `ext:`.
     Affected: `lib/presentation/home/drawer_widget.dart`.

## Verifying it actually works

Building successfully is not enough — the engine crash above only shows up at runtime, not
build time. Always install and launch on a real API 23 emulator/device before trusting the
build:

```
adb install -r build/app/outputs/flutter-apk/app-release.apk
adb shell am start -n edu.perfect/.MainActivity
adb logcat -d | grep -E "edu.perfect|FATAL|UnsatisfiedLink"
```

Look for `Displayed edu.perfect/.MainActivity` with no `FATAL EXCEPTION` /
`UnsatisfiedLinkError` — that's confirmation the engine actually loaded, not just that
Gradle produced an APK.

## Rebasing this branch for a future release

1. `git checkout legacy/api23-build && git rebase main`
2. Re-resolve: `fvm flutter pub get` — new conflicts here mean `main` bumped something
   else past what Dart 3.10.1 supports. Same drill: find the oldest still-required version,
   or confirm whether a newer Flutter (>3.38.3) has re-gained API 23 engine support.
3. Rebuild and re-verify on an API 23 emulator per the steps above before shipping.
