import 'package:beta/application/services/database_service.dart';
import 'package:beta/constants/arguments.dart';
import 'package:beta/domain/term_data.dart';
import 'package:get/instance_manager.dart';

import '../../common/tests.dart';

Future initData() async {
  await databaseService.into(databaseService.voiceNotes).insert(const VoiceNote(
      encryptionKey: '',
      parentTermId: 1,
      creation: '2024-01-01 11:12:13',
      lastUpdated: '2024-01-01 11:12:13'));
  Get.put(VoiceNoteScreenArgument(
      term: TermData(const Term(
          id: 1,
          uuid: 'uuid',
          name: 'name',
          type: TermType.voiceNotes,
          creation: '2024-01-08 13:15:17',
          enabled: 1,
          free: 1,
          ordering: 1,
          needsUpdate: 0,
          captureable: 1,
          textCulumn: 'textCulumn',
          outerNote: 'outerNote'))));
}
