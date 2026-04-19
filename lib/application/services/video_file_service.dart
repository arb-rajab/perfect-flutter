import 'package:beta/application/services/database_service.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/domain/video_file_data.dart';

class VideoFileService {
  final DatabaseService databaseService;

  VideoFileService({required this.databaseService});

  Future addVideoFile(VideoFileData videoFileData) => databaseService
      .into(databaseService.videoFiles)
      .insertOnConflictUpdate(videoFileData.videoFile);

  Future<VideoFile> getVideoFile(TermData termData) => (databaseService
          .select(databaseService.videoFiles)
        ..where((videoFile) => videoFile.parentTermId.equals(termData.term.id)))
      .getSingle();
}
