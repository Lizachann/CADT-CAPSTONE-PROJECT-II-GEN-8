import 'package:capstone_project_mobile/pages/login/login_email_page.dart';
import 'package:capstone_project_mobile/theme/base_app_colors.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool actionsEnabled;
  final bool actionsSearchEnabled;
  final bool leadingEnabled;
  final bool applogoEnabled;

  const MyAppBar({
    super.key,
    required this.title,
    this.actionsEnabled = false,
    this.actionsSearchEnabled = false,
    this.leadingEnabled = true,
    this.applogoEnabled = false,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return PreferredSize(
      preferredSize:
          const Size.fromHeight(70.0), // Set the height of the AppBar
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(20.0), // Adjust the radius as needed
        ),
        child: AppBar(
          actions: [
            if (actionsEnabled)
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginEmail()));
                },
                icon: const Icon(Icons.login),
              ),
            if (actionsSearchEnabled)
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginEmail()));
                },
                icon: const Icon(Icons.search),
              ),
          ],
          automaticallyImplyLeading: leadingEnabled,
          backgroundColor: colorScheme.primary,
          title: Row(
            children: [
              if (applogoEnabled)
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: ClipOval(
                    child: Image.asset(
                      "lib/assets/images/chantek_logo.png",
                      width: 35,
                      height: 35,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              Flexible(
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 22,
                    fontFamily: 'Kantumruy Pro',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: BaseAppColors.appGradient,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 60);
}