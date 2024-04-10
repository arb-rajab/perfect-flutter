import 'package:beta/presentation/home/drawer_widget.dart';
import 'package:beta/presentation/notifications/notifications_screen.dart';
import 'package:beta/presentation/settings/settings_screen.dart';
import 'package:beta/presentation/widgets/screen_wrapper.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static String route = '/home';

  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      actions: [
        IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, NotificationsScreen.route),
            icon: const Icon(NotificationsScreen.icon)),
        IconButton(
          icon: const Icon(SettingsScreen.icon),
          onPressed: () => Navigator.pushNamed(context, SettingsScreen.route),
        )
      ],
      drawer: const DrawerWidget(),
      child: const Center(),
    );
  }
}
