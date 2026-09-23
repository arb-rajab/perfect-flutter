import 'dart:convert';
import 'dart:io';

import 'package:beta/application/services/answer_property_service.dart';
import 'package:beta/application/services/database/shared.dart';
import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/question_property_service.dart';
import 'package:beta/application/services/question_tag_property_service.dart';
import 'package:beta/application/services/term_last_access_service.dart';
import 'package:beta/application/services/term_property_service.dart';
import 'package:beta/configs/app.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/infrastructure/package_repository.dart';
import 'package:beta/presentation/animations/opacity_animation.dart';
import 'package:beta/presentation/contact_us/contact_us_screen.dart';
import 'package:beta/presentation/coupons/coupons_screen.dart';
import 'package:beta/presentation/dialogues/success_dialogue.dart';
import 'package:beta/presentation/frequent_questions/frequent_questions_screen.dart';
import 'package:beta/presentation/printed_qr_scanner/printed_qr_scanner_screen.dart';
import 'package:beta/presentation/widgets/no_background_logo.dart';
import 'package:easy_localization/easy_localization.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sqlite3/sqlite3.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: const [
          NoBackgroundLogo(),
          CouponsTile(),
          ImportBackupTile(),
          ExportBackupTile(),
          // _ScanPrintedQRTile(),
          Divider(),
          ContactUsTile(),
          FrequestQuestionsTile(),
          Divider(),
          WhatsNewTile(),
          // DecryptDatabase(),
        ],
      ),
    );
  }
}

class DecryptDatabase extends StatefulWidget {
  const DecryptDatabase({super.key});

  @override
  State<DecryptDatabase> createState() => _DecryptDatabaseState();
}

class _DecryptDatabaseState extends State<DecryptDatabase> {
  final TextEditingController _modelController = TextEditingController();

  @override
  void dispose() {
    _modelController.dispose();
    super.dispose();
  }

  Future<void> pickAndDecrypt() async {
    final model = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enter device model'),
        content: TextField(
          controller: _modelController,
          decoration: const InputDecoration(hintText: 'e.g. Redmi Note 8'),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () =>
                Navigator.pop(context, _modelController.text.trim()),
            child: const Text('Decrypt'),
          ),
        ],
      ),
    );

    if (model == null || model.isEmpty) return;

    const typeGroup = XTypeGroup(label: 'database', extensions: ['db']);
    final file = await openFile(acceptedTypeGroups: [typeGroup]);
    if (file == null) return;

    await decryptAndExportDatabase(file.path, model);
  }

  Future<void> decryptAndExportDatabase(
    String encryptedDbPath,
    String model,
  ) async {
    final tempDir = await getTemporaryDirectory();
    final jsonPath = p.join(
      tempDir.path,
      'database_backup_${DateTime.now().millisecondsSinceEpoch}.json',
    );

    final key = '${model}edu.perfect';
    final encrypted = sqlite3.open(encryptedDbPath);

    try {
      encrypted.execute("pragma cipher = 'sqlcipher'");
      encrypted.execute('pragma legacy = 4');
      encrypted.execute("PRAGMA key = '$key';");

      encrypted.select('SELECT count(*) FROM sqlite_master');

      List<Map<String, dynamic>> readTable(String tableName) {
        final rows = encrypted.select('SELECT * FROM "$tableName"');
        return rows.map((row) => Map<String, dynamic>.from(row)).toList();
      }

      final data = {
        'answerProperties': readTable('answerProperties'),
        'questionProperties': readTable('questionProperties'),
        'questionTagProperties': readTable('questionTagProperties'),
        'termsLastAccess': readTable('termsLastAccess'),
        'termProperties': readTable('termProperties'),
      };

      final jsonBytes = Uint8List.fromList(utf8.encode(jsonEncode(data)));
      await File(jsonPath).writeAsBytes(jsonBytes, flush: true);

      await SharePlus.instance.share(ShareParams(files:[
        XFile(jsonPath, mimeType: 'application/json'),
      ], subject: 'Database backup'));

      if (File(jsonPath).existsSync()) {
        await File(jsonPath).delete();
      }
    } finally {
      encrypted.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: pickAndDecrypt, child: const Text('decrypt'));
  }
}

