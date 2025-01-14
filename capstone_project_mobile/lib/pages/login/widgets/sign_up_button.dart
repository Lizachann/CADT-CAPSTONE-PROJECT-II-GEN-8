import 'package:flutter/material.dart';

class SignUpText extends StatelessWidget {
  final VoidCallback onPressed;

  const SignUpText({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text("Don’t have an account? "),
        TextButton(
          onPressed: onPressed,
          child: const Text(
            'Sign Up',
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}