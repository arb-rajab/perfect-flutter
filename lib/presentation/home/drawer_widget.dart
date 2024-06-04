import 'dart:convert';
import 'dart:io';

import 'package:beta/application/services/answer_property_service.dart';
import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/question_property_service.dart';
import 'package:beta/application/services/question_tag_property_service.dart';
import 'package:beta/application/services/term_last_access_service.dart';
import 'package:beta/application/services/term_property_service.dart';
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
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:get/instance_manager.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        const NoBackgroundLogo(),
        _CouponsTile(),
        _ImportBackupTile(),
        _ExportBackupTile(),
        _ScanPrintedQRTile(),
        const Divider(),
        const ContactUsTile(),
        const FrequestQuestionsTile(),
        const Divider(),
        const WhatsNewTile()
      ]),
    );
  }
}

class _CouponsTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OpacityAnimation(
      child: ListTile(
        leading: const Icon(CouponsScreen.icon),
        title: Hero(tag: CouponsScreen.title, child: Text(CouponsScreen.title)),
        onTap: () => Navigator.pushNamed(context, CouponsScreen.route),
      ),
    );
  }
}

class _ImportBackupTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OpacityAnimation(
      child: ListTile(
        leading: const Icon(
          Icons.settings_backup_restore, /*color: primaryColorDark*/
        ),
        title: Text(StringConstant.importBackup.tr()),
        onTap: () async {
          final result =
              await FilePicker.platform.pickFiles(allowMultiple: false);
          // if no file is picked
          if (result == null) return;
          // String content =
          //     (await OpenFile.open(result.files.first.path)).message;
          File file = File(result.files.first.path!);
          String content = await file.readAsString();
          AnswerPropertyService answerPropertyService = Get.find();
          QuestionPropertyService questionPropertyService = Get.find();
          QuestionTagPropertyService questionTagPropertyService = Get.find();
          TermLastAccessService termLastAccessService = Get.find();
          TermPropertyService termPropertyService = Get.find();

          dynamic data = jsonDecode(content);

          if (data['answerProperties'] != null) {
            await answerPropertyService
                .addAnswerPropertiesFromJson(data['answerProperties']);
          }
          if (data['questionProperties'] != null) {
            await questionPropertyService
                .addQuestionPropertiesFromJson(data['questionProperties']);
          }
          if (data['questionTagProperties'] != null) {
            await questionTagPropertyService.addQuestionTagPropertiesFromJson(
                data['questionTagProperties']);
          }
          if (data['termsLastAccess'] != null) {
            await termLastAccessService
                .addTermLastAccessFromJson(data['termsLastAccess']);
          }
          if (data['termProperties'] != null) {
            await termPropertyService
                .addTermPropertiesFromJson(data['termProperties']);
          }
          if (context.mounted) showSuccessDialogue(context);
        },
      ),
    );
  }
}

Future<String?> getDownloadPath() async {
  Directory? directory;
  try {
    if (Platform.isIOS) {
      directory = await getApplicationDocumentsDirectory();
    } else {
      // On Android, use the global download folder
      directory = Directory('/storage/emulated/0/Download');
      // If it doesn't exist, fallback to external storage directory
      if (!await directory.exists()) {
        directory = await getExternalStorageDirectory();
      }
    }
  } catch (err, stack) {
    print("Cannot get download folder path");
  }
  return directory?.path;
}

class _ExportBackupTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OpacityAnimation(
      child: ListTile(
        leading: const Icon(
          Icons.sd_storage, /*color: primaryColorDark*/
        ),
        title: Text(StringConstant.exportBackup.tr()),
        onTap: () async {
          AnswerPropertyService answerPropertyService = Get.find();
          QuestionPropertyService questionPropertyService = Get.find();
          QuestionTagPropertyService questionTagPropertyService = Get.find();
          TermLastAccessService termLastAccessService = Get.find();
          TermPropertyService termPropertyService = Get.find();

          Map<String, dynamic> data = {};

          List<AnswerProperty> answerProperties =
              await answerPropertyService.getAllAnswerProperties();
          List<QuestionTagProperty> questionTagProperties =
              await questionTagPropertyService.getAllQuestionTagProperties();
          List<QuestionProperty> questionProperties =
              await questionPropertyService.getAllQuestionProperties();
          List<TermsLastAccess> termsLastAccesses =
              await termLastAccessService.getAllTermLastAccesses();
          List<TermProperty> termProperties =
              await termPropertyService.getAllTermProperties();

          data['answerProperties'] = answerProperties;
          data['questionProperties'] = questionProperties;
          data['questionTagProperties'] = questionTagProperties;
          data['termsLastAccess'] = termsLastAccesses;
          data['termProperties'] = termProperties;

          File file = File(
              '${(await getApplicationCacheDirectory()).path}${separator}temp');
          await file.writeAsString(jsonEncode(data));
          String? outputFile = await FlutterFileDialog.saveFile(
              params: SaveFileDialogParams(
                  sourceFilePath: file.path, fileName: 'database backup'));
          if (outputFile == null) return;
          if (context.mounted) showSuccessDialogue(context);
        },
      ),
    );
  }
}

class _ScanPrintedQRTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OpacityAnimation(
      child: ListTile(
          leading: const Icon(PrintedQrScannerScreen.icon),
          title: Hero(
              tag: PrintedQrScannerScreen.title,
              child: Text(PrintedQrScannerScreen.title)),
          onTap: () =>
              Navigator.pushNamed(context, PrintedQrScannerScreen.route)),
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
              tag: ContactUsScreen.title, child: Text(ContactUsScreen.title)),
          onTap: () => Navigator.pushNamed(context, ContactUsScreen.route)),
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
              child: Text(FrequentQuestionsScreen.title)),
          onTap: () =>
              Navigator.pushNamed(context, FrequentQuestionsScreen.route)),
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
              context: context, builder: (_) => const WhatsNewDialogue())),
    );
  }
}

class WhatsNewDialogue extends StatelessWidget {
  const WhatsNewDialogue({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(StringConstant.whatsNewInVersion.tr().replaceFirst(
          '(VERSION)', Get.find<PackageRepository>().getVersionName())),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('* ${StringConstant.addContactUsScreen.tr()}'),
            Text('* ${StringConstant.addFrequentQuestionsScreen.tr()}'),
            Text('* ${StringConstant.supportNightMode.tr()}'),
            Text('* ${StringConstant.supportCustomTextSize.tr()}'),
            Text('* ${StringConstant.supportUserDataDeletion.tr()}'),
            Text('* ${StringConstant.addStudiedTermsFeature.tr()}')
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: Navigator.of(context).pop,
            child: Text(StringConstant.ok.tr()))
      ],
    );
  }
}
