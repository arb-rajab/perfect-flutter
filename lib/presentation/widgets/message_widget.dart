import 'package:flutter/cupertino.dart';

//TODO add test
class MessageWidget extends StatelessWidget {
  final String message;

  const MessageWidget(this.message, {super.key});

  @override
  Widget build(BuildContext context) => Center(child: Text(message));
}
