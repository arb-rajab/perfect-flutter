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
  static const String updateToken = '${_apiV1}device/token';
  static const String getTermsUpdates = '${_apiV1}terms/updates';
  static const String getEbook = '${_apiV1}ebooks/(TERM_ID)';
  static const String getVoice = '${_apiV1}voices/(TERM_ID)';
  static const String getTermContent = '${_apiV1}term/(TERM_ID)/content';
  static const String questionTagInformation =
      '${_apiV1}question-tag/(QUESTION_TAG_ID)/info/ime1/(IME1)/language/(LANGUAGE)';
  static const String reportQuestion =
      '${_apiV1}questions/(QUESTION_ID)/report';
  static const String checkedAnswers = '${_apiV1}answers/checked';
  static const String getYoutubeVideo = '${_apiV1}youtubeVideos/(TERM_ID)';
  static const String getComments = '${_apiV1}comments/(ITEM_TYPE)/(ITEM_ID)';
  static const String submitComment = '${_apiV1}comments';

  static const String getQuestionTerm =
      '${_apiV1}questions/(QUESTION_UUID)/parent-term';
}
