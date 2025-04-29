import 'package:beta/constants/arguments.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/presentation/choose_term/choose_term_screen_controller.dart';
import 'package:beta/presentation/widgets/items_list.dart';
import 'package:beta/presentation/widgets/screen_wrapper.dart';
import 'package:beta/presentation/widgets/submit_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class ChooseTermScreen extends StatefulWidget {
  static const String route = '/choose-term';
  const ChooseTermScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ChooseTermScreenState();
}

class _ChooseTermScreenState extends State<ChooseTermScreen> {
  late ChooseTermScreenController _controller;

  @override
  void dispose() {
    Get.delete<ChooseTermScreenController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ChooseTermScreenArgument args = Get.find();
    if (!Get.isRegistered<ChooseTermScreenController>()) {
      _controller = Get.put(ChooseTermScreenController(this, argument: args));
    }
    return PopScope(
      canPop: _controller.canPop(),
      onPopInvokedWithResult: _controller.onPopInvoked,
      child: ScreenWrapper(
          child: Column(
        children: [
          Expanded(
            child: ItemsList(controller: _controller),
          ),
          if (_controller.okButtonVisible())
            SubmitButton(
                text: StringConstant.ok.tr(),
                onSubmit: _controller.onOkClicked,
                loading: _controller.loading && _controller.okButtonClicked)
        ],
      )),
    );
  }
}

class ConfirmationDialogueWidget extends StatelessWidget {
  const ConfirmationDialogueWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ChooseTermScreenController controller = Get.find();
    return Column(
      children: [
        Text(StringConstant.aboutToCouponWithTerms.tr()),
        for (int c = 0; c < controller.checkedTerms.length; c++)
          RichText(
              text: TextSpan(children: [
            TextSpan(text: controller.checkedTerms[c].path!.value!),
            TextSpan(
              text: controller.checkedTerms[c].term.name,
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ])),
        Text(StringConstant.doYouWantToProceed.tr())
      ],
    );
  }
}
