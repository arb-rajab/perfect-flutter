import 'package:beta/constants/string_constant.dart';
import 'package:beta/presentation/coupons/coupons_screen.dart';
import 'package:beta/presentation/printed_qr_scanner/printed_qr_scanner_screen.dart';
import 'package:beta/presentation/widgets/no_background_logo.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

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
        _ScanPrintedQRTile()
      ]),
    );
  }
}

class _CouponsTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        CouponsScreen.icon
      ),
      title: Text(CouponsScreen.title),
      onTap: () => Navigator.pushNamed(context, CouponsScreen.route),
    );
  }
}

class _ImportBackupTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:
          const Icon(
        Icons.settings_backup_restore, /*color: primaryColorDark*/
      ),
      title: Text(StringConstant.importBackup.tr()),
      onTap: () {},
    );
  }
}

class _ExportBackupTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.sd_storage, /*color: primaryColorDark*/
      ),
      title: Text(StringConstant.exportBackup.tr()),
      onTap: () {},
    );
  }
}

class _ScanPrintedQRTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        PrintedQrScannerScreen.icon
      ),
        title: Text(PrintedQrScannerScreen.title),
        onTap: () =>
            Navigator.pushNamed(context, PrintedQrScannerScreen.route)
    );
  }
}