class CouponsTile extends StatelessWidget {
  const CouponsTile({super.key});

  @override
  Widget build(BuildContext context) {
    return OpacityAnimation(
      child: ListTile(
        leading: const Icon(CouponsScreen.icon),
        title: Hero(tag: CouponsScreen.title, child: Text(CouponsScreen.title)),
        onTap: () => context.push(CouponsScreen.route),
      ),
    );
  }
}

class ImportBackupTile extends StatelessWidget {
  const ImportBackupTile({super.key});

  @override
  Widget build(BuildContext context) {
    return OpacityAnimation(
      child: ListTile(
        leading: const Icon(Icons.settings_backup_restore),
        title: Text(StringConstant.importBackup.tr()),
        onTap: () async {
          // FilePickerResult? result = await FilePicker.platform
          //     .pickFiles(allowMultiple: false, withData: true);
          //               const XTypeGroup typeGroup = XTypeGroup(
          //   label: 'images',
          //   extensions: <String>['jpg', 'png'],
          // );
          final XFile? result = await openFile(
            /*acceptedTypeGroups: <XTypeGroup>[typeGroup]*/
          );
          // if no file is picked
          if (result == null) return;
          Uint8List? fileBytes = await result.readAsBytes();
          // if (fileBytes == null) return;
          String content = utf8.decode(fileBytes);
          AnswerPropertyService answerPropertyService = Get.find();
          QuestionPropertyService questionPropertyService = Get.find();
          QuestionTagPropertyService questionTagPropertyService = Get.find();
          TermLastAccessService termLastAccessService = Get.find();
          TermPropertyService termPropertyService = Get.find();

          dynamic data = jsonDecode(content);
          int finished = 0;
          final propertyKeys = [
            'answerProperties',
            'questionProperties',
            'questionTagProperties',
            'termsLastAccess',
            'termProperties',
          ];
          int totalLength = propertyKeys.fold(
            0,
            (sum, key) => sum + ((data[key] as List?)?.length ?? 0),
          );

          final importSteps = [
            {
              'key': 'answerProperties',
              'method': answerPropertyService.addAnswerPropertiesFromJson,
            },
            {
              'key': 'questionProperties',
              'method': questionPropertyService.addQuestionPropertiesFromJson,
            },
            {
              'key': 'questionTagProperties',
              'method':
                  questionTagPropertyService.addQuestionTagPropertiesFromJson,
            },
            {
              'key': 'termsLastAccess',
              'method': termLastAccessService.addTermLastAccessFromJson,
            },
            {
              'key': 'termProperties',
              'method': termPropertyService.addTermPropertiesFromJson,
            },
          ];

          for (final step in importSteps) {
            final key = step['key'] as String;
            final method = step['method'] as Future Function(dynamic data);

            if (data[key] != null) {
              await method(data[key]);
              finished += (data[key] as List).length;

              if (context.mounted) {
                final percent = (finished * 100 / totalLength).toString();
                context.showInfoBar(
                  content: Text(
                    StringConstant.restored.tr().replaceFirst(
                      '(PERCENT)',
                      percent,
                    ),
                  ),
                );
              }
            }
          }
          if (context.mounted) showSuccessDialogue(context);
        },
      ),
    );
  }
}

class ExportBackupTile extends StatelessWidget {
  const ExportBackupTile({super.key});

