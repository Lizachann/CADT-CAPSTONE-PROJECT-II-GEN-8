import 'package:flutter/material.dart';

class ProfilePictureCard extends StatelessWidget {
  final String imgPath;
  final double size;
  const ProfilePictureCard({super.key, required this.imgPath, this.size = 50});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Image.network(
        imgPath,
        width: size,
        height: size,
        fit: BoxFit.cover,
        filterQuality: FilterQuality.high,
      ),
    );
  }
}
