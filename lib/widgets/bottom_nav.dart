import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewrite/controllers/locale_controller.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocaleController>(
      builder: (_) {
        return BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTap,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.library_books),
              label: 'library'.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.history),
              label: 'history'.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.translate),
              label: 'translator'.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              label: 'profile'.tr,
            ),
          ],
        );
      },
    );
  }
}
