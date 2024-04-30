import 'package:beta/constants/string_constant.dart';
import 'package:beta/infrastructure/package_repository.dart';
import 'package:beta/presentation/animations/opacity_animation.dart';
import 'package:beta/presentation/contact_us/contact_us_screen.dart';
import 'package:beta/presentation/coupons/coupons_screen.dart';
import 'package:beta/presentation/frequent_questions/frequent_questions_screen.dart';
import 'package:beta/presentation/printed_qr_scanner/printed_qr_scanner_screen.dart';
import 'package:beta/presentation/widgets/no_background_logo.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

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
        onTap: () {},
      ),
    );
  }
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
        onTap: () {},
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
            Text('* ${StringConstant.supportUserDataDeletion.tr()}')
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
