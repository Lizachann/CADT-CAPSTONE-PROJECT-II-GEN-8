import 'package:capstone_project_mobile/layouts/layout_page.dart';
import 'package:capstone_project_mobile/consts.dart';
import 'package:capstone_project_mobile/routes/app_route.dart';
import 'package:capstone_project_mobile/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/route_manager.dart';

Future main() async {
  await dotenv.load(fileName: '.env');
await _setup();
  runApp(
    const MyApp(),
  );
}

Future<void> _setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = stripePublishableKey;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Capstone Project',
      getPages: AppRoute.routes,
      theme: appTheme,
      home: const LayoutPage(),
    );
  }
}
