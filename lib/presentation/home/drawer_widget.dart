import 'package:beta/configs/colors.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/presentation/notifications/notifications_screen.dart';
import 'package:beta/presentation/settings/settings_screen.dart';
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
        _NotificationsTile(),
        _SettingsTile(),
        _CouponsTile(),
        _ImportBackupTile(),
        _ExportBackupTile(),
        _ScanPrintedQRTile()
      ]),
    );
  }
}

class _NotificationsTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.notifications_sharp, color: primaryColorDark),
      title: Text(StringConstant.notifications.tr()),
      onTap: () => Navigator.pushNamed(context, NotificationsScreen.route),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.settings, color: primaryColorDark),
      title: Text(StringConstant.settings.tr()),
      onTap: () => Navigator.pushNamed(context, SettingsScreen.route),
    );
  }
}

class _CouponsTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.credit_card, color: primaryColorDark),
      title: Text(StringConstant.coupons.tr()),
      onTap: () => Navigator.pushNamed(context, SettingsScreen.route),
    );
  }
}

class _ImportBackupTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:
          const Icon(Icons.settings_backup_restore, color: primaryColorDark),
      title: Text(StringConstant.importBackup.tr()),
      onTap: () {},
    );
  }
}

class _ExportBackupTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.sd_storage, color: primaryColorDark),
      title: Text(StringConstant.exportBackup.tr()),
      onTap: () {},
    );
  }
}

class _ScanPrintedQRTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.qr_code_scanner, color: primaryColorDark),
      title: Text(StringConstant.scanPrintedQr.tr()),
      onTap: () {},
    );
  }
}
