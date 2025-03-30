import 'package:in_app_review/in_app_review.dart';

Future<void> showRequestReview() async {
  final InAppReview inAppReview = InAppReview.instance;
  if (await inAppReview.isAvailable()) {
    inAppReview.requestReview();
  }
}
