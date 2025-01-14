// ignore_for_file: avoid_print
import 'package:capstone_project_mobile/constants/api_route_constant.dart';
import 'package:capstone_project_mobile/core/model/dto/create_payment_intent.dart';
import 'package:capstone_project_mobile/core/services/http_service.dart';
import 'package:capstone_project_mobile/core/services/patch_service.dart';
import 'package:capstone_project_mobile/theme/base_app_colors.dart';
import 'package:capstone_project_mobile/utils/api_helper.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService {
  StripeService._();

  static final StripeService instance = StripeService._();

  Future<void> makePayment(CreatePaymentIntent body) async {
    try {
      int amountInCents = convertFromDollarToCent(body.amount);

      HttpService httpService =
          HttpService(path: '${ApiRoute.stripe.name}/payment-intent');
      var HttpResponse(:httpRes, :jsonData) = await httpService.httpPost(
        body: {
          'amount': amountInCents,
          'currency': body.currency,
          'patientId': body.patientId,
          'credits': body.credits
        },
      );
      if (ApiHelper.isOk(httpRes.statusCode)) {
        String? paymentIntentClientSecret = jsonData['data']['client_secret'];
        String paymentIntentId = jsonData['data']['id'];
        if (paymentIntentClientSecret == null) return;
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentClientSecret,
          merchantDisplayName: 'ChanTek Application',
          appearance: PaymentSheetAppearance(
            colors: PaymentSheetAppearanceColors(
                primary: BaseAppColors.secondaryColor,
                primaryText: BaseAppColors.tertiaryColor,
                secondaryText: BaseAppColors.tertiaryColor,
                componentBackground: BaseAppColors.inversePrimaryColor,
                placeholderText: BaseAppColors.tertiaryColor,
                componentText: BaseAppColors.tertiaryColor,
                background: BaseAppColors.inversePrimaryColor),
          ),
        ));
        await _processPayment(
            amount: amountInCents,
            patientId: '63686861790123456789abcd',
            paymentIntentId: paymentIntentId,
            credits: body.amount);
      } else {
        throw jsonData;
      }
    } catch (e) {
      print('Error during payment: $e');
      rethrow;
    }
  }

  int convertFromDollarToCent(int amount) {
    return amount * 100;
  }

  Future<void> _processPayment(
      {required int amount,
      required String patientId,
      required String paymentIntentId,
      required int credits}) async {
    try {
      // Present the payment sheet
      await Stripe.instance.presentPaymentSheet();

      //Create a transaction to our database

      //Update user's balance
      await PatchService.updatePatientCredit(patientId, credits);

      print('Payment successful!');
    } on StripeException catch (e) {
      print('Stripe error: ${e.error.localizedMessage}');
      throw {e.error.localizedMessage};
    } catch (e) {
      print('Payment error: $e');
      rethrow;
    }
  }
}
