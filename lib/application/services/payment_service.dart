import 'package:beta/application/services/network_service.dart';
import 'package:beta/configs/app.dart';
import 'package:beta/constants/api_constant.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentService {
  final Stripe stripe;

  int amount = 0;
  String currency = 'usd';

  PaymentService({Stripe? stripe}) : stripe = stripe ?? Stripe.instance;

  Future initialize() async {
    // Initialize Stripe with the publishable key
    Stripe.publishableKey = stripePublishableKey;
    return stripe.applySettings();
  }

  Future createPaymentIntent() async {
    return NetworkService.dio
        .post(ApiConstant.createPaymentIntent,
            data: FormData.fromMap({
              'amount': amount,
              'currency': currency,
            }))
        .then((response) async {
      String clientSecret = response.data['client_secret'];
      return makePayment(clientSecret);
    });
  }

  Future makePayment(String clientSecret) async {
    await stripe.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        merchantDisplayName: name,
        style: ThemeMode.system,
      ),
    );

    await stripe.presentPaymentSheet();
  }
}
