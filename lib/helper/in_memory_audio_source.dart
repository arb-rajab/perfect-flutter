import 'dart:typed_data';

import 'package:just_audio/just_audio.dart';

class InMemoryAudioSource extends StreamAudioSource {
  final Uint8List audioData;

  InMemoryAudioSource(this.audioData);

  @override
  Future<StreamAudioResponse> request([int? start, int? end]) async {
    start ??= 0;
    end ??= audioData.length;
    return StreamAudioResponse(
      sourceLength: audioData.length,
      contentLength: end - start,
      offset: start,
      contentType: 'audio/mpeg',
      stream: Stream.fromIterable(
        [audioData.sublist(start, end)],
      ),
    );
  }
}
