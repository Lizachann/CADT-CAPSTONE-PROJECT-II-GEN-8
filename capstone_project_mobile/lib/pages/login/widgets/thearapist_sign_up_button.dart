import 'package:flutter/material.dart';

class TherapistSignUp extends StatelessWidget {
  final VoidCallback onTherapistSignUp;

  const TherapistSignUp({super.key, required this.onTherapistSignUp});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTherapistSignUp,
      child: const Text(
        'Become A Therapist',
        style: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}