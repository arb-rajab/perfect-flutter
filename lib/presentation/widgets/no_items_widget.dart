import 'package:beta/constants/string_constant.dart';
import 'package:beta/presentation/widgets/message_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

class NoItemsWidget extends StatelessWidget {
  const NoItemsWidget({super.key});

  @override
  Widget build(BuildContext context) =>
      MessageWidget(StringConstant.listEmpty.tr());
}
