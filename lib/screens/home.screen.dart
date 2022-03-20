import 'package:flutter/material.dart';
import 'package:flutter_app/screens/payment.screen.dart';

import 'map.screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              child: const Text('Map Screen'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MapScreen(),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Payment Screen'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
