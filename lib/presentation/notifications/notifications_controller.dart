import 'package:beta/constants/api_constant.dart';
import 'package:beta/domain/notification.dart';
import 'package:beta/presentation/notifications/notification_widget.dart';
import 'package:beta/presentation/widgets/list_controller.dart';

class NotificationsListController extends ListController<Notification> {
  NotificationsListController(state)
      : super(
            state: state,
            itemBuilder: (context, index) => NotificationWidget(index: index),
            plural: 'notifications',
            indexUrl: ApiConstant.notifications);
}
