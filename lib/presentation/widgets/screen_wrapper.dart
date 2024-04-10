import 'package:flutter/material.dart';

class ScreenWrapper extends StatelessWidget {
  final Widget child;
  final String? title;
  final IconData? icon;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final List<Widget>? actions;

  const ScreenWrapper(
      {super.key,
      required this.child,
      this.title,
      this.bottomNavigationBar,
      this.icon,
      this.actions,
      this.drawer});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      drawer: drawer,
      appBar: title != null || drawer != null || actions != null
          ? AppBar(
              actions: actions,
              leading: icon != null ? Icon(icon) : null,
              title: title != null
                  ? Hero(
                      tag: title!,
                      child: Text(title!),
                    )
                  : null)
          : null,
      body: child,
      bottomNavigationBar: bottomNavigationBar,
    ));
  }
}
