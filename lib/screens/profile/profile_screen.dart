import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewrite/screens/profile/Review_support_screen.dart';
import 'package:rewrite/screens/profile/aboutus_screen.dart';
import 'package:rewrite/screens/profile/app_settings_screen.dart';
import 'package:rewrite/screens/profile/change_password_screen.dart';
import 'package:rewrite/screens/profile/edit_profile_screen.dart';
import 'package:rewrite/screens/profile/faq_screen.dart';
import 'package:rewrite/screens/profile/supportus_screen.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final String? photoPath = null; // Simulasi data profil pengguna null=default_picture
    final ImageProvider profileImage = _getProfileImage(photoPath);
    final textColor = Theme.of(context).colorScheme.onBackground;

    return Scaffold(
      appBar: AppBar(
        title: Text('profile'.tr, style: TextStyle(color: textColor)),
        centerTitle: true,
        iconTheme: IconThemeData(color: textColor),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: profileImage,
            ),
            const SizedBox(height: 10),
            Text(
              'Dean',
              style: TextStyle(color: textColor, fontSize: 20),
            ),
            const SizedBox(height: 20),
            SectionTitle(title: 'settings'.tr, color: textColor),
            CustomListTile(title: 'app_settings'.tr, icon: Icons.settings, onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AppSettings()),
              );
            }, color: textColor),
            SectionTitle(title: 'account'.tr, color: textColor),
            CustomListTile(title: 'edit_profile'.tr, icon: Icons.edit, onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditProfile()),
              );
            }, color: textColor),
            CustomListTile(title: 'change_password'.tr, icon: Icons.lock, onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ChangePassword()),
              );
            }, color: textColor),
            SectionTitle(title: 'other'.tr, color: textColor),
            CustomListTile(title: 'about_us'.tr, icon: Icons.info_outline, onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutUS()),
              );
            }, color: textColor),
            CustomListTile(title: 'faq'.tr, icon: Icons.help_outline, onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FAQScreen()),
              );
            }, color: textColor),
            CustomListTile(title: 'review_help'.tr, icon: Icons.feedback_outlined, onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ReviewAndSupport()),
              );
            }, color: textColor),
            CustomListTile(title: 'help_us'.tr, icon: Icons.favorite_outline, onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SupportUs()),
              );
            }, color: textColor),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {},
              child: const Text('Log out', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }

  ImageProvider _getProfileImage(String? photoPath) {
    if (photoPath != null && photoPath.isNotEmpty) {
      return NetworkImage(photoPath);
    } else {
      return const AssetImage('assets/default_profile.png');
    }
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  final Color color;
  const SectionTitle({super.key, required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(color: color.withOpacity(0.7), fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final Color color;

  const CustomListTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: TextStyle(color: color)),
      trailing: Icon(Icons.chevron_right, color: color),
      onTap: onTap,
    );
  }
}
