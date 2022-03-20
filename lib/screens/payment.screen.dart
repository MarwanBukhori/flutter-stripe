import 'package:flutter/material.dart' hide Card;
import 'package:flutter_app/screens/payment-web-view.screen.dart';
import 'package:flutter_app/services/stripe.service.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentScreen extends StatelessWidget {
  Future<void> checkout(BuildContext context) async {
    try {
      var paymentMethod = await StripeService.createCardPaymentMethod(
          number: '4242424242424242',
          expMonth: '04',
          expYear: '2022',
          cvc: '424');

      String description = 'Test Payment';
      var paymentIntent =
          await StripeService.createPaymentIntent('200', 'MYR', description);
      // print(paymentIntent);
      if (paymentIntent != null) {
        var confirmPayment = await Stripe.instance.confirmPayment(
          paymentIntent['client_secret'],
          PaymentMethodParams.cardFromMethodId(
              paymentMethodId: paymentMethod['id']),
        );
      }
      showDialog(
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text('Payment is successful'),
            );
          },
          context: context);
    } catch (e) {
      showDialog(
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text(e.toString()),
            );
          },
          context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () async {
                await checkout(context);
              },
              child: const Text('Checkout Using API/SDK'),
            ),
            ElevatedButton(
              onPressed: () async {
                await StripeService.launchPaymentUrl(
                    'https://buy.stripe.com/test_fZe5lj4KHcyub3a000');
              },
              child: const Text('Checkout Using Url Launcher'),
            ),
            ElevatedButton(
              onPressed: () async {
                List result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PaymentWebView(
                          url:
                              'https://buy.stripe.com/test_fZe5lj4KHcyub3a000'),
                      maintainState: true),
                );

                if (result[0]) {
                  showDialog(
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text('Payment is successful'),
                        );
                      },
                      context: context);
                } else {
                  showDialog(
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content:
                              Text('Payment is unsuccessful. ${result[1]}'),
                        );
                      },
                      context: context);
                }
              },
              child: const Text('Checkout using WebView'),
            ),
          ],
        ),
      ),
    );
  }
}
