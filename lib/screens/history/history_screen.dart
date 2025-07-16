import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rewrite/model/chapter.dart';
import 'package:rewrite/model/history_entry.dart';
import 'package:rewrite/widgets/history_card.dart';
import 'package:get/get.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onBackground;
    final historyBox = Hive.box<HistoryEntry>('historyBox');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'History'.tr, 
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: textColor,
            ),
          ),
        iconTheme: IconThemeData(color: textColor),
      ),
      body: ValueListenableBuilder(
        valueListenable: historyBox.listenable(),
        builder: (context, Box<HistoryEntry> box, _) {
          final historyList = box.values.toList()
            ..sort((a, b) => b.date.compareTo(a.date)); // most recent first!!!

          if (historyList.isEmpty) {
            return Center(
              child: Text(
                'No history available.',
                style: TextStyle(color: textColor.withOpacity(0.6)),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: historyList.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final entry = historyList[index];

              return HistoryItem(
                chapter: Chapter(
                  id: entry.relatedId,
                  title: entry.title,
                  content: '',
                  lastModified: entry.date,
                ),
                novelId: entry.relatedNovelId,
              );
            },
          );
        },
      ),
    );
  }
}
