import 'package:flutter/material.dart';

class SupportUs extends StatelessWidget {
  const SupportUs({super.key});

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onBackground;
    final fadedColor = textColor.withOpacity(0.7);

    return Scaffold(
      appBar: AppBar(
        title: Text('Dukung Kami', style: TextStyle(color: textColor)),
        iconTheme: IconThemeData(color: textColor),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mengapa mendukung ReWrite?',
              style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Dengan dukungan Anda, kami dapat terus mengembangkan fitur baru, meningkatkan performa, dan menyediakan layanan terbaik bagi semua pengguna ReWrite.',
              style: TextStyle(color: fadedColor, height: 1.5),
            ),
            const SizedBox(height: 24),
            Text(
              'Cara mendukung kami:',
              style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '• Berikan ulasan positif di Play Store atau App Store\n• Bagikan ReWrite kepada teman dan rekan kerja\n• Ikuti kami di media sosial',
              style: TextStyle(color: fadedColor, height: 1.5),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Fitur belum tersedia.')),
                );
              },
              icon: const Icon(Icons.favorite),
              label: const Text('Dukung Sekarang'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white
              ),
            ),
          ],
        ),
      ),
    );
  }
}
