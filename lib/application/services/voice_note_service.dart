import 'package:beta/application/services/database_service.dart';
import 'package:beta/domain/voice_note_data.dart';

class VoiceNoteService {
  final DatabaseService databaseService;

  VoiceNoteService({required this.databaseService});

  Future addVoiceNote(VoiceNoteData voiceNoteData) => databaseService
      .into(databaseService.voiceNotes)
      .insert(voiceNoteData.voiceNote);
}
