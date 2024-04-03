import 'package:flutter/material.dart';

class ScreenWrapper extends StatelessWidget {
  final Widget child;
  final String? title;
  final Widget? bottomNavigationBar;

  const ScreenWrapper(
      {super.key, required this.child, this.title, this.bottomNavigationBar});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: title != null
          ? AppBar(
              title: Hero(
                tag: title!,
                child: Text(title!),
              ),
            )
          : null,
      body: child,
      bottomNavigationBar: bottomNavigationBar,
    ));
  }
}
