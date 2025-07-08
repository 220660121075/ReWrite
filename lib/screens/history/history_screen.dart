import 'package:flutter/material.dart';
import 'package:rewrite/widgets/history_card.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  final List<Map<String, String>> dummyHistory = const [
    {'action': 'Added', 'chapter': 'Chapter 3', 'date': '06/30/2025'},
    {'action': 'Edited', 'chapter': 'Chapter 2', 'date': '06/29/2025'},
    {'action': 'Fixed Typos', 'chapter': 'Chapter 1', 'date': '06/28/2025'},
  ];

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onBackground;

    return Scaffold(
      appBar: AppBar(
        title: Text('History', style: TextStyle(color: textColor)),
        centerTitle: true,
        iconTheme: IconThemeData(color: textColor),
      ),
      body: dummyHistory.isEmpty
          ? Center(
              child: Text(
                'No history available.',
                style: TextStyle(color: textColor.withOpacity(0.6)),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: dummyHistory.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final entry = dummyHistory[index];
                return GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Selected: ${entry['title']}'),
                      ),
                    );
                  },
                  child: HistoryCard(
                    action: entry['action']!,
                    chapter: entry['chapter']!,
                    date: entry['date']!,
                  ),
                );
              },
            ),
    );
  }
}
