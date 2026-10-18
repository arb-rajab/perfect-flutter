# beta

A new Flutter project.

## Screenshots

<p>
  <img src="docs/screenshots/home.png" width="240" alt="Home screen">
  <img src="docs/screenshots/settings.png" width="240" alt="Settings screen">
</p>

These images are regenerated automatically. When a push to a feature branch
touches UI code (`lib/presentation`, `assets`, ...), the *Update screenshots*
workflow runs `flutter test --update-goldens test/screenshots` and commits any
changed images back to the branch. To regenerate them locally, run the same
command. A plain `flutter test` compares against the committed images, so UI
changes made without updating them fail the test.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Please download web view for flutter web, in order to use the dependency required for renderning pdf files
https://dev.apryse.com/?platform=web