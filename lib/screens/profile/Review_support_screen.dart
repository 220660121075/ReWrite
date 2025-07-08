import 'package:flutter/material.dart';

class ReviewAndSupport extends StatelessWidget {
  const ReviewAndSupport({super.key});

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onBackground;
    final secondaryTextColor = textColor.withOpacity(0.7);

    return Scaffold(
      appBar: AppBar(
        title: Text('Tinjauan & Bantuan', style: TextStyle(color: textColor)),
        iconTheme: IconThemeData(color: textColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tinjauan',
              style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Kami sangat menghargai masukan dari pengguna untuk terus meningkatkan kualitas aplikasi ReWrite. Berikan ulasan dan rating Anda di Play Store atau App Store.',
              style: TextStyle(color: secondaryTextColor, height: 1.5),
            ),
            const SizedBox(height: 24),
            Text(
              'Bantuan',
              style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Jika Anda mengalami kendala atau memiliki pertanyaan terkait penggunaan aplikasi, silakan hubungi tim dukungan kami melalui email berikut:',
              style: TextStyle(color: secondaryTextColor, height: 1.5),
            ),
            const SizedBox(height: 12),
            SelectableText(
              'support@rewrite.app',
              style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 16),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Fitur belum tersedia.')),
                );
              },
              icon: const Icon(Icons.open_in_new),
              label: const Text('Beri Tinjauan'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
