import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocaleController extends GetxController {
  var locale = const Locale('id', 'ID').obs;

  void changeLocale(String langCode) {
    final newLocale = langCode == 'en'
      ? const Locale('en', 'US')
      : const Locale('id', 'ID');
    locale.value = newLocale;
    Get.updateLocale(newLocale);  // 🔑 Inform GetX to update the app locale
  }
}

// This class holds the actual translations
class AppTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'name': 'Name',
          'email': 'Email',
          'library': 'Library',
          'history': 'History',
          'language': 'Language',
          'save_changes': 'Save Changes',
          'profile': 'Profile',
          'theme': 'Theme',
          'dark_mode': 'Dark Mode',
          'app_settings': 'App Settings',
          'settings ': 'Settings',
          'account': 'Account',
          'edit_profile': 'Edit Profile',
          'change_password': 'Change Password',
          'other': 'Other',
          'about_us': 'About Us',
          'faq': 'FAQ',
          'review_help': 'Review & Help',
          'help_us': 'Help Us',
          'current_password': 'Current Password',
          'new_password': 'New Password',
          'confirm_password': 'Confirm Password',
        },
        'id_ID': {
          'name': 'Nama',
          'email': 'Email',
          'library': 'Perpustakaan',
          'history': 'Riwayat',
          'language': 'Bahasa',
          'save_changes': 'Simpan Perubahan',
          'Profile': 'Profil',
          'theme': 'Tema',
          'dark_mode': 'Mode Gelap',
          'app_settings': 'Pengaturan Aplikasi',
          'settings ': 'Pengaturan',
          'account': 'Akun',
          'edit_profile': 'Ubah Profil',
          'change_password': 'Ganti Kata Sandi',
          'other': 'Lainnya',
          'about_us': 'Tentang Kami',
          'faq': 'FAQ',
          'review_help': 'Ulasan & Bantuan',
          'help_us': 'Bantu Kami',
          'current_password': 'Kata Sandi Saat Ini',
          'new_password': 'Kata Sandi Baru',
          'confirm_password': 'Konfirmasi Kata Sandi',
        }
      };
}
