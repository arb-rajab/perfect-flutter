import 'package:beta/application/services/database_service.dart';

class VideoFileData {
  VideoFile videoFile;
  Uri? url;
  VideoFileData(this.videoFile, {this.url});

  static VideoFileData fromJson(Map<String, dynamic> json) {
    VideoFileData termData = VideoFileData(VideoFile.fromJson(json));
    termData.url = Uri.parse(json['url']);
    return termData;
  }

  Map toJson() => {...videoFile.toJson(), 'url': url!.toString()};

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VideoFileData && other.videoFile == videoFile);

  @override
  int get hashCode => Object.hash(videoFile, url);
}
