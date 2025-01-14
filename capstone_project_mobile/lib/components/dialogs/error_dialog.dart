import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ErrorDialog extends StatelessWidget {
  final String text;
  const ErrorDialog({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle textButtonStyle = TextButton.styleFrom(
      backgroundColor: Colors.red,
      elevation: 3,
      shadowColor: Colors.grey[500],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
    );
    return AlertDialog(
      scrollable: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      actions: [
        Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: textButtonStyle,
                child: const Text('Try again',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
              ),
            ),
          ],
        ),
      ],
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
      content: SizedBox(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                LucideIcons.alertTriangle,
                size: 50,
                color: Colors.red,
              ),
              const SizedBox(height: 12),
              const Text(
                'Something went wrong!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    overflow: TextOverflow.visible,
                    color: Colors.red,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    height: 1.5,
                    overflow: TextOverflow.visible,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
