import 'package:capstone_project_mobile/components/cards/coin_card.dart';
import 'package:capstone_project_mobile/core/controller/auth_controller.dart';
import 'package:capstone_project_mobile/core/controller/credit_package_controller.dart';
import 'package:capstone_project_mobile/core/model/credit_package.dart';
import 'package:capstone_project_mobile/layouts/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CoinsPaymentPage extends StatelessWidget {
  final CreditPackageController creditPackageController =
      Get.put(CreditPackageController());

  final AuthController authController = Get.put(AuthController());

  CoinsPaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final int credits = authController.isLoggedIn.value
        ? authController.user.value!.credits
        : 0;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: const MyAppBar(title: 'Coins and Payment'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(26),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(
                          colorScheme.secondary.red,
                          colorScheme.secondary.green,
                          colorScheme.secondary.blue,
                          0.3),
                      Color.fromRGBO(
                          colorScheme.primary.red,
                          colorScheme.primary.green,
                          colorScheme.primary.blue,
                          0.3),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Your coins',
                      style: TextStyle(
                          fontSize: 28, color: Color.fromRGBO(0, 46, 110, 1)),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      credits.toString(),
                      style: const TextStyle(
                          fontSize: 26,
                          color: Color.fromRGBO(0, 46, 110, 1),
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return _bottomModal(context);
                    },
                  );
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: [colorScheme.secondary, colorScheme.primary],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 200,
                        child: Text(
                          'What is Coins and Payment?',
                          style: TextStyle(
                              height: 1.25,
                              fontSize: 16,
                              overflow: TextOverflow.clip,
                              color: colorScheme.inversePrimary,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Icon(
                        size: 28,
                        LucideIcons.chevronDown,
                        color: colorScheme.inversePrimary,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Coin Store',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 16),
              FutureBuilder<List<CreditPackage>>(
                future:
                    creditPackageController.getCreditPackages(), // Fetch data
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('An error occurred!'),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              creditPackageController.fetchAllCreditPackages();
                            },
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  } else if (snapshot.hasData) {
                    final creditPackages = snapshot.data!;
                    return ListView.builder(
                      padding: const EdgeInsets.all(0),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: creditPackages.length,
                      itemBuilder: (context, index) {
                        CreditPackage creditPackage = creditPackages[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: CoinCard(
                            creditPackage: creditPackage,
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(child: Text('No data available'));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _bottomModal(BuildContext context) {
  ColorScheme colorScheme = Theme.of(context).colorScheme;
  return Container(
    height: 300,
    decoration: BoxDecoration(
      color: colorScheme.background,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30.0),
        topRight: Radius.circular(30.0),
      ),
    ),
    child: ListView(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: const Color.fromRGBO(243, 248, 254, 1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              border: Border(bottom: BorderSide(color: colorScheme.tertiary))),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'What is Coins and Payment?',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: colorScheme.tertiary,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Text(
                ' You can earn virtual coins through various payment methods. Use these coins to make secure and easy transactions within the app.',
                overflow: TextOverflow.fade,
                textAlign: TextAlign.center,
                style: TextStyle(color: colorScheme.tertiary, fontSize: 18),
              ),
              const SizedBox(height: 26),
              Text(
                'Collect coins by purchasing them directly or through promotions and rewards.',
                overflow: TextOverflow.fade,
                textAlign: TextAlign.center,
                style: TextStyle(color: colorScheme.tertiary, fontSize: 18),
              )
            ],
          ),
        ),
      ],
    ),
  );
}
