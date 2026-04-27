import 'package:beta/application/services/payment_service.dart';
import 'package:beta/constants/api_constant.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../../common/tests.dart';

// Create mocks using classes that implement/extend the required objects
class MockStripeInstance extends Mock implements Stripe {}

Future main() async {
  MockStripeInstance mockStripeInstance = MockStripeInstance();
  PaymentService paymentService =
      Get.put(PaymentService(stripe: mockStripeInstance));
  await initTests();

  // Mock the platform channel to avoid MissingPluginException
  // const MethodChannel('flutter.stripe/payments')
  //     .setMockMethodCallHandler((MethodCall methodCall) async {
  //   // Return null or whatever default value is expected for these calls
  //   return null;
  // });
  group('PaymentService Tests', () {
    setUp(() {
      registerFallbackValue(const SetupPaymentSheetParameters(
        paymentIntentClientSecret: 'test',
        merchantDisplayName: 'Test',
      ));
    });

    test('initialize sets publishable key and applies settings', () async {
      // Mock the behavior of applySettings
      when(() => mockStripeInstance.applySettings())
          .thenAnswer((_) async => Future.value());

      await paymentService.initialize();
      expect(Stripe.publishableKey, isNotNull);
    });

    test('createPaymentIntent calls API and triggers makePayment on success',
        () async {
      final mockResponse = {'client_secret': 'pi_123_secret_456'};

      // 1. Mock the API call using your existing dioAdapter style
      dioAdapter.onPost(ApiConstant.createPaymentIntent,
          (server) => server.reply(200, mockResponse),
          data: FormData.fromMap({
            'amount': paymentService.amount,
            'currency': paymentService.currency
          }));

      // 2. Stub Stripe methods
      when(() => mockStripeInstance.initPaymentSheet(
              paymentSheetParameters: any(named: 'paymentSheetParameters')))
          .thenAnswer((_) => Future.value());
      when(() => mockStripeInstance.presentPaymentSheet())
          .thenAnswer((_) => Future.value());

      // 3. Act: Execute the service call
      await paymentService.createPaymentIntent();

      // 4. Assert: Verify the Stripe dialogue was initiated
      verify(() => mockStripeInstance.initPaymentSheet(
              paymentSheetParameters: any(named: 'paymentSheetParameters')))
          .called(1);
      verify(() => mockStripeInstance.presentPaymentSheet()).called(1);
    });
  });
}
