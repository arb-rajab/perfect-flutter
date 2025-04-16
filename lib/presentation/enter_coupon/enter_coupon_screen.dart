
import 'package:beta/constants/string_constant.dart';
import 'package:beta/constants/tutorial_constant.dart';
import 'package:beta/presentation/enter_coupon/enter_coupon_screen_controller.dart';
import 'package:beta/presentation/enter_coupon/submit_form.dart';
import 'package:beta/presentation/scan_qr/scan_qr_screen.dart';
import 'package:beta/presentation/widgets/custom_list_view.dart';
import 'package:beta/presentation/widgets/no_background_logo.dart';
import 'package:beta/presentation/widgets/rectangle_widget.dart';
import 'package:beta/presentation/widgets/screen_wrapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:go_router/go_router.dart';
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
    final isLargeScreen = MediaQuery.of(context).size.width > 600;
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
      floatingActionButton: FloatingActionButton.extended(
          key: scanQrKey,
          tooltip: ScanQrScreen.title,
          heroTag: ScanQrScreen.title,
          onPressed: () async {
            var result = await context.push(ScanQrScreen.route);
            if (result is String) _controller.setCoupon(result);
          },
          icon: const Icon(ScanQrScreen.icon),
          label: Text(ScanQrScreen.title)),
      child: CustomListView(
        children: [isLargeScreen ? _DesktopLayout() : _MobileLayout()],
      ),
    );
  }
}

class _MobileLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [const NoBackgroundLogo(), SubmitForm()],
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Expanded(flex: 1, child: NoBackgroundLogo()),
        Expanded(flex: 2, child: SubmitForm())
      ],
    );
  }
}
