import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/video_file_service.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/domain/video_file_data.dart';
import 'package:get/instance_manager.dart';
import 'package:test/test.dart';

import '../../common/tests.dart';

void main() {
  late VideoFileService videoFileService;
  setUp(() async {
    await initTests();
    videoFileService = Get.find();
  });

  VideoFileData createTestVideoFileData({
    int parentTermId = 1,
    String encryptionKey = 'key',
    String creation = '2023-01-01T00:00:00Z',
  }) {
    final videoFile = VideoFile(
      encryptionKey: encryptionKey,
      parentTermId: parentTermId,
      creation: creation,
    );
    return VideoFileData(videoFile);
  }

  TermData createTestTermData({
    int id = 1,
    String uuid = 'uuid-1',
    String name = 'Test Term',
    int type = 2,
    String creation = '2023-01-01T00:00:00Z',
    int enabled = 1,
    int free = 0,
    int ordering = 0,
    int needsUpdate = 0,
    int captureable = 1,
    String textCulumn = 'text',
    String outerNote = '',
  }) {
    final term = Term(
      id: id,
      uuid: uuid,
      name: name,
      type: type,
      creation: creation,
      enabled: enabled,
      free: free,
      ordering: ordering,
      needsUpdate: needsUpdate,
      captureable: captureable,
      textCulumn: textCulumn,
      outerNote: outerNote,
    );
    return TermData(term);
  }

  test('addVideoFile inserts videoFile with conflict resolution', () async {
    final videoFileData = createTestVideoFileData(parentTermId: 1);

    await videoFileService.addVideoFile(videoFileData);

    final storedVideoFiles =
        await databaseService.select(databaseService.videoFiles).get();
    expect(storedVideoFiles.length, 1);
    expect(storedVideoFiles.first.parentTermId, 1);
    expect(storedVideoFiles.first.encryptionKey, 'key');
  });

  test('addVideoFile updates existing videoFile on conflict', () async {
    final initialVideoFile =
        createTestVideoFileData(parentTermId: 1, encryptionKey: 'key1');
    await databaseService
        .into(databaseService.videoFiles)
        .insert(initialVideoFile.videoFile);

    final updatedVideoFile =
        createTestVideoFileData(parentTermId: 1, encryptionKey: 'key2');
    await videoFileService.addVideoFile(updatedVideoFile);

    final storedVideoFiles =
        await databaseService.select(databaseService.videoFiles).get();
    expect(storedVideoFiles.length, 1);
    expect(storedVideoFiles.first.encryptionKey, 'key2');
  });

  test('getVideoFile returns the correct videoFile for a term', () async {
    final termData = createTestTermData(id: 2);
    final videoFileData = createTestVideoFileData(parentTermId: 2);

    await videoFileService.addVideoFile(videoFileData);

    final videoFile = await videoFileService.getVideoFile(termData);
    expect(videoFile.parentTermId, 2);
    expect(videoFile.encryptionKey, 'key');
  });
}
