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
          'History': 'History',
          'Translator': 'Translator',
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
          'Enter_text_to_translate': 'Enter text to translate:',
          'Type_something...': 'Type something...',
          'Target_Language:': 'Target Language:',
          'Result:': 'Result:',
          'My Library': 'My Library',
          'Create_New_Novel': 'Create New Novel',
          'Enter_your_novel_title': 'Enter your novel title',
          'Description': 'Description',
          'Title': 'Title',
          'Select_Genres: ': 'Select Genres:',
          'Create': 'Create',
          'Swipe_left_to_delete,_right_to_edit' : 'Swipe left to delete, right to edit',
          'Enter_new_chapter_title': 'Enter new chapter title',
        },
        'id_ID': {
          'name': 'Nama',
          'email': 'Email',
          'library': 'Perpustakaan',
          'History': 'Riwayat',
          'Translator': 'Penerjemah',
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
          'Enter_text_to_translate': 'Masukkan teks untuk diterjemahkan:',
          'Type_something...': 'Ketik sesuatu...',
          'Target_Language:': 'Bahasa Target:',
          'Result:': 'Hasil:',
          'My Library': 'Perpustakaan Saya',
          'Create_New_Novel': 'Buat Novel Baru',
          'Enter_your_novel_title': 'Masukkan judul novel Anda',
          'Description': 'Deskripsi',
          'Title': 'Judul',
          'Select_Genres: ': 'Pilih Genre:',
          'Create': 'Buat',
          'Swipe_left_to_delete,_right_to_edit': 'Geser ke kiri untuk menghapus, ke kanan untuk mengedit',
          'Enter_new_chapter_title': 'Masukkan judul bab baru',
        }
      };
}
