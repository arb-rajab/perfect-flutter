import 'package:beta/common/exceptions.dart';
import 'package:beta/domain/term_print.dart';
import 'package:beta/domain/value/gift_type.dart';
import 'package:beta/presentation/printed_qr_scanner/coupon_gift_widget.dart';
import 'package:beta/presentation/printed_qr_scanner/gift_widget_controller.dart';
import 'package:beta/presentation/printed_qr_scanner/no_gift_widget.dart';
import 'package:beta/presentation/printed_qr_scanner/other_gift_widget.dart';
import 'package:beta/presentation/widgets/loading_widget.dart';
import 'package:beta/presentation/widgets/message_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

//TODO apply test
class GiftWidget extends StatefulWidget {
  final String code;
  const GiftWidget({super.key, required this.code});

  @override
  State<StatefulWidget> createState() => _GiftWidgetState();
}

class _GiftWidgetState extends State<GiftWidget> {
  late GiftWidgetController _controller;

  @override
  initState() {
    Get.delete<GiftWidgetController>();
    _controller = Get.put(GiftWidgetController(state: this, code: widget.code));
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _controller.init();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller.loading) return const LoadingWidget();
    if (_controller.message.isNotEmpty) {
      return MessageWidget(_controller.message);
    }
    TermPrint termPrint = _controller.termPrint!;
    switch (termPrint.gift.value) {
      case GiftType.NULL:
        return const NoGiftWidget();
      case GiftType.COUPON:
        return CouponGiftWidget(coupon: _controller.coupon!);
      case GiftType.OTHER:
        return OtherGiftWidget(gift: termPrint.otherGift.value!);
      default:
        throw UnsupportedValueException(termPrint.gift.value.toString());
    }
  }
}