  @override
  Widget build(BuildContext context) {
    return OpacityAnimation(
      child: ListTile(
        leading: const Icon(Icons.sd_storage /*color: primaryColorDark*/),
        title: Text(StringConstant.exportBackup.tr()),
        onTap: () async {
          try {
            AnswerPropertyService answerPropertyService = Get.find();
            QuestionPropertyService questionPropertyService = Get.find();
            QuestionTagPropertyService questionTagPropertyService = Get.find();
            TermLastAccessService termLastAccessService = Get.find();
            TermPropertyService termPropertyService = Get.find();

            Map<String, dynamic> data = {};

            List<AnswerProperty> answerProperties = await answerPropertyService
                .getAllAnswerProperties();
            List<QuestionTagProperty> questionTagProperties =
                await questionTagPropertyService.getAllQuestionTagProperties();
            List<QuestionProperty> questionProperties =
                await questionPropertyService.getAllQuestionProperties();
            List<TermsLastAccess> termsLastAccesses =
                await termLastAccessService.getAllTermLastAccesses();
            List<TermProperty> termProperties = await termPropertyService
                .getAllTermProperties();

            data['answerProperties'] = answerProperties;
            data['questionProperties'] = questionProperties;
            data['questionTagProperties'] = questionTagProperties;
            data['termsLastAccess'] = termsLastAccesses;
            data['termProperties'] = termProperties;

            Uint8List contentBytes = Uint8List.fromList(
              utf8.encode(jsonEncode(data)),
            );
            String fileName = 'database backup';
            Future saver;
            if (kIsWeb) {
              // Use FileSaver to save the file
              saver = FileSaver.instance.saveFile(
                name: fileName, // Name of the file
                bytes: contentBytes, // File content in bytes
                mimeType: MimeType.text, // MIME type
              );
            } else {
              saver = FileSaver.instance.saveAs(
                name: fileName, // Name of the file
                bytes: contentBytes, // File content in bytes
                mimeType: MimeType.text, // MIME type
                fileExtension: '.txt',
              );
            }
            saver.then((value) {
              if (context.mounted) showSuccessDialogue(context);
            });
          } catch (e) {
            await exportDatabaseFile();
            return;
          }
        },
      ),
    );
  }
}

// ignore: unused_element
class _ScanPrintedQRTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OpacityAnimation(
      child: ListTile(
        leading: const Icon(PrintedQrScannerScreen.icon),
        title: Hero(
          tag: PrintedQrScannerScreen.title,
          child: Text(PrintedQrScannerScreen.title),
        ),
        onTap: () => context.push(PrintedQrScannerScreen.route),
      ),
    );
  }
}

class ContactUsTile extends StatelessWidget {
  const ContactUsTile({super.key});

  @override
  Widget build(BuildContext context) {
    return OpacityAnimation(
      child: ListTile(
        leading: const Icon(ContactUsScreen.icon),
        title: Hero(
          tag: ContactUsScreen.title,
          child: Text(ContactUsScreen.title),
        ),
        onTap: () => context.push(ContactUsScreen.route),
      ),
    );
  }
}

class FrequestQuestionsTile extends StatelessWidget {
  const FrequestQuestionsTile({super.key});

  @override
  Widget build(BuildContext context) {
    return OpacityAnimation(
      child: ListTile(
        leading: const Icon(FrequentQuestionsScreen.icon),
        title: Hero(
          tag: FrequentQuestionsScreen.title,
          child: Text(FrequentQuestionsScreen.title),
        ),
        onTap: () => context.push(FrequentQuestionsScreen.route),
      ),
    );
  }
}

class WhatsNewTile extends StatelessWidget {
  const WhatsNewTile({super.key});

  @override
  Widget build(BuildContext context) {
    return OpacityAnimation(
      child: ListTile(
        leading: const Icon(Icons.refresh),
        title: Text(StringConstant.whatsNew.tr()),
        onTap: () => showDialog(
          context: context,
          builder: (_) => const WhatsNewDialogue(),
        ),
      ),
    );
  }
}

class WhatsNewDialogue extends StatelessWidget {
  const WhatsNewDialogue({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        StringConstant.whatsNewInVersion.tr().replaceFirst(
          '(VERSION)',
          Get.find<PackageRepository>().getVersionName(),
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [...newFeatures.map((feature) => Text('* $feature'))],
        ),
      ),
      actions: [
        TextButton(onPressed: context.pop, child: Text(StringConstant.ok.tr())),
      ],
    );
  }
}

class FileSaverMock extends Mock implements FileSaver {}
