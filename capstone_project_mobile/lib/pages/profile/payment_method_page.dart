import 'package:capstone_project_mobile/core/model/credit_package.dart';
import 'package:capstone_project_mobile/layouts/my_app_bar.dart';
import 'package:flutter/material.dart';

class PaymentMethod extends StatelessWidget {
  final CreditPackage creditPackage;

  const PaymentMethod({super.key, required this.creditPackage});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(title: 'Payment Method'),
      body: Center(),
    );
  }
}
