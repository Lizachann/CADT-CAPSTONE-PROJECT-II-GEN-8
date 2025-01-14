import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class MyBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) navigateBottomBar;

  const MyBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.navigateBottomBar,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return BottomNavigationBarTheme(
      data: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: colorScheme.primary,
        unselectedItemColor: colorScheme.inversePrimary,
        selectedItemColor: colorScheme.inversePrimary,
      ),
      child: BottomNavigationBar(
        onTap: navigateBottomBar,
        currentIndex: selectedIndex,
        items: [
          bottomNavigationBarItem(
            context: context,
            icon: LucideIcons.home,
            label: 'Home',
            selectedIndex: selectedIndex,
            index: 0,
          ),
          bottomNavigationBarItem(
            context: context,
            icon: LucideIcons.heartHandshake,
            label: 'Forum',
            selectedIndex: selectedIndex,
            index: 1,
          ),
          bottomNavigationBarItem(
            context: context,
            icon: LucideIcons.book,
            label: 'Therapists',
            selectedIndex: selectedIndex,
            index: 2,
          ),
          bottomNavigationBarItem(
            context: context,
            icon: LucideIcons.library,
            label: 'Resource',
            selectedIndex: selectedIndex,
            index: 3,
          ),
          bottomNavigationBarItem(
            context: context,
            icon: LucideIcons.user,
            label: 'Profile',
            selectedIndex: selectedIndex,
            index: 4,
          ),
        ],
      ),
    );
  }
}

BottomNavigationBarItem bottomNavigationBarItem({
  required BuildContext context,
  required IconData icon,
  required String label,
  required int selectedIndex,
  required int index,
}) {
  final bool isSelectedIndex = selectedIndex == index;
  ColorScheme colorScheme = Theme.of(context).colorScheme;
  return BottomNavigationBarItem(
    icon: Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelectedIndex ? const Color(0xFFD2E7FF) : Colors.transparent,
      ),
      padding:
          isSelectedIndex ? const EdgeInsets.all(12) : const EdgeInsets.all(0),
      child: Icon(
        icon,
        color:
            isSelectedIndex ? colorScheme.primary : colorScheme.inversePrimary,
      ),
    ),
    label: label,
  );
}
