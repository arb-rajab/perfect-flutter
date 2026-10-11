import 'package:beta/domain/value/id.dart';

class DownloadItem {
  final String url;
  final String fileName;
  final Id id;
  final Types type;
  bool started;
  bool completed;

  /// Background downloads the user didn't start, which skip the completion
  /// alert.
  final bool silent;
  final Future Function() onDownload;

  DownloadItem(
      {required this.url,
      required this.fileName,
      this.started = false,
      this.completed = false,
      this.silent = false,
      required this.id,
      required this.type,
      required this.onDownload});
}

enum Types { term }
