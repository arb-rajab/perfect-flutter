import 'package:beta/configs/style.dart';
import 'package:beta/domain/notification.dart' as n;
import 'package:beta/presentation/notifications/notifications_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationWidget extends StatelessWidget {
  final int index;
  const NotificationWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    NotificationsListController notificationsListController = Get.find();
    n.Notification notification =
        n.Notification.fromJson(notificationsListController.items[index]);
    return Container(
      color:
          notification.seen == true
          ? Theme.of(context).primaryColor
          : Theme.of(context) //TODO check color
              .scaffoldBackgroundColor, //backgroundColorLight : primaryColorLight,
      margin: const EdgeInsets.all(halfMargin),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: margin),
            margin: const EdgeInsets.only(bottom: margin),
            child: Text(
              DateFormat('yyyy/MM/dd').format(notification.creation),
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                // .copyWith(color: primaryColor),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(halfMargin),
            decoration: const BoxDecoration(
                // border: Border.all(color: primaryColor),
                borderRadius:
                     BorderRadius.all(Radius.circular(halfMargin))),
            child: ListTile(
                leading: const Icon(
                  Icons.notifications, /*color: primaryColor*/
                ),
                trailing: const Icon(
                  Icons.navigate_next, /*color: primaryColor*/
                ),
                title: Text(notification.title.value!
                ),
                subtitle: SelectableLinkify(
                    onOpen: (link) async {
                      if (!await launchUrl(Uri.parse(link.url))) {
                        throw Exception('Could not launch ${link.url}');
                      }
                    },
                    text: notification.text.value!)),
          ),
        ],
      ),
    );
  }
}
