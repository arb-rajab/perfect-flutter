import 'package:beta/application/services/database_service.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/domain/voice_note_data.dart';

class VoiceNoteService {
  final DatabaseService databaseService;

  VoiceNoteService({required this.databaseService});

  Future addVoiceNote(VoiceNoteData voiceNoteData) => databaseService
      .into(databaseService.voiceNotes)
      .insertOnConflictUpdate(voiceNoteData.voiceNote);

  Future<VoiceNote> getVoiceNote(TermData termData) => (databaseService
          .select(databaseService.voiceNotes)
        ..where((voiceNote) => voiceNote.parentTermId.equals(termData.term.id)))
      .getSingle();
}
