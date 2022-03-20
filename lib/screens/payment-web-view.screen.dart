import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebView extends StatelessWidget {
  final String url;

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  PaymentWebView({required this.url});

  @override
  Widget build(BuildContext context) {
    denied() {
      Navigator.pop(context, [false, "Payment failed."]);
    }

    succeed() {
      Navigator.pop(context, [true, "Payment successful."]);
    }

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, [false, 'Payment cancelled.']);
        return false;
      },
      child: SafeArea(
        child: WebView(
          initialUrl: url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) async {
            String url;
            while (true) {
              url = (await webViewController.currentUrl())!;

              if (url.contains("payment_successful")) {
                succeed();
                break;
              }
              if (url.contains("payment_failed")) {
                denied();
                break;
              }
            }
          },
        ),
      ),
    );
  }
}
