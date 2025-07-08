import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/theme_controller.dart';
import '../../controllers/locale_controller.dart';

class AppSettings extends StatelessWidget {
  const AppSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    final LocaleController localeController = Get.find();
    final textColor = Theme.of(context).colorScheme.onBackground;

    return Scaffold(
      appBar: AppBar(
        title: Text('app_settings'.tr, style: TextStyle(color: textColor)),
        iconTheme: IconThemeData(color: textColor),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('theme'.tr, style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.bold)),
          Obx(() => SwitchListTile(
                title: Text('dark_mode'.tr, style: TextStyle(color: textColor)),
                value: themeController.isDarkMode,
                onChanged: (val) => themeController.toggleTheme(val),
              )),
          const Divider(),
          Text('language'.tr, style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.bold)),
          Obx(() => DropdownButton<String>(
                value: localeController.locale.value.languageCode,
                dropdownColor: Theme.of(context).cardColor,
                style: TextStyle(color: textColor),
                items: const [
                  DropdownMenuItem(value: 'id', child: Text('Bahasa Indonesia')),
                  DropdownMenuItem(value: 'en', child: Text('English')),
                ],
                onChanged: (value) {
                  if (value != null) localeController.changeLocale(value);
                },
              )),
        ],
      ),
    );
  }
} 
