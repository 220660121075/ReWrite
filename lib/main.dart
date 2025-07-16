import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/theme_controller.dart';
import 'controllers/locale_controller.dart';
import 'themes/app_themes.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'model/novel.dart';
import 'model/chapter.dart';
import 'model/history_entry.dart';
import 'screens/splash screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 

  await Hive.initFlutter();

  // Register Hive TypeAdapters
  Hive.registerAdapter(NovelAdapter()); //register novel mode
  Hive.registerAdapter(ChapterAdapter()); //register chapter model
  Hive.registerAdapter(HistoryEntryAdapter()); // register history entry model

  // Open boxes
  await Hive.openBox<Novel>('novelsBox'); //novelsBox storage
  await Hive.openBox<HistoryEntry>('historyBox'); // historyBox storage

  runApp(const ReWriteApp());
}

class ReWriteApp extends StatelessWidget {
  const ReWriteApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());
    final LocaleController localeController = Get.put(LocaleController());

    return Obx(() => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'ReWrite',
          translations: AppTranslation(),
          locale: localeController.locale.value,
          fallbackLocale: const Locale('id', 'ID'),
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          themeMode: themeController.themeMode.value,
          home: const SplashScreen(),

        ));
  }
}
