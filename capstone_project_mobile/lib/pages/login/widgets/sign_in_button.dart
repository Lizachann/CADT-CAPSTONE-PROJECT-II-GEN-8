import 'package:capstone_project_mobile/theme/base_app_colors.dart';
import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  final VoidCallback onSignIn;

  const SignInButton({super.key, required this.onSignIn});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onSignIn,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        backgroundColor: BaseAppColors.primaryColor,
      ),
      child: const Text(
        'Sign In',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
      ),
    );
  }
}