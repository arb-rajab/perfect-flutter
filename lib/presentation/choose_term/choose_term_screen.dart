import 'package:beta/application/services/database_service.dart';
import 'package:beta/domain/coupon_type.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/presentation/widgets/screen_wrapper.dart';
import 'package:flutter/material.dart';

class ChooseTermScreen extends StatefulWidget {
  static const String route = '/choose-term';
  const ChooseTermScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ChooseTermScreenState();
}

class _ChooseTermScreenState extends State<ChooseTermScreen> {
  @override
  Widget build(BuildContext context) {
    return const ScreenWrapper(child: Center());
  }
}

class ChooseTermScreenArgument {
  final coupons coupon;
  final List<TermData> terms;
  final bool free;
  final CouponType couponType;

  ChooseTermScreenArgument(
      {required this.coupon,
      required this.terms,
      required this.free,
      required this.couponType});
}
