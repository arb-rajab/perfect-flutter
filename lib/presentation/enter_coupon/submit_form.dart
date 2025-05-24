import 'package:beta/common/validators.dart';
import 'package:beta/configs/style.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/presentation/animations/opacity_animation.dart';
import 'package:beta/presentation/contact_us/contact_us_screen.dart';
import 'package:beta/presentation/enter_coupon/enter_coupon_screen_controller.dart';
import 'package:beta/presentation/widgets/form_message_widget.dart';
import 'package:beta/presentation/widgets/input_widget.dart';
import 'package:beta/presentation/widgets/submit_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/instance_manager.dart';
import 'package:go_router/go_router.dart';

class SubmitForm extends StatelessWidget {
  final EnterCouponScreenController _controller = Get.find();

  SubmitForm({super.key});
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _controller.formKey,
        child: Padding(
          padding: const EdgeInsets.all(margin),
          child: Column(
            children: [
              if (_controller.message.isNotEmpty)
                FormMessageWidget(
                  message: _controller.message,
                  onDismiss: _controller.dismissMessage),
              EnterNameInput(),
              EnterCouponInput(),
              SubmitButton(
                  loading: _controller.loading && _controller.okClicked,
                  text: StringConstant.ok.tr(),
                  onSubmit: _controller.onOkclick),
              Text(StringConstant.youCanInstead.tr(),
                  style: Theme.of(context).textTheme.bodyLarge),
              SubmitButton(
                  loading: _controller.loading &&
                      _controller.activateFreeVersionClicked,
                  text: StringConstant.activateFreeVersion.tr(),
                  onSubmit: _controller.onActivateFreeVersionClick),
              const DoYouNeedHelp()
            ],
          ),
        ));
  }
}

class EnterNameInput extends StatelessWidget {
  EnterNameInput({super.key});
  final EnterCouponScreenController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return InputWidget(
        error: controller.nameError,
        label: StringConstant.firstAndLastName.tr(),
        validator: Validator.empty,
        controller: controller.nameController);
  }
}

class EnterCouponInput extends StatelessWidget {
  EnterCouponInput({super.key});
  final EnterCouponScreenController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return InputWidget(
      label: StringConstant.coupon.tr(),
      validator: (value) {
        // Trim the value before validation
        final trimmedValue = value?.trim();
        return Validator.multiValidators(
            [Validator.empty, Validator.isMD5], trimmedValue);
      },
      controller: controller.couponController,
      // Optional: Add input formatter to prevent whitespace input
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp(r'^\s|\s$')),
      ],
    );
  }
}

class DoYouNeedHelp extends StatelessWidget {
  const DoYouNeedHelp({super.key});

  @override
  Widget build(BuildContext context) {
    return OpacityAnimation(
        child: Padding(
      padding: const EdgeInsets.all(margin),
      child: InkWell(
        onTap: () => context.push(ContactUsScreen.route),
        child: Text(
          StringConstant.doYouNeedHelp.tr(),
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).primaryColor),
        ),
      ),
    ));
  }
}
