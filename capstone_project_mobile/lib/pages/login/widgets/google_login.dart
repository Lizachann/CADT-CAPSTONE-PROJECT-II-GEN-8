import 'package:flutter/material.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        // Handle sign in with Google
      },
      icon: Image.asset(
        'lib/assets/icons/google.png',
        height: 25,
        width: 25,
      ),
      label: const Text(
        'Google',
        style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.w400),
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: const BorderSide(color: Colors.transparent),
        ),
        backgroundColor: const Color.fromRGBO(240, 240, 240, 1),
      ),
    );
  }
}