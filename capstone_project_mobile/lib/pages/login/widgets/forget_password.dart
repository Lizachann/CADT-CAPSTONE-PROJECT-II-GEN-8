import 'package:flutter/material.dart';

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () {
          // Handle forgot password
        },
        child: const Text(
          'Forget Password?',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}