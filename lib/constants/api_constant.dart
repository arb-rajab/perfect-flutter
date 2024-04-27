import 'package:beta/configs/app.dart';

class ApiConstant {
  static const String _apiV1 = '${rootUrl}api/v1/';
  static const String notifications = '${_apiV1}notifications';
  static const String termPrintQr = '${_apiV1}term-print-qr/(QR)';
  static const String checkCoupon = '${_apiV1}coupons/(SERIAL)/check';
  static const String activateFreeVersion =
      '${_apiV1}coupons/activate-free-version';
  static const String frequentQuestions = '${_apiV1}frequent-questions';
  static const String termSubTerms =
      '${_apiV1}terms/(TERM_ID)/rootTerm/(ROOT_TERM_ID)/coupon/(COUPON_ID)/subTerms';
  static const String linkCouponWithTerms = '${_apiV1}coupons/(COUPON_ID)/link';
}
