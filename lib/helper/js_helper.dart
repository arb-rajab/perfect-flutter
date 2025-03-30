import 'dart:js_interop';

@JS('Blob')
class Blob {
  // Optional: Specify MIME type for the Blob (e.g., 'text/plain')
  external Blob(List<Object> parts, [BlobOptions? options]);
}

class BlobOptions {
  external String? get type;
  external factory BlobOptions({String? type});
}

@JS('document.createElement')
external Object createElement(String tagName); // Creates an HTML element

@JS('URL.createObjectURL')
external String createObjectURL(Object blob);

@JS('URL.revokeObjectURL')
external void revokeObjectURL(String url);
