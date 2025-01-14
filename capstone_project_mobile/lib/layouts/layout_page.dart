import 'package:capstone_project_mobile/core/controller/auth_controller.dart';
import 'package:capstone_project_mobile/layouts/my_app_bar.dart';
import 'package:capstone_project_mobile/layouts/my_bottom_navigation_bar.dart';
import 'package:capstone_project_mobile/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key, this.selectedIndex = 0});

  final int? selectedIndex;

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  int? _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());

    return Scaffold(
      appBar: MyAppBar(
        // title: AppRoute.appTitle[_selectedIndex!],
        title: _selectedIndex == 0
            ? (authController.isLoggedIn.value
                ? 'Welcome, ${authController.user.value?.username}!'
                : AppRoute.appTitle[_selectedIndex!])
            : AppRoute.appTitle[_selectedIndex!],
        // actionsEnabled: true,
        actionsEnabled: authController.isLoggedIn.value ? false : true,
        applogoEnabled: true,
      ),
      body: FutureBuilder(
        future: rootBundle.loadString('.env'),
        initialData: '',
        builder: (context, snapshot) => IndexedStack(
          index: _selectedIndex,
          children: AppRoute.appPages,
        ),
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        selectedIndex: _selectedIndex!,
        navigateBottomBar: _navigateBottomBar,
      ),
    );
  }
}
