import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/voice_note_service.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/domain/voice_note_data.dart';
import 'package:get/instance_manager.dart';
import 'package:test/test.dart';

import '../../common/tests.dart';

void main() {
  late VoiceNoteService voiceNoteService;
  setUp(() async {
    await initTests();
    voiceNoteService = Get.find();
  });

  VoiceNoteData createTestVoiceNoteData({
    int parentTermId = 1,
    String encryptionKey = 'key',
    String creation = '2023-01-01T00:00:00Z',
    String lastUpdated = '2023-01-01T00:00:00Z',
  }) {
    final voiceNote = VoiceNote(
      encryptionKey: encryptionKey,
      parentTermId: parentTermId,
      creation: creation,
      lastUpdated: lastUpdated,
    );
    return VoiceNoteData(voiceNote);
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

  test('addVoiceNote inserts voiceNote with conflict resolution', () async {
    final voiceNoteData = createTestVoiceNoteData(parentTermId: 1);

    await voiceNoteService.addVoiceNote(voiceNoteData);

    final storedVoiceNotes =
        await databaseService.select(databaseService.voiceNotes).get();
    expect(storedVoiceNotes.length, 1);
    expect(storedVoiceNotes.first.parentTermId, 1);
    expect(storedVoiceNotes.first.encryptionKey, 'key');
  });

  test('addVoiceNote updates existing voiceNote on conflict', () async {
    final initialVoiceNote =
        createTestVoiceNoteData(parentTermId: 1, encryptionKey: 'key1');
    await databaseService
        .into(databaseService.voiceNotes)
        .insert(initialVoiceNote.voiceNote);

    final updatedVoiceNote =
        createTestVoiceNoteData(parentTermId: 1, encryptionKey: 'key2');
    await voiceNoteService.addVoiceNote(updatedVoiceNote);

    final storedVoiceNotes =
        await databaseService.select(databaseService.voiceNotes).get();
    expect(storedVoiceNotes.length, 1);
    expect(storedVoiceNotes.first.encryptionKey, 'key2');
  });

  test('getVoiceNote returns the correct voiceNote for a term', () async {
    final termData = createTestTermData(id: 2);
    final voiceNoteData = createTestVoiceNoteData(parentTermId: 2);

    await voiceNoteService.addVoiceNote(voiceNoteData);

    final voiceNote = await voiceNoteService.getVoiceNote(termData);
    expect(voiceNote.parentTermId, 2);
    expect(voiceNote.encryptionKey, 'key');
  });
}
