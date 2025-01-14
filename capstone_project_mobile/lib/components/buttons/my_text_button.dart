import 'package:flutter/material.dart';

class MyTextButton extends StatelessWidget {
  final String text;
  final Icon icon;
  final void Function()? onTap;
  final EdgeInsets? padding;
  final bool loading;

  const MyTextButton({
    super.key,
    this.padding,
    required this.text,
    required this.icon,
    required this.onTap,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return TextButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: Colors.grey.shade400,
            ),
          ),
        ),
      ),
      onPressed: onTap,
      child: Container(
        padding: padding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(
              width: 8,
            ),
            Text(
              text,
              style: TextStyle(color: colorScheme.tertiary),
            ),
          ],
        ),
      ),
    );
  }
}
