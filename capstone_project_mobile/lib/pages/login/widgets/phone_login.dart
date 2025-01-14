import 'package:flutter/material.dart';

class PhoneSignInButton extends StatelessWidget {
  final VoidCallback onLoginPhone;

  const PhoneSignInButton({super.key, required this.onLoginPhone});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onLoginPhone,
      icon: const Icon(Icons.phone),
      label: const Text(
        'Phone',
        style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.w400),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(240, 240, 240, 1),
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: const BorderSide(color: Colors.transparent),
        ),
      ),
    );
  }
}