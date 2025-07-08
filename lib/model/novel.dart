import 'package:hive/hive.dart';
import 'chapter.dart';

part 'novel.g.dart';

@HiveType(typeId: 0)
class Novel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String coverImage;

  @HiveField(4)
  final List<String> genres;

  @HiveField(5)
  final DateTime createdDate;

  @HiveField(6)
  final List<Chapter> chapters;

  Novel({
    required this.id,
    required this.title,
    required this.description,
    required this.coverImage,
    required this.genres,
    required this.createdDate,
    required this.chapters,
  });

  factory Novel.fromMap(Map<String, dynamic> map) {
    return Novel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      coverImage: map['coverImage'],
      genres: List<String>.from(map['genres']),
      createdDate: DateTime.parse(map['createdDate']),
      chapters: (map['chapters'] as List<dynamic>)
          .map((e) => Chapter.fromMap(e))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'coverImage': coverImage,
      'genres': genres,
      'createdDate': createdDate.toIso8601String(),
      'chapters': chapters.map((e) => e.toMap()).toList(),
    };
  }
}
