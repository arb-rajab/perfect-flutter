import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MockWebViewPlatform extends InAppWebViewPlatform {
  @override
  PlatformInAppWebViewController createPlatformInAppWebViewControllerStatic() {
    return super.createPlatformInAppWebViewControllerStatic();
  }

  // @override
  // Future<void> init() async {}

  // @override
  // PlatformWebViewController createPlatformWebViewController(
  //   PlatformWebViewControllerCreationParams params,
  // ) {
  //   return MockPlatformWebViewController(params);
  // }

  // @override
  // PlatformNavigationDelegate createPlatformNavigationDelegate(
  //   PlatformNavigationDelegateCreationParams params,
  // ) {
  //   return MockPlatformNavigationDelegate(params);
  // }
}

// class MockPlatformWebViewController extends PlatformWebViewController {
//   // MockPlatformWebViewController(super.params);
//    MockPlatformWebViewController( super.params)

//   @override
//   Future<void> loadHtmlString(String html, {String? baseUrl}) async {}

//   @override
//   Future<void> loadUrl(String url, {Map<String, String>? headers}) async {}
// }

// class MockPlatformNavigationDelegate extends PlatformNavigationDelegate {
//   MockPlatformNavigationDelegate(super.params);

//   @override
//   Future<void> setOnNavigationRequest(
//     NavigationRequestCallback onNavigationRequest,
//   ) async {}
// }

// void setupWebViewMocks() {
//   TestWidgetsFlutterBinding.ensureInitialized();
//   WebViewPlatform.instance = MockWebViewPlatform();
// }
