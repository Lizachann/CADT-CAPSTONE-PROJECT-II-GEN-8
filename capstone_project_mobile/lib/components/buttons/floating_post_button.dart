import 'package:capstone_project_mobile/pages/forum/create_post_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

class FloatingPostButton extends StatelessWidget {
  const FloatingPostButton({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;

    return ElevatedButton.icon(
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(
          Colors.amber,
        ),
        padding: MaterialStatePropertyAll(
          EdgeInsets.symmetric(vertical: 20, horizontal: 24),
        ),
        alignment: Alignment.center,
      ),
      onPressed: () {
        Get.to(() => const CreatePostScreen());
      },
      icon: Icon(
        LucideIcons.plus,
        color: colorScheme.inversePrimary,
      ),
      label: Text(
        'Post',
        style: textTheme.displayMedium!.copyWith(
          color: colorScheme.inversePrimary,
        ),
      ),
    );
  }
}
