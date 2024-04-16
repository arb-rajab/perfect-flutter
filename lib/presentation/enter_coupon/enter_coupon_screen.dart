import 'package:beta/common/validators.dart';
import 'package:beta/configs/style.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/constants/tutorial_constant.dart';
import 'package:beta/presentation/animations/opacity_animation.dart';
import 'package:beta/presentation/contact_us/contact_us_screen.dart';
import 'package:beta/presentation/enter_coupon/enter_coupon_screen_controller.dart';
import 'package:beta/presentation/scan_qr/scan_qr_screen.dart';
import 'package:beta/presentation/widgets/form_message_widget.dart';
import 'package:beta/presentation/widgets/input_widget.dart';
import 'package:beta/presentation/widgets/no_background_logo.dart';
import 'package:beta/presentation/widgets/rectangle_widget.dart';
import 'package:beta/presentation/widgets/screen_wrapper.dart';
import 'package:beta/presentation/widgets/submit_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class EnterCouponScreen extends StatefulWidget {
  static const route = '/enter-coupon';
  static String title = StringConstant.addCoupon.tr();
  static const icon = Icons.add_card;

  const EnterCouponScreen({super.key});

  @override
  State<EnterCouponScreen> createState() => _EnterCouponScreenState();
}

class _EnterCouponScreenState extends State<EnterCouponScreen> {
  late EnterCouponScreenController _controller;
  final GlobalKey scanQrKey = GlobalKey();

  @override
  void initState() {
    Get.delete<EnterCouponScreenController>();
    _controller = Get.put(EnterCouponScreenController(this));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
        targets: [
          CustomTargetFocus(
              identify: TutorialConstant.scanQr,
              keyTarget: scanQrKey,
              contents: [
                TargetContent(
                    builder: (context, controller) {
                      return RectangleWidget(
                          child: Text(StringConstant.scanQrDescription.tr()));
                    },
                    align: ContentAlign.top)
              ])
        ],
        //TODO add test
        floatingActionButton: FloatingActionButton.extended(
            key: scanQrKey,
            tooltip: ScanQrScreen.title,
            heroTag: ScanQrScreen.title,
            onPressed: () async {
              var result =
                  await Navigator.pushNamed(context, ScanQrScreen.route);
              if (result is String) _controller.setCoupon(result);
            },
            icon: const Icon(ScanQrScreen.icon),
            label: Text(ScanQrScreen.title)),
        child: ListView(
          children: [
            const NoBackgroundLogo(),
            Form(
                key: _controller.formKey,
                child: Padding(
                  padding: const EdgeInsets.all(margin),
                  child: Column(
                    children: [
                      FormMessageWidget(
                          message: _controller.message,
                          onDismiss: _controller.dismissMessage),
                      _EnterNameInput(),
                      _EnterCoupon(),
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
                      _DoYouNeedHelp()
                    ],
                  ),
                ))
          ],
        ));
  }
}

//TODO apply test
class _EnterNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    EnterCouponScreenController controller =
        Get.find<EnterCouponScreenController>();
    return InputWidget(
        error: controller.nameError,
        label: StringConstant.firstAndLastName.tr(),
        validator: Validator.empty,
        controller: controller.nameController);
  }
}

//TODO apply test
class _EnterCoupon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InputWidget(
        label: StringConstant.coupon.tr(),
        validator: (value) => Validator.multiValidators(
            [Validator.empty, Validator.isMD5], value),
        controller: Get.find<EnterCouponScreenController>().couponController);
  }
}

//TODO apply test
class _DoYouNeedHelp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OpacityAnimation(
        child: Padding(
      padding: const EdgeInsets.all(margin),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, ContactUsScreen.route),
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
