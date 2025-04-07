import 'dart:js_interop';

@JS('document.createElement')
external JSObject createElement(String tagName); // Creates an HTML element

@JS()
@staticInterop
class JSObject {
  // This serves as a generic type for JS interop objects
}
