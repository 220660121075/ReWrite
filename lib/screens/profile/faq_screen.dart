import 'package:flutter/material.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onBackground;

    return Scaffold(
      appBar: AppBar(
        title: Text('Tentang Kami', style: TextStyle(color: textColor)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Text(
          'ReWrite adalah aplikasi cerdas berbasis teknologi kecerdasan buatan (AI) yang dirancang untuk membantu pengguna dalam menyempurnakan kualitas tulisan secara efisien dan praktis. Kami memahami bahwa menulis bukan hanya soal menyampaikan ide, tetapi juga tentang bagaimana menyusun kata dengan jelas, tepat, dan profesional. Karena itu, ReWrite hadir sebagai solusi inovatif bagi siapa pun yang ingin menulis lebih baik—baik untuk kebutuhan akademik, profesional, maupun pribadi.\n\n'
          'Dengan fitur andalan seperti parafrase otomatis, koreksi tata bahasa dan ejaan, penyusunan ulang kalimat, serta penyesuaian gaya bahasa sesuai konteks, ReWrite mampu menghadirkan teks yang lebih kuat, koheren, dan sesuai tujuan. Didukung oleh AI yang terus berkembang, aplikasi ini memungkinkan pengguna untuk mengubah draft kasar menjadi naskah akhir yang siap digunakan, hanya dalam hitungan detik.\n\n'
          'ReWrite juga mendukung integrasi dengan berbagai platform seperti Google Docs dan Microsoft Word, sehingga proses penulisan dan pengeditan dapat dilakukan langsung di lingkungan kerja yang nyaman dan familiar.\n\n'
          'Kami percaya bahwa setiap orang bisa menjadi penulis yang lebih baik, dan ReWrite hadir untuk mempermudah proses itu. Baik Anda seorang pelajar, jurnalis, dosen, content creator, atau profesional bisnis, ReWrite adalah partner menulis yang tepat untuk membantu Anda menghasilkan karya tulis terbaik.',
          style: TextStyle(color: textColor, fontSize: 16, height: 1.5),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  final List<Map<String, String>> faqItems = const [
    {
      'question': 'Apa itu ReWrite?',
      'answer':
          'ReWrite adalah aplikasi cerdas berbasis kecerdasan buatan (AI) yang dirancang untuk membantu pengguna menyempurnakan kualitas tulisan secara efisien dan praktis. Aplikasi ini menawarkan fitur seperti parafrase otomatis, koreksi tata bahasa dan ejaan, penyusunan ulang kalimat, dan penyesuaian gaya bahasa.',
    },
    {
      'question': 'Siapa saja yang bisa menggunakan ReWrite?',
      'answer':
          'ReWrite cocok untuk siapa saja yang ingin meningkatkan kualitas tulisannya, termasuk pelajar, jurnalis, dosen, content creator, penulis profesional, dan kalangan bisnis.',
    },
    {
      'question': 'Apa saja fitur unggulan ReWrite?',
      'answer':
          'Beberapa fitur utama ReWrite meliputi:\n- Parafrase otomatis untuk menghindari plagiarisme dan menyegarkan gaya penulisan\n- Koreksi tata bahasa dan ejaan secara real-time\n- Penyusunan ulang kalimat agar tulisan lebih jelas dan koheren\n- Penyesuaian gaya bahasa sesuai konteks akademik, profesional, atau santai.',
    },
    {
      'question': 'Bagaimana ReWrite bekerja?',
      'answer':
          'ReWrite menggunakan teknologi AI mutakhir untuk menganalisis dan menyempurnakan teks dalam hitungan detik. Pengguna cukup menyalin dan menempelkan teks atau mengetik langsung di aplikasi, lalu memilih fitur yang dibutuhkan.',
    },
    {
      'question': 'Apakah ReWrite bisa digunakan di Google Docs atau Microsoft Word?',
      'answer':
          'Ya, ReWrite mendukung integrasi dengan platform populer seperti Google Docs dan Microsoft Word, sehingga pengguna bisa menulis dan mengedit langsung di lingkungan kerja yang sudah mereka kenal.',
    },
    {
      'question': 'Apakah ReWrite bisa digunakan secara gratis?',
      'answer': 'Untuk saat ini semua fitur ReWrite tersedia secara gratis.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onBackground;
    final subtitleColor = textColor.withOpacity(0.7);

    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ', style: TextStyle(color: textColor)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: faqItems.length,
        itemBuilder: (context, index) {
          final item = faqItems[index];
          return ExpansionTile(
            title: Text(
              item['question']!,
              style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
            ),
            iconColor: textColor,
            collapsedIconColor: textColor,
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  item['answer']!,
                  style: TextStyle(color: subtitleColor),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
