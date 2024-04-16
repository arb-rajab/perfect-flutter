import 'package:beta/presentation/animations/opacity_animation.dart';
import 'package:flutter/cupertino.dart';

//TODO add test
class MessageWidget extends StatelessWidget {
  final String message;

  const MessageWidget(this.message, {super.key});

  @override
  Widget build(BuildContext context) =>
      OpacityAnimation(child: Center(child: Text(message)));
}
