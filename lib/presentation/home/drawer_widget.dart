import 'package:beta/constants/string_constant.dart';
import 'package:beta/presentation/animations/opacity_animation.dart';
import 'package:beta/presentation/contact_us/contact_us_screen.dart';
import 'package:beta/presentation/coupons/coupons_screen.dart';
import 'package:beta/presentation/frequent_questions/frequent_questions_screen.dart';
import 'package:beta/presentation/printed_qr_scanner/printed_qr_scanner_screen.dart';
import 'package:beta/presentation/widgets/no_background_logo.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

//TODO add what's new
//TODO add share app
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
        _ContactUsTile(),
        _FrequestQuestionsTile()
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
              Navigator.pushNamed(context, PrintedQrScannerScreen.route)
      ),
    );
  }
}

//TODO apply test
class _ContactUsTile extends StatelessWidget {
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

//TODO apply test
class _FrequestQuestionsTile extends StatelessWidget {
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
