import 'package:hive/hive.dart';
import 'package:rewrite/model/history_entry.dart';

class HistoryLogger {
  static void log({
    required String action,
    required String type,
    required String relatedId,
    required String relatedNovelId,
    required String title,
  }) {
    final historyBox = Hive.box<HistoryEntry>('historyBox');
    historyBox.add(
      HistoryEntry(
        action: action,
        type: type,
        relatedId: relatedId,
        relatedNovelId: relatedNovelId,
        title: title,
        date: DateTime.now(),
      ),
    );
  }
}
