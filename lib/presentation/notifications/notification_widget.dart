import 'package:beta/configs/style.dart';
import 'package:beta/domain/notification.dart' as n;
import 'package:beta/infrastructure/url_launcher_repository.dart';
import 'package:beta/presentation/notifications/notifications_controller.dart';
import 'package:beta/presentation/widgets/widget_wrapper_with_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';

class NotificationWidget extends StatelessWidget {
  final int index;
  const NotificationWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    NotificationsListController notificationsListController = Get.find();
    n.Notification notification =
        notificationsListController.items[index];
    return Container(
      color: notification.seen == true
          ? Theme.of(context).primaryColor
          : Theme.of(context) //TODO check color
              .scaffoldBackgroundColor, //backgroundColorLight : primaryColorLight,
      margin: const EdgeInsets.all(halfMargin),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: margin),
            margin: const EdgeInsets.only(bottom: margin),
            child: Text(DateFormat('yyyy/MM/dd').format(notification.creation),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium!
                // .copyWith(color: primaryColor),
                ),
          ),
          WidgetWrapperWithBorder(
            child: ListTile(
                leading: const Icon(
                  Icons.notifications, /*color: primaryColor*/
                ),
                trailing: const Icon(
                  Icons.navigate_next, /*color: primaryColor*/
                ),
                title: Text(notification.title.value!),
                subtitle: SelectableLinkify(
                      onOpen: (link) =>
                          Get.find<UrlLauncherRepository>().openUrl(link.url),
                      text: notification.text.value!))
          ),
        ],
      ),
    );
  }
}
