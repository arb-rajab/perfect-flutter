import 'dart:convert';
import 'dart:typed_data';

import 'package:beta/application/services/answer_property_service.dart';
import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/path/shared.dart';
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
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:go_router/go_router.dart';

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
        onTap: () => context.push(CouponsScreen.route),
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
              await FilePicker.platform
              .pickFiles(allowMultiple: false, withData: true);
          // if no file is picked
          if (result == null) return;
          Uint8List? fileBytes = result.files.first.bytes;
          if (fileBytes == null) return;
          String content = String.fromCharCodes(fileBytes);
          AnswerPropertyService answerPropertyService = Get.find();
          QuestionPropertyService questionPropertyService = Get.find();
          QuestionTagPropertyService questionTagPropertyService = Get.find();
          TermLastAccessService termLastAccessService = Get.find();
          TermPropertyService termPropertyService = Get.find();

          dynamic data = jsonDecode(content);
          int totalLength = 0;
          int finished = 0;
          if (data['answerProperties'] != null) {
            totalLength += (data['answerProperties'] as List).length;
          }
          if (data['questionProperties'] != null) {
            totalLength += (data['questionProperties'] as List).length;
          }
          if (data['questionTagProperties'] != null) {
            totalLength += (data['questionTagProperties'] as List).length;
          }
          if (data['termsLastAccess'] != null) {
            totalLength += (data['termsLastAccess'] as List).length;
          }
          if (data['termProperties'] != null) {
            totalLength += (data['termProperties'] as List).length;
          }

          if (data['answerProperties'] != null) {
            await answerPropertyService
                .addAnswerPropertiesFromJson(data['answerProperties']);
            finished += (data['answerProperties'] as List).length;
          }

          if (context.mounted) {
            context.showInfoBar(
                content: Text(StringConstant.restored.tr().replaceFirst(
                    '(PERCENT)', ((finished * 100) / totalLength).toString())));
          }

          if (data['questionProperties'] != null) {
            await questionPropertyService
                .addQuestionPropertiesFromJson(data['questionProperties']);
            finished += (data['questionProperties'] as List).length;
          }

          if (context.mounted) {
            context.showInfoBar(
                content: Text(StringConstant.restored.tr().replaceFirst(
                    '(PERCENT)', ((finished * 100) / totalLength).toString())));
          }

          if (data['questionTagProperties'] != null) {
            await questionTagPropertyService.addQuestionTagPropertiesFromJson(
                data['questionTagProperties']);
            finished += (data['questionTagProperties'] as List).length;
          }

          if (context.mounted) {
            context.showInfoBar(
                content: Text(StringConstant.restored.tr().replaceFirst(
                    '(PERCENT)', ((finished * 100) / totalLength).toString())));
          }

          if (data['termsLastAccess'] != null) {
            await termLastAccessService
                .addTermLastAccessFromJson(data['termsLastAccess']);
            finished += (data['termsLastAccess'] as List).length;
          }

          if (context.mounted) {
            context.showInfoBar(
                content: Text(StringConstant.restored.tr().replaceFirst(
                    '(PERCENT)', ((finished * 100) / totalLength).toString())));
          }

          if (data['termProperties'] != null) {
            await termPropertyService
                .addTermPropertiesFromJson(data['termProperties']);
            finished += (data['termProperties'] as List).length;
          }
          if (context.mounted) showSuccessDialogue(context);
        },
      ),
    );
  }
}

// Future<String?> getDownloadPath() async {
//   Directory? directory;
//   try {
//     if (Platform.isIOS) {
//       directory = await getApplicationDocumentsDirectory();
//     } else {
//       // On Android, use the global download folder
//       directory = Directory('/storage/emulated/0/Download');
//       // If it doesn't exist, fallback to external storage directory
//       if (!await directory.exists()) {
//         directory = await getExternalStorageDirectory();
//       }
//     }
//   } catch (err, stack) {
//     print("Cannot get download folder path");
//   }
//   return directory?.path;
// }

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

          PathService pathService = Get.find();
          bool saved = await pathService.saveFile(
              fileName: 'database backup', content: jsonEncode(data));
          if (!saved) return;
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
          onTap: () => context.push(PrintedQrScannerScreen.route)),
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
          onTap: () => context.push(ContactUsScreen.route)),
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
          onTap: () => context.push(FrequentQuestionsScreen.route)),
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
        TextButton(onPressed: context.pop, child: Text(StringConstant.ok.tr()))
      ],
    );
  }
}
