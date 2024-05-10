import 'package:beta/application/services/database_service.dart';

class VoiceNoteData {
  VoiceNote voiceNote;
  Uri? url;
  VoiceNoteData(this.voiceNote, {this.url});

  static VoiceNoteData fromJson(Map<String, dynamic> json) {
    VoiceNoteData termData = VoiceNoteData(VoiceNote.fromJson(json));
    termData.url = Uri.parse(json['url']);
    return termData;
  }

  Map toJson() => {...voiceNote.toJson(), 'url': url!.toString()};

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VoiceNoteData && other.voiceNote == voiceNote);

  @override
  int get hashCode => Object.hash(voiceNote, url);
}
