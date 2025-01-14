import 'package:flutter/material.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({super.key});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  var isLike = false;
  void handleLike() {
    setState(() {
      isLike = !isLike; // Toggle the value of isLike
    });
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
      ),
      child: IconButton(
        onPressed: () {
          handleLike();
        },
        icon: Icon(
          isLike ? Icons.bookmark : Icons.bookmark_outline,
          color: isLike ? colorScheme.primary : Colors.black,
          size: 30,
        ),
      ),
    );
  }
}
