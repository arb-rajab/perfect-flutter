import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/downlaod_item.dart';
import 'package:beta/main_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class DownloadService {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final List<DownloadItem> downloads = [];
  final int _notificationId = 0;
  final String downloadsChannel = 'downloads_channel';

  DownloadService() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();
    const LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin,
            linux: initializationSettingsLinux);

    if (!MainController.testing) {
      flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
      );
    }
  }

  Future<void> startDownloads(DownloadItem downloadItem) async {
    if (downloads
        .where((item) =>
            item.type == downloadItem.type &&
            item.id.value! == downloadItem.id.value!)
        .isNotEmpty) {
      return;
    }

    downloads.add(downloadItem);

    _showNotification();

    for (var download in downloads) {
      if (!download.started && !download.completed) {
        _downloadFile(download);
      }
    }
    _updateNotification();
  }

  Future _downloadFile(DownloadItem item) async {
    item.started = true;
    await item.onDownload.call();
    item.completed = true;
    // await item.onDownloadFinished.call();
    _updateNotification();
  }

  void _showNotification() {
    final notificationDetails = NotificationDetails(android: _androidDetails());

    if (!MainController.testing) {
      flutterLocalNotificationsPlugin.show(
        _notificationId,
        StringConstant.downloadingTerms.tr(),
        null,
        notificationDetails,
      );
    }
  }

  AndroidNotificationDetails _androidDetails() => AndroidNotificationDetails(
        downloadsChannel,
        StringConstant.downloads.tr(),
        channelDescription: StringConstant.showsTermsDownloadProgress.tr(),
        importance: Importance.low,
        priority: Priority.low,
        onlyAlertOnce: true,
        showProgress: true,
        maxProgress: downloads.length,
        progress: _calculateTotalProgress(),
        ongoing: true,
      );

  void _updateNotification() {
    if (downloads.where((download) => download.completed).length ==
        downloads.length) {
      _showCompletionNotification();
      downloads.clear();
      return;
    }

    final notificationDetails = NotificationDetails(android: _androidDetails());
    if (!MainController.testing) {
      flutterLocalNotificationsPlugin.show(
        _notificationId,
        StringConstant.downloadingTerms.tr(),
        '',
        notificationDetails,
      );
    }
  }

  int _calculateTotalProgress() {
    if (downloads.isEmpty) return 0;
    final totalProgress = downloads.where((d) => d.completed).length;
    return totalProgress;
  }

  void _showCompletionNotification() {
    final androidDetails = AndroidNotificationDetails(
      downloadsChannel,
      StringConstant.downloads.tr(),
      channelDescription: StringConstant.downloadComplete.tr(),
      importance: Importance.high,
      priority: Priority.high,
    );

    final notificationDetails = NotificationDetails(android: androidDetails);

    if (!MainController.testing) {
      flutterLocalNotificationsPlugin.show(
        _notificationId,
        StringConstant.downloadComplete.tr(),
        null,
        notificationDetails,
      );
    }
  }
}
