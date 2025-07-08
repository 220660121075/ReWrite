import 'package:flutter/material.dart';

class AboutUS extends StatelessWidget {
  const AboutUS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onBackground;

    return Scaffold(
      appBar: AppBar(
        title: Text('Tentang Kami', style: TextStyle(color: textColor)),
        iconTheme: IconThemeData(color: textColor),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ReWrite adalah aplikasi menulis novel dan web novel berbasis kecerdasan buatan (AI) yang dirancang untuk membantu penulis dalam proses kreatif mereka. ReWrite memungkinkan Anda membuat cerita, bab, dan karya tulis panjang lainnya dengan lebih cepat dan efisien, tanpa kehilangan gaya pribadi Anda.',
              style: TextStyle(color: textColor, fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 16),
            Text(
              'Dengan fitur seperti AI generation untuk konten cerita, proofreading otomatis, penerjemahan bahasa, dan text-to-speech, ReWrite menjadi pendamping yang ideal bagi siapa pun yang ingin menulis cerita yang menarik dan berkualitas.',
              style: TextStyle(color: textColor, fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 16),
            Text(
              'ReWrite juga mendukung penyimpanan cloud melalui Firebase, sehingga karya Anda selalu aman dan dapat diakses dari mana saja. Fokus kami adalah memberikan alat yang memungkinkan kreativitas Anda berkembang tanpa batas.',
              style: TextStyle(color: textColor, fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 16),
            Text(
              'Kami percaya setiap orang memiliki cerita untuk diceritakan. Dengan ReWrite, menulis menjadi lebih menyenangkan, mudah, dan cerdas.',
              style: TextStyle(color: textColor, fontSize: 16),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
