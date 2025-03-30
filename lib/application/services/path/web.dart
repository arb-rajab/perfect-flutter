import 'package:beta/helper/js_helper.dart';
import 'package:beta/abstract/path_base.dart';
import 'package:web/web.dart' show Element;

class PathService implements PathBase {
  @override
  Future deleteFileFromSupport(String file) {
    // TODO: implement deleteFileFromSupport
    throw UnimplementedError();
  }

  @override
  Future<bool> isFileInSupport(String file) {
    // TODO: implement isFileInSupport
    throw UnimplementedError();
  }

  @override
  Future<bool> saveFile({required String fileName, required String content}) {
    
    // Create a Blob object with the file content
    final blob = Blob([content], BlobOptions(type: 'text/plain'));

    // Generate a URL for the Blob
    final url = createObjectURL(blob);

    // Dynamically create an anchor element using `createElement`
    final anchor = createElement('a') as Element; // Dynamically create anchor
    anchor.setAttribute(
        'href', url); // Set the 'href' attribute to the Blob URL
    anchor.setAttribute('download', fileName); // Specify the download file name

    // Append to document temporarily
    final documentBody = createElement('body') as Element;
    documentBody.appendChild(anchor);

    // Simulate click to start download
    (anchor as dynamic).click();

    // Remove the anchor and clean up the Blob URL
    documentBody.removeChild(anchor);
    revokeObjectURL(url);
    return Future.value(true);
  }

  @override
  Future<bool> isFilePartsInSupport(List<String> parts) {
    // TODO: implement isFilePartsInSupport
    throw UnimplementedError();
  }

  @override
  Future<String> getFileSupportPath(List<String> parts) {
    // TODO: implement getFileSupportPath
    throw UnimplementedError();
  }
}
