import 'package:hive/hive.dart';

part 'history_entry.g.dart';

@HiveType(typeId: 4)
class HistoryEntry extends HiveObject {
  @HiveField(0)
  String action; // e.g., 'Added', 'Edited', 'Deleted'

  @HiveField(1)
  String type; // e.g., 'Chapter' or 'Novel'

  @HiveField(2)
  String relatedId; // chapter.id or novel.id

  @HiveField(3)
  String relatedNovelId; // for chapters, store novelId; for novels, store the novel's own id

  @HiveField(4)
  String title; // title of the chapter or novel

  @HiveField(5)
  DateTime date; // when the action happened

  HistoryEntry({
    required this.action,
    required this.type,
    required this.relatedId,
    required this.relatedNovelId,
    required this.title,
    required this.date,
  });
}
